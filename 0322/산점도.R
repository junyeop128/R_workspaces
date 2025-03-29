# 산점도 그래프 만들기
#  산점도(scatter): 두 변수 간의 관계를 시각적으로 나타낸 것
# ex) 키와 몸무게 간의 상관관계, 온도와 에너지 소비량의 관계

# 그래프 기본 만들기
# install.packages("ggplot2") # 그래프 설치
library(ggplot2)
library(plotly) # 그래프 이벤트 로드

# 데이터 생성
# 중간고사 점수와 기말고사 점수를 산점도 그래프로 표현
# 1부터 10까지 생성( 학생 아이디) 
students=data.frame(ID=1:10,Midterm=c(87,59,68,97,84,76,65,90,72,88),Final=c(85,62,70,95,89,80,67,98,75,200)) 
# View(students)

# 산점도 그래프 생성
# data=students : 그래프에 추가할 데이터의 프레임
# ase: Aesthetics (미적,미학) 
# x축: 중간고사 점수, y축: 기말고사 점수
# geom_point(size=2) : 산점도 그래프 내 점의 크기 조정
# labs: laboratory  : 타이틀
# 회귀선 추가: geom_smooth() , method='lm': linear motion
# par(mfrow=c(1,2)) : 여러 그래프를 한 화면에 나타내기
p=ggplot(data=students, aes(x=Midterm,y=Final)) + geom_point(aes(text=paste("ID:",ID)),size=2) + geom_smooth(method='lm',se=FALSE,col='pink') + labs(title = "중간고사 vs 기말고사 성적 분포도",x="중간고사 점수",y="기말고사 점수")
p=ggplotly(p) # 인터랙티브 그래프 변환
# print(p)

# 작성한 그래프 pdf 파일로 만들기 (논문이나 보고서 작성 시 활용)
# ggsave('산점도그래프.pdf')
# aes(text=paste("ID:",ID)) : 
# 경계선 제거하고 회귀선만 추가하고 싶을 때: se=FALSE

# install.packages('plotly') # 그래프 이벤트 설치 # alt+enter


