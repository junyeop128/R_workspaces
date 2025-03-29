library(dplyr) # 전처리 도구
library(ggplot2) # 시각화 도구

library(sf) # 지도 시각화 
library(ggiraph) # 지도 시각화 이벤트

korea_map=st_read('sig.shp')
# 서울 지역만 가져오기 
seoul_map=korea_map %>% filter(substr(SIG_CD,1,2)=='11') # 서울만 가져오기 (지역번호=11)

# 상권분석(csv 파일 불러오기)
seoul_comm_data=read.csv('seoul_commercial_analysis.csv',fileEncoding = 'CP949',encoding='UTF-8',check.names = FALSE)

# 퀴즈
# seoul_commercial_analysis.csv확인 후 
# 컬럼 '자치구_코드' 생성 후 기존 '자치구 코드'를 문자로 형변환해서 대입 # why? 
# 1) 데이터프레임 구조 확인
print(str(seoul_comm_data)) # 구조 확인 str
# 2) 형변환
seoul_comm_data=seoul_comm_data%>%mutate(자치구_코드=as.character(자치구_코드))
# 자치구_코드를 문자로 바꾼 이유? shp(지도) 파일에 자치구 코드가 있는데, 지도파일에 자치구 코드가 문자형이므로 일치시키기 위해
# 왜? 병합(join)하기 위해
# 3) 지도 데이터(shp)와 상권 데이터(csv) 병합하기
# seoul_map에 있는 SIG-CD와 seoul_comm_data에 있는 자치구_코드를 기준으로 두 파일 병합
merged_data=inner_join(seoul_map,seoul_comm_data,by=c("SIG_CD"="자치구_코드"))
# View(merged_data)

# 퀴즈) SIG_CD, 자치구 코드 명, geometry(위,경도)를 그룹핑해서 23년 1월부터 25년 1월까지 '폐업 영업 개월 평균'의 평균 산출
# 폐업 영업 평균이 60이하이면 high, 아니면 normal을 나타내는 위험도 컬럼 추가

# 전처리 
data1=merged_data%>%group_by(SIG_CD,자치구_코드_명,geometry)%>%summarise(영업평균= mean(폐업_영업_개월_평균))%>%
  mutate(위험도= ifelse(영업평균<=60,'High','Normal'))
# View(data1) 

# 사분위수를 이용해서 특정 구간 알고 싶을때 (상위 25프로만 알고 싶을때)
quantiles=quantile(merged_data$영업평균)
data1=merged_data%>%filter(영업평균 >= quantiles["75%"])
View(data1)

# 지도 시각화 처리
p = ggplot(data=data1) + 
  scale_fill_gradient(low="#ececec",high="blue",name="영업평균") + 
  geom_sf_interactive(aes(
    fill=영업평균, # 영업 평균 데이터를 지도에 채우기
    tooltip=자치구_코드_명,
    data_id=SIG_CD)) + #마우스 호버 이벤트
  theme_minimal() + 
  labs(title="서울시 폐업 평균 개월",x="경도",y="위도")

girafe_plot=girafe(ggobj = p) # 인터랙티브 지도 생성
# print(girafe_plot) # 지도 출력
























