# R 디렉토리 변경
setwd('D:/R-data')
getwd()
print(list.files()) # 해당 경로 파일 확인

# csv 파일 불러오기
data=read.csv('student_data.csv')

# View(data)

# 각 과목의 평균 점수
#1) math의 평균점수
math=mean(data$Math)
cat('평균점수:',math,'\n')
science=mean(data$Science)
cat('평균점수:',science,'\n')
english=mean(data$English)
cat('평균점수:',english,'\n')

# z컴퓨터 총합
computer=sum(data$Computer,na.rm=TRUE) # na.rm=TRUE 결측값 제거
print(computer)

# 영어과목 표준편차  # 영어 값들이 평균으로부터  +- 4.9만큼 퍼져있다는 것을 의미
english=sd(data$English)
print(english)

# 과학 중앙값 
science=median(data$Science)
print(science)

# 수학 사분위수 
math=quantile(data$Math)
print(math)

# 수학과목의 최대, 최소
math_max=max(data$Math)
print(math_max)
math_min=min(data$Math)
print(math_min)

# table
print(table(data$English)) # 점수별 인원 통계

# 데이터프레임 기초 통계량 전체 확인 -> summary() 사용 시, 컬럼 별 기본 통계 확인
print(summary(data))

install.packages("ggplot2")
library("ggplot2")

graph_data=data.frame(
  x=c('수학평균,'과학평균','영어평균')
)


