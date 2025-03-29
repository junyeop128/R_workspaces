# 선그래프
# 순서가 있는 변수를 x축에 배치, 이에 따른 y축값의 변화를 선으로 연결하여 시각화하는 그래프
# 시간의 흐름에 따른 데이터를 표현 시, 많이 사용

library(dplyr) # 전처리 도구
library(ggplot2) # 시각화 도구

# 데이터프레임 생성
data1=data.frame(Time=c("2025-03-01","2025-03-02","2025-03-03"),Revenue=c(300,500,2500)) # 시간별 수익 
# 문자형을 날짜형으로 변환
data1$Time=as.Date(data1$Time) # 문자->날짜
# 선 그래프 생성
p=ggplot(data=data1,aes(x=Time,y=Revenue)) + geom_line(color="blue") +  # 선 그래프 설정
labs(title="시간에 따른 수익금",x="날짜",y="수익금")
print(p)

