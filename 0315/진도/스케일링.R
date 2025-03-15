## 실무, 시험 동시 중요, 적용
## 데이터 스케일링: 데이터분석 및 머신러닝에서 중요한 전처리 과정
# 변수의 크기를 조정하여, 성능을 향상시키거나 결과를 해석하기 용이하게 만듦.
# 성능(머신러닝 성능): 학습을 더 빠르게 함

# MIN-MAX 정규화: 데이터를 0~1 사이로 변환하는 데이터 전처리 기법
# 데이터프레임을 하나 생성
data=data.frame(height=c(150,160,170,180,190),weight=c(50,60,70,80,90))
# View(data)
# 키와 몸무게는 단위와 범위가 상이하므로, 두 데이터를 그대로 비교하거나 분석하기 어렵
# 이를 해결하기 위해, 키와 몸무게를 0에서 1 사이로 스케일링하면, 두 변수는 동일한 기준에서 비교 가능
# 공식: 스케일링값= 원래 값-최소값 / (최대값-최소값)

height_mean=min(data$height) # 키의 최솟값
height_max=max(data$height) # 키의 최댓값

data$scaled_height=(data$height-height_mean)/(height_max-height_mean)
print(data$scaled_height)

weight_min=min(data$weight) # 키의 최솟값
weight_max=max(data$weight) # 키의 최댓값

data$scaled_weight=(data$weight-weight_min)/(weight_max-weight_min)
print(data$scaled_weight)
# View(data$scaled_weight)


# emp 데이터에서 급여(SAL)열에 대해 민맥스 정규화 실시 후(sal_minmax 컬럼 추가), dplyr로 0.5보다 큰 값을 가지는 데이터 추출
emp= read.csv('emp.csv')
library(dplyr)

sal_min=min(emp$SAL,na.rm=TRUE)
sal_max=max(emp$SAL,na.rm=TRUE) 

emp$sal_minmax=(emp$SAL-sal_min)/(sal_max-sal_min)
View(emp)

result=emp%>%filter(sal_minmax>0.5) %>% select(ENAME,SAL,sal_minmax)%>%arrange(desc(sal_minmax))
View(result)
