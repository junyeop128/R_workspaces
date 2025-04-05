# 독립표본
# 서로 다른 두 집단 비교
# ex. 남녀 소비 패턴 차이 분석, 교육 방법에 따른 영업사원 실적 분석
data=read.csv("korean_scores.csv")
print(str(data))
# View(data)
# 남녀 국어 점수 비교
# 성별로 국어점수 평균과 표준편차, 학생수를 필터링
library(dplyr)
data1=data%>%group_by(gender=='Male')%>%summary(Mean=mean(korean_score),SD=sd(korean_score),N=n())
# View(data1)
# ~ : 왼쪽 변수를 오른쪽 변수 기준으로 분석한다.
# korean_score(국어점수)를 gender(성별) 기준으로 그룹을 나누어 T 검정을 수행
# 예) 광고비 100만원을 올렸을 때, 구독자가 1,000명 증가
t_test_result=t.test(korean_score~gender,data=data1) 
if(t_test)
  