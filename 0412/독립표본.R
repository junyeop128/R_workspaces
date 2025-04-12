# 서로 다른 두 집단 비교: 독립표본
library(dplyr)
library(ggplot2)

# 남/여 국어점수 비교
score_data=read.csv('korean_scores.csv')
# View(score_data) 

# 성별에 따른 국어점수 비교
# korean_score~gender : 국어를 성별 기준으로 t-검정을 수행
t_test_result=t.test(korean_score~gender,data=score_data)
if(t_test_result$p.value<=0.05){
  print('성별에 따른 국어 점수 차이가 있을 가능성이 있어!')
}else{
  print('성별에 따른 국어점수 차이는 없어!')
} # 0.293

# 박스플롯 생성 (성별로 채울건데scale_fill_manual(values=c('Male'='lightblue','Female'='pink') 이걸로 채울거여)
p=ggplot(score_data,aes(x=gender,y=korean_score,fill=gender)) +
  geom_boxplot() + scale_fill_manual(values=c('Male'='gold','Female'='green')) +
  labs(title="성별에 따른 국어점수",x="성별",y="국어점수") + theme_minimal() # 회색배경 제거
print(p)
