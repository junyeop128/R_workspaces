# R에서 자주 사용하는 통계 
data1=c(10,20,30,40,50)

# 평균계산
avg=mean(data1)
cat('평균 : ',avg,'\n') # 30

# 중앙값 계산
middle=mean(data1)
cat('중앙값 : ',middle,'\n') # 30

# 최빈값 계산
data1=c(10,20,20,20,30,40,40,50)
# install.packages('DescTools') # 최빈값 구해주는 기능
library(DescTools)
value=Mode(data1)
cat('최빈값 : ',value,'\n') # 20 
# 주로 직원들 급여가 어디에 많이 분포하고 가장 많이 있는 값이 무엇인지 파악

# 표준편차 계산(데이터의 분포도 파악)
# 표준편차는 데이터의 흩어짐을 원래 데이터 단위로 표현
standard_de=sd(data1)
cat('표준편차 : ',standard_de,'\n') # 13.56203
        
# 분산: 제곱된 단위(모든값을 양수로 만들어 합산하기 위해 사용)
# 절댓값은 미분이 불가능하므로, 제곱은 미분과 같은 수학적 조작이 가능해 통계 이론 전개애 유리
variance=var(data1)
cat('분산 : ',variance,'\n') # 183.9286

# 표준오차: 모집단에서 전체를 조사하지 않고 표본 추출하여 조사 시, 발생하는 오차
# ex) 전교생이 1,000명(모집단) 중 이 학교에 평균 키를 알고 싶음
# 시간이 부족해서 50명만 랜덤으로 키를 조사했다고 가정 시
# 이 50명 평균 키가 모집단 평균 키와 다를 가능성이 있음
# 이 차이가 표준오차임

# 임시 데이터 생성
people=rnorm(1000,mean=170,sd=10) # 1,000명의 평균 키가 170, 표준편차 10
# print(people)

# 모집단 평균과 표준편차
people_mean=mean(people)
cat('모집단 평균 : ',people_mean,'\n') 
people_sd=sd(people)
cat('모집단 표준편차 : ',people_sd,'\n')

# 표본추출(50명)
sample_size=50

# 표준오차 계산
sem=people_sd / sqrt(sample_size)
cat('표준오차 : ',sem,'\n')






