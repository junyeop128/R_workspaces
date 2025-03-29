library(dplyr) # 전처리 도구
library(ggplot2) # 시각화 도구

library(sf) # 지도 시각화 
library(ggiraph) # 지도 시각화 이벤트

korea_map=st_read('sig.shp')
# View(korea_map) 
# print(str(korea_map)) # 문자형
seoul_map=korea_map %>% filter(substr(SIG_CD,1,2)=='11') 

# 미세먼지 데이터 불러오기
dust_data=read.csv('data.csv',fileEncoding = 'CP949',encoding='UTF-8',check.names = FALSE)
# View(dust_data)

# 퀴즈) 미세먼지 station_code(지역코드)
# join 이용해서 shp 파일과 data.csv 병합

# print(str(dust_data)) # 숫자형
# 데이터 타입이 동일해야만, 조인이 가능하므로, 형변환이 필수!!
# 문자로 형변환 실시
dust_data$station_code=as.character(dust_data$station_code)
merged_dust_data=inner_join(seoul_map,dust_data,by=c("SIG_CD"="station_code"))
# View(merged_dust_data)

# 지도 시각화 (simple version) : 자도는 x,y 이미 정해짐
p=ggplot(data=merged_data)+geom_sf(aes(fill=pm10_concentration_ug_m3),color="black")+
  scale_fill_gradient(low="yellow",high="red",name="농도")+ theme_minimal() + labs(title = "서울시 미세먼지 농도",x="경도",y="위도")
print(p)



                            


