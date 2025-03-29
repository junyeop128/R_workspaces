# 산점도 그래프 -> 두 개의 변수 확인  ex) 키와 몸무게, 중간 vs 기말
# 막대 그래프 -> 그룹별 빈도나 크기를 비교 시 ex) 판매량 비교, 직업별 소득
# 박스 플롯 -> 데이터의 분포를 시각적으로 표현 ex) 각 반 또는 학년별 성적분포, 주식차트

# 오늘 배울 그래프 -> 선 그래프, 지도 시각화

# 산점도 그래프 복습
# 출신 연도와 영화 길이 간 관계 파악
# install.packages("dplyr")
# install.packages("ggplot2")
library(dplyr) # 전처리 도구
library(ggplot2) # 시각화 도구
setwd('D:/R-DATA') # 데이터 불러오기
netflix_data=read.csv('netflix.csv')
# 데이터 확인
# View(netflix_data)
# 데이터 전처리
# **** 문자열 복습
# gsub: 다른 문자로 대체
# strsplit: 특정 문자를 기준으로 나누다
# substr: 특정 위치 문자만 추출(오려내기)
# 영화의 상영시간을 알아내기 (type과 duration)
movie_data=netflix_data %>% filter(type=='Movie') %>% mutate(gsub_duration=as.numeric(gsub(' min',"",duration))) 
# 90 min: 공백을 포함한 문자열(min)까지 추출하여 공백 처리
# duration 컬럼 데이터( min)을 ""로 대체
# ' min'을 제거한 새로운 컬럼 생성
# View(movie_data)

# 산점도 그래프 생성
# 1. data=movie_data: 그래프에 데이터 삽입
# 2. aes: 그래프 x,y축 설정
# 3. 산점도 생성
p = ggplot(data=movie_data, aes(x=release_year,y=gsub_duration)) + geom_point() + geom_smooth(method = "lm",color="red")+ # 산점도 생성 함수 + 회귀선 추가
  labs(title="영화 길이 vs 출시연도",x="출시연도",y="영화길이(분)")

print(p)









