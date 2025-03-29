# 퀴즈: 건강검진 파일을 이용하여 신장과 몸무게의 관계를 산점도로 표현(단, x축은 신장, y축은 체중, 회귀선 추가할 것)

library(dplyr)
setwd("D:/R-DATA")
# 컬럼이 한글이거나 괄호 등이 있을 때,처리하는 방법: fileEncoding = 'CP949'(컬럼이 한글일때) , encoding = "UTF-8"(괄호 인식하기)
health_data =read.csv('health.csv',fileEncoding = 'CP949',encoding = "UTF-8",check.names = FALSE)

library(ggplot2)
library(plotly)
# 코드 색상표 참조

# p=ggplot(health_data, aes(x=`신장(5cm단위)`,y=`체중(5kg단위)`)) + 
#   geom_point()+
#   geom_smooth(method='lm',se=FALSE,color='#d2bce5')
#   + labs(title = '신장과 체중 관계',x='신장(cm)',y='체중(kg)')

p = ggplot(health_data, aes(x = `신장(5cm단위)`
                            , y = `체중(5kg단위)`)) + 
  geom_point() +
  geom_smooth(method = "lm", color = "#a49bf2") +
  labs(title = '신장과 체중 관계',
       x = '신장(cm)',
       y = '체중(kg)' )

# print(p)


# 혈색소와 BMI의 관계 파악
# BMI 구하기 (체중/(신장/100)^2)
# 혈색소가 높은 사람은 세모 표시 그 외 동그라미, 혈색소가 높으면 심장마비, 뇌줄중 발생할 가능성이 높음, 남자와 여자를 구분

#  디플리알을 이용해 전처리 작업 실시 (mutate로 bmi 구하기)
# 혈색소가 높은 사람은 세모 표시 : 혈색소가 16이 넘으면 높은 것
health_data2=health_data%>%mutate(BMI=`체중(5kg단위)`/(`신장(5cm단위)`/100)^2,Grade=ifelse(혈색소>=16,"High","Normal"),Gender=ifelse(성별==1,"Male","Female"))
# View(health_data2)

# 전처리 후 그래프 표현
p=ggplot(health_data2,aes(x=혈색소,y=BMI))+geom_point(aes(color=Gender,shape=Grade),size=1.5)+scale_color_manual(values=c("Male"="purple","Female"="pink"))+
  scale_shape_manual(values=c("High"=17,"Normal"=16)) + geom_smooth(method = "lm",color="orange") + labs(title="BMI와 혈색소 관계",x="혈색소",y="BMI",color="Gender",shape="Grade")+
  theme_minimal() # 뒤에 회색 배경 지우기

# print(p)

# ggsave('건강검진_산점도.pdf')

# 퀴즈 
# 연령코드가 5~8번이고, 지역코드가 41번인 사람의 허리둘레(x축)와 식전혈당(공복혈당)(y축) 관계를 그래프로 표현
# 1) 단, 남성은 파랑색, 여성은 빨간색 표기
# 2) 식전혈당(공복혈당) 100 이상은 별 모양(11번) 그 외 동그라미로 표기하기
# 3) pdf로 저장할 것 

## 전처리)
health_data3=health_data%>%filter(`연령대코드(5세단위)`=5:8 & 시도코드==41)%>%mutate(Gender=ifelse(성별==1,"Male","Female"),Grade=ifelse(`식전혈당(공복혈당)`>=100,"High","Normal"))%>%
select(허리둘레, `식전혈당(공복혈당)`,Gender,Grade)
View(health_data3)

## 그래프) 
p=ggplot(health_data3,aes(x=허리둘레,y=`식전혈당(공복혈당)`)) + geom_point(aes(color=Gender,shape=Grade),size=1.0)+scale_color_manual(values=c("Male"="blue","Female"="red")) +
  scale_shape_manual(values=c("High"=11,"Normal"=16)) +  geom_smooth(method = "lm",color="orange") + labs(title="허리둘레와 공복혈당 간의 관계",x="허리둘레",y="식전혈당(공복혈당)",
  color="Gender",shape="Grade") + theme_minimal() 
print(p)
pdf.options(family="Korea1deb")
ggsave('허리둘레_산점도.pdf')

## 이상치 제거

























                        
                                                                     
                                                                                                  


















