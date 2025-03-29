# Box-Plot (데이터 분포를 시각적으로 나타낸 그래프)
# 데이터의 최소, 최대, 중앙값, 최빈값 등 요약 통계치를 보여줌
# ex) 학생들의 시험 성적을 분석할 때 -> 각 반 또는 학년별 성적 분포를 비교할 때 유용
# ex) 제조기업에서 생산 공정 비교할 때 -> 각 기계의 출력값이 정상 범위를 벗어나는지 확인 시 유용

# 나이별 소득을 박스플롯으로 표현
library(dplyr)
library(ggplot2)

people=read.csv('age_income.csv')
# View(people)

# 1) 연령대 분류 필터링
people=people%>%mutate(ageg=ifelse(age<30,'young',ifelse(age<=59,"middle","old")))
# View(people)

# 2) 연령대별 income의 평균
# !is.na(income) : 결측값이 아니라면
avg_income=people%>%filter(!is.na(income))%>%group_by(ageg)%>%summarise(mean_income=mean(income))
# View(avg_income)

# 3) 박스플롯 생성
p=ggplot(data=people,aes(x=ageg,y=income,fill=ageg)) + geom_boxplot() + # 박스플롯 생성 
  labs(title="연령대별 수입 분포",x="연령대",y="수입") + scale_x_discrete(
    limits=c("young","middle","old")) +  # scale_x_discrete() : x축을 분리
    theme_minimal() # 뒤 회색배경 제거
print(p)
pdf.options(family="Korea1deb")
ggsave('boxplot1.pdf')

   