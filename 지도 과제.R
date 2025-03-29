library(dplyr) # 전처리 도구
library(ggplot2) # 시각화 도구

library(sf) # 지도 시각화 
library(ggiraph) # 지도 시각화 이벤트
seoul_data=read.csv('상권분석서비스.csv',fileEncoding = 'CP949', 
                    encoding = 'UTF-8', 
                    check.names = FALSE)

# 1) # 지도로 2024년도 총 직장 인구수가 가장 많은 자치구 5개만 지도로 표현
korea_map=st_read('sig.shp')
seoul_map=korea_map %>% filter(substr(SIG_CD,1,2)=='11') 

print(str(korea_map)) # 문자형
print(str(seoul_data)) # 숫자형

# seoul_data의 총_직장_인구_수를 문자형으로 형 변환
seoul_data$자치구_코드=as.character(seoul_data$자치구_코드)
# 병합 시행
merged_data=inner_join(seoul_map,seoul_data,by=c("SIG_CD"="자치구_코드"))
# View(merged_data)

# 전처리 
data1=merged_data%>%group_by(SIG_CD,자치구_코드_명,geometry)%>%summarise(총인구수= sum(총_직장_인구_수))
View(data1)

# 지도 시각화 처리
p = ggplot(data=data1) + 
  scale_fill_gradient(low="#ececec",high="blue",name="영업평균") + 
  geom_sf_interactive(aes(
    fill=총인구수, # 영업 평균 데이터를 지도에 채우기
    tooltip=자치구_코드_명,
    data_id=SIG_CD)) + #마우스 호버 이벤트
  theme_minimal() + 
  labs(title="총 직장 인구수",x="경도",y="위도")

girafe_plot=girafe(ggobj = p) # 인터랙티브 지도 생성
print(girafe_plot) # 지도 출력

# 2) 24년도 서울 총 직장인 인구 수 대비 각 자치구 직장인 인구 수 비율 구하기 #  group_by sum 이용