
## 이상치 제거: 대표적 알고리즘
# 1) Z-score 변환
# z-score 공식: Z= (원본 데이터 값 - 평균) / 표준편차

# Z-score가 0이면 데이터 값이 평균과 동일하며, 양수이면 평균에서 멀리 떨어져 있음

# 데이터 프레임 생성
students= data.frame(Student=c('Alice','Bob','Charlie','David','Jose'),Score=c(50,60,70,80,200))
mean_score=mean(students$Score) # 스코어 평균 구하기
print('평균 :')
print(mean_score) 

# 이상치를 이용해서 튄 데이터 제거
# Z= (원본 데이터 값 - 평균) / 표준편차

students$z_score=(students$Score-mean(students$Score)) / sd(students$Score)
# View(students$z-score)

# 조제 z-score:1.7
students$z_score=abs(students$z_score)
# View(students)

# 1.5: 임계값, 상황에 따라 조절이 가능하지만, 일반적으로 2~3인 값을 이상치로 간주 ***
students$is_outlier=students$z_score>=1.5
# View(students$is_outlier)

# z-score는 정규분포에서 값이 얼마나 평균으로부터 떨어져 있는지 알려줌.

# emp.csv를 이용해서 사원의 급여를 z_score를 활용하여 이상치를 탐지하고, 임계값을 2로 설정할 때, 임계값이 2이상인 사원 조회

library(dplyr)
emp=read.csv('emp.csv')
emp$z_score=emp%>%mutate(z_score=abs((SAL-mean(SAL)) / sd(SAL)),is_outlier=ifelse(z_score>=2,TRUE,FALSE))
result= result %>% filter(is_outlier) ## is_outlier==TRUE 같음.

View(result)

















