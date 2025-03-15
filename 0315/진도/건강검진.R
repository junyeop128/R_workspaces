# 한국어 파일의 경우, CP949 또는 EUC-KR 인코딩을 사용하는 것이 일반적
# 데이터셋 읽기
# fileEncoding = 'CP949': 한글 컬럼 읽기
setwd("D:/R-DATA")
health = read.csv('health.csv', 
                  fileEncoding = 'CP949')
# View(health)
print(health$시력.우.)

# 문제 1: dplyr 패키지를 로드해주세요.
library(dplyr)
# 문제 2: csv 파일을 불러오세요.
health=read.csv("health.csv") 

# 문제 1: 데이터프레임의 앞부분 출력 단, 2행만
print(head(health,2))
# 문제 2: 데이터프레임의 뒷부분 출력 단, 5행만
print(tail(health,5))
# 문제 3: 데이터프레임의 구조 확인
print(str(health))

# 문제 1: 데이터셋에서 성별, 연령대, 그리고 지역 열만 선택하세요.
result1=health%>%select('성별','연령대','지역')
print(result1)

# 문제 2: 2022년에 건강검진을 받은 사람들만 필터링하세요.
result2=health%>%filter(기준년도==2022)
print(result2)

# 문제 3: 키(height)와 몸무게(weight) 열을 사용하여 새로운 열 BMI를 추가하세요. : (키/100)^2
re_a=health%>%select(`신장`)
re_b=health%>%select(`체중`)
BMI=health%>%mutate(BMI_a=re_b/(re_a/100)**2)
print(BMI)

# 문제 4: 건강검진 결과를 기준으로 수축기 혈압 값을 내림차순으로 정렬하세요.
result4=health%>%arrange(desc('수축기 혈압'))
print(result4)

# 문제 5: 성별(성별)로 데이터를 그룹화하고, 각 그룹별 평균 BMI를 계산하세요. 결과는 성별과 평균_BMI 열로 구성되어야 합니다.
result5=health%>%group_by(성별)%>%summarise(avg_bmi=mean(BMI))%>%select('성별','avg_bmi')
print(result5)

# 연령대별 평균 체중 계산
result6=health%>%group_by(연령대코드.5세단위.)%>%summarise(avg_weight= mean(체중.5kg단위.,na.rm=TRUE))
print(result6)

# 문제: 시도코드별로 평균 신장(5CM 단위)를 게산하고, 가장 높은 신장을 가진 시도코드 추출
result7=health%>%group_by(시도코드)%>%summarise(평균신장=mean(신장.5cm단위.,na.rm=TRUE))%>%arrange(desc(평균신장))%>%slice_head(n=1)
print(result7)

# 음주여부에 따라 체중과 허리둘레의 상관관계 알기 (1은 TRUE, 0은 FALSE)
# use="complete.obs" : 상관계수를 계산 시 결측값을 포함된 데이터는 제외하고 계산
drinking = health%>%group_by(음주여부)%>%summarise(상관계수=cor(체중.5kg단위.,허리둘레,use="complete.obs"))
View(drinking)
# 상관계수는 보통 -1~1 사이의 값을 가짐
# 1에 근접할 수록 완벽한 선형관계를 가짐
# -1에 근접할 수록 한 변수가 증가 시, 다른 변수는 감소형태를 보임
# 0이면, 두 변수 간 관계 없음











