library(dplyr) # 전처리 도구
library(ggplot2) # 시각화 도구

library(sf) # 지도 시각화 
library(ggiraph) # 지도 시각화 이벤트

# 1. 지도 생성하기
korea_map=st_read('sig.shp')
View(korea_map) 

# 2. 지도 시각화
p=ggplot(data = korea_map)+ geom_sf(fill="black",color="white")+
  theme_minimal() + labs(title="대한민국 지도",x="경도",y="위도") + coord_sf()
# print(p)

# 대전 지역 추출
daejeon_map=korea_map %>% filter(substr(SIG_CD,1,2)=='30') 
print(p) 




