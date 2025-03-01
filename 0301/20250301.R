## CSV(Comma-Separated-Values)
## CSV(데이터분석 데이터)->콤마로 구성된 데이터
## CSV파일은 데이터분석에서 많이 사용
## 장접: 광범위한 호환성(R,파이썬,C언어,....)
## CSV<- 데이터프레임<---- 분석하고 시각화 
## R 저장, 불러오는 파일 경로 수정
setwd('D:/R-data'); # D 드라이브에 r-data 폴더로 경로 수정
print(list.files()) # 현재 경로에 있는 파일 목록 출력

# 액셀파일 불러오기
emp=read.csv('emp.csv') 
#View(emp)

print(head(emp,5))
print(dim(emp))
print(str(emp)) # 데이터프레임 열 데이터 타입 확인

# emp 데이터프레임 생성
# empNO : 사원번호
# ENAME : 사원이름
# JOB : 직책
# MGR : 사수번호
# HIREDATE : 입사날짜
# SAL : 급여
# COMM : 보너스
# DEPTNO : 부서번호

# 데이터 행 변환
# 가정) SAL 데이터에 숫자가 아닌 문자를 입력 시, 숫자로 강제 변환하는 작업

# 예제 문자-> 숫자로 변환
num=c('100','200','300') # 문자로 인식
# num * 2에서 다음과 같은 에러가 발생했습니다: 이항연산자에 수치가 아닌 인수입니다
num=as.numeric(num)
num=num*2 
print(num)

num2=c(100,200,300)
# 숫자-> 문자
num2=as.character(num2)
print(num2)

# 날짜형으로 변환(날짜 계산 목적)
str(emp) #$ HIREDATE: chr  "1980-12-17" "1981-02-20" "1981-02-22" "1981-04-02" ...
# 문자형을 날짜형으로 
emp$HIREDATE=as.Date(emp$HIREDATE)
str(emp) #  $ HIREDATE: Date, format: "1980-12-17" "1981-02-20" "1981-02-22" "1981-04-02" ...

# ~~형 변환 연습
data=data.frame(product_number=c('A001','A002','A003'), # 제품번호
                product_name=c('Skin','Suncream','Lipstic'), # 제품
                price=c('15000$','22000$','18000$')
)
write.csv(data,file="화장품.csv",row.names = FALSE) # 데이터프레임을 액셀로 저장
str(data)

# 1. '$' 제거 # gsub: 특정 문자 제거
data$price=gsub('\\$',"",data$price) # $-> "" 변경
# 2. 문자 -> 숫자로 변환
data$price=as.numeric(data$price)
str(data)
# 3. 계산(sum)
print('제품 총합: ')
print(sum(data$price)) # 총합 구하기
# 총합, 평균, 최소, 최대 구하기

#1) 전체 사원 총급여
print('전체 사원 총급여: ')
result=(sum(emp$SAL)) 
print(result)


#2) 급여 평균
result=mean(emp$SAL)
print(result)


#3) 사원 중 가장 많이 급여 받는 사람의 급여 알아보기(최댓값)
result=max(emp$SAL)
cat("최댓값:",result,"\n")

#4) 최소
result=min(emp$SAL)
cat("최소값:",result,"\n")

# 다중 컬럼의 합, 평균 구하기
# 급여와 COMM의 합과 평균

total_sum=colSums(emp[,c("SAL","COMM")]) # colSums() : 여러 컬럼의 합
print(total_sum) ######## COM이 NA 존재--->  결측값 제거 필수
# NA 제거 후, 통합 실시
total_sum=colSums(emp[,c("SAL","COMM")],na.rm=TRUE) # na.rm=TRUE 결측값 제거

# 퀴즈) 사원의 급여와 COMM 평균 계산 (NA 제거)
mean_sum=colMeans(emp[,c("SAL","COMM")])
print(mean_sum)
mean_sum=colSums(emp[,c("SAL","COMM")],na.rm=TRUE) 


# 단일 컬럼 COMM, 총합 구하기 #na.omit():  결측값 제거 ******
comm=sum(na.omit(emp$COMM))
cat("COMM 총합:",comm,"\n") 

# 중앙값, 표준편차 구하기 : 데이터의 산포도 파악하는 통계적 지표
# ex) 학생 수학 평균 점수 78~82 (10명)
# 평균점수가 80이라 가정시, 표준편차 작음
# 점수가 60~100 이라 가정시, 표준편차 큼

# 급여 표준편차 산정하기 ***
# R은 sd() 사용
sal_sd=sd(emp$SAL) # 급여 표준편차(standard deviation)
cat('급여 표준편차:',sal_sd,'\n')
# 이는 급여 값들이 평균으로부터 약 +- 1267.58만큼 떨어짐

# 중앙값
sal_median=median(emp$SAL)
cat('급여 중앙값:',sal_sd,'\n')

# 최빈값, 분위수 산정 ******
# 최빈값은 데이터가 가장 많이 위치한 값
# 분위수는 데이터를 크기 순으로 정렬 후 특정 비율에 해당하는 값 보여주기

# JOB 최빈값 구하기
# table 문법 구조
print(table(emp$JOB)) # JOB별 인원 수 파악
# which.max 구조
x=c(10,23,100,1,5) # 숫자형 벡터 생성
print(which.max(x)) # [1] 3 --> 가장 큰 수는 3번째에 위치

# 3. 최빈값
job=names(which.max(table(emp$JOB))) # names: 열이름 출력
cat('job 최빈값은:',job) 

# 부서번호의 최빈값
print(table(emp$DEPTNO))
DEPTNO=names(which.max(table(emp$DEPTNO)))
cat('DEPTNO 최빈값은:',DEPTNO,'\n')
# 값이 동일하면 WHICH.MAX로 인해 30은 조회 불가

# 분위수 산정
# 급여 분위수 알아내기
sal=quantile(emp$SAL)
print(sal)
# 0% 가 최솟값 --------   100% max값
# 50% 가 중앙값

# 특정 분위수 구하기 (하위 10%, 상위 90%) ## 사분위수: 데이터를 4등분해서 나온 기준 값
sal=quantile(emp$SAL,probs=c(0.1,0.9))
print(sal)  

# 결측치를 제거한 SAL(급여) 평균 구하기
sal = mean(na.omit(emp$SAL))
cat('결측치를 제거한 급여 평균 : ',sal,'\n')
# 결측치를 제거한 SAL(급여) 총합 구하기
sal = sum(na.omit(emp$SAL))
cat('결측치를 제거한 SAL(급여) 총합 : ',sal,'\n')
# 결측치를 제거한 COMM 표준편차 구하기
# comm은 결측치가 많은 컬럼이므로 na.rm =TRUE
comm = sd(emp$SAL, na.rm =TRUE)
cat('결측치를 제거한 COMM 표준편차 : ',comm,'\n')





