# 복습
# (1) 데이터프레임

# 경로 확인
print(list.files())
print(getwd())  # getwd: Get Working Directory(불러오는 역할)
setwd("D:/R-DATA") 

# 파일 불러오기
emp=read.csv('emp.csv')
# View(emp)

### 암기(시험 단골)
# (1) 행/열의 수 확인
print(dim(emp))
# (2) 데이터 상위 1~4행까지
print(head(emp,4)) 
# (3) 데이터 하위 1~4행까지
print(tail(emp,4))
# (4) 데이터 프레임 '데이터 타입 확인'
print(str(emp))
# (5) 특정 열 출력(ENAME만 출력)
print(emp$ENAME) 
# (6) dplyr(data frame plier): 데이터 프레임을 다루는 공구
# install.packages("dplyr") # 처음에만 설치 필요
library(dplyr) 
# 데이터 프레임을 이용한 특정 열 출력
emp_ENAME=emp%>%select(ENAME)
print(emp_ENAME)
# 필터링 후 select 
emp_DATA=emp%>%filter(SAL>=2000 & DEPTNO==20)%>%select(ENAME,JOB,DEPTNO)
print(emp_DATA)
# filter: 행 필터링 
# select: 특정 벡터(열) 선택
# mutate: 새로운 벡터(열) 추가
# arrange: 정렬(오름차순/내림차순)
# group_by+summarize: 데이터 그룹 + 데이터 요약
# join: 여러 데이터프레임 '병합'
# slice: 지정된 행 번호에 해당하는 행 선택(head,tail)

