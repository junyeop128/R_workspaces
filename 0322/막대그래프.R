library(ggplot2)


netflix_data=data.frame(
  Show=c("나의 완벽한 비서","중증외상센터","말할 수 없는 비밀","체크인 한양","별들에게 물어봐"),ViewerShip=c(90,98,93,66,39)
)

# 바 그래프 생성
p=ggplot(data=netflix_data,aes(x=Show,y=ViewerShip)) +
  geom_col(fill="steelblue") + # 막대그래프 색상 채우기 
  labs(title="넷플릭스 인기 프로그램 시청률",x="프로그램명",y="시청률(백만)")
# print(p)
# ggsave('막대그래프.pdf')

library(dplyr)
library(ggplot2)
setwd('D:/r-data') 
# 컬럼이 한글일 때 fileEncoding = 'CP949'
health_data = read.csv('health.csv',
                       fileEncoding = 'CP949',
                       encoding = "UTF-8",
                       check.names = FALSE
)

# 막대그래프: 범주형 데이터의 빈도나 크기를 비교할 시 사용되면, ex) 제품별 판매량 비교, 작업 별 평균 소득
# 연령대별 허리둘레 그래프 구현
graph_data=health_data %>% filter(성별==1) %>% group_by(`연령대코드(5세단위)`) %>% summarise(평균허리둘레 = mean(허리둘레, na.rm=TRUE))
# View(graph_data)

p=ggplot(data=graph_data,aes(x=`연령대코드(5세단위)`,y=평균허리둘레,)) + geom_col(fill="purple") + labs(title="연령대코드 별 허리둘레",x="연령대 코드",y="허리둘레")
# print(p)

# 성별로 혈정지피티(ATL) 평균를 그래프로 표현(단,연령대코드가 3~6사이) # GENDER라른 컬럼 추가 남자 male, 여성 female 
graph_data=health_data %>% filter(`연령대코드(5세단위)`>=3 & `연령대코드(5세단위)` <=6) %>% group_by(성별) %>% summarise(avg_atl=mean(`혈청지피티(ALT)`),na.rm=TRUE) %>%
  mutate(Gender=ifelse(성별==1,"Male","Female"))

#labs(title="성별 평균 혈청지피티",x="성별",y="평균 ATL") : 색상 수동 지정

p=ggplot(data=graph_data,aes(x=성별,y=avg_atl,fill=Gender))+
  geom_col()+
  scale_fill_manual(values=c("Male"="blue","Female"="red"))+ 
  labs(title="성별 평균 혈청지피티",x="성별",y="평균 ATL")
# print(p) 
pdf.options(family="Korea1deb")
ggsave('ATL.pdf')
   

































