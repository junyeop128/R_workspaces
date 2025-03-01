### **** 가장 중요한 부분: 데이터 전처리 일부 중 하나 필터링
# 필터링 -> 쓸모없는 데이터 거르기 작업

# 1. subset 
# subset(부분집합) : 특정 조건에 맞는 데이터를 추출하여 새로운 부분집합 생성
# 설치 불필요, 기본적 제공
emp=read.csv('emp.csv')
print(emp)
# 급여가 3,000 이상인 사원 조회
high_sal=subset(emp,SAL>=3000)
print(high_sal) # SCOTT, KING
# AND 연산자, OR 연산자를 활용한 조건 추가
# 급여가 3,000이상이고 부서번호가 20번인 직원만 추출 # and연산자
emp_deptno20=subset(emp,SAL>=3000 & DEPTNO==20)
print(emp_deptno20)
# 급여가 2,000이상인 직원의 이름과 입사날짜, 직책 조회 # select 
sal_x=subset(emp,SAL>=2000,select=c(ENAME,JOB,SAL))
print(sal_x)

# 2. dplyr # 장점. 신속한 문제 해결 & 실무 가능 & 설치 필수 
# install.packages('dplyr') --- 설치 후 주석처리
# 설치한 디플라이어를 스크립트 창에 가져올 때, 로드(임포트)
library(dplyr) # 디플라이어(data frame plier) : 데이터 프레임을 다루는 공구 로드***(암기) 
# 대규모 데이터 처리 시, 매우 신속한 속도 제공 및 실무에서 전처리 작업 시 자주 사용

# (1) filter : 조건에 맞는 행 조회(행을 조건에 따라 필터링)

# 급여가 3,000 이상인 직원 조회
high_salary = emp%>%filter(SAL>=3000) # %>% A를 필터할거여
print(high_salary)
# 급여가 3,000 이상이고 부서번호가 20번인 사원 조회-->  and 연산자 
dep_20=emp%>%filter(SAL>=3000 & DEPTNO==20)
print(dep_20)
# 부서번호가 20번이고 직책(JOB)이 'MANAGER'인 사원 조회
job_m=emp%>%filter(DEPTNO==20 & JOB=='MANAGER')
print(job_m)
# 급여가 2,000미만이고 부서번호가 20번인 사원 조회
sal_20=emp%>%filter(SAL<2000 & DEPTNO==20)
print(sal_20)
# 급여가 2,000미만이고 부서번호가 20번인 사원의 이름, 부서번호만 조회
sal_201=emp%>%filter(SAL<2000 & DEPTNO==20) %>% select('ENAME','DEPTNO')
print(sal_201)
# 직책이 'SALESMAN'인 사원의 이름, 직책, 입사날짜 조회
sal_col=emp%>%filter(JOB=='SALESMAN')%>%select('ENAME','JOB','HIREDATE')
print(sal_col)

# (2) select: 특정 컬럼(열) 선택

# (3) mutate: 새로운 컬럼 추가
# 급여와 커미션의 합계를 새로운 열을 만들어 추가 # TOTAL_COM : 새로운 열 이름
emp_comm=emp%>%mutate(TOTAL_COM=SAL+ifelse(is.na(COMM),0,COMM))
# 해석) ifelse(is.na(COMM),0,COMM) : COMM이 na면 0을,아니라면 COMM을 추출 
# View(emp_comm)

# (4) arrange: 행 정렬
# 급여 기준으로 오름차순
sorted_by_sal=emp%>% arrange(SAL)
print(sorted_by_sal)
# 급여 기준으로 내림차순
sorted_by_sal=emp%>% arrange(desc(SAL)) # desc: 내림차순 
print(sorted_by_sal)

# (5) group by: 데이터 그룹화
# (6) summarize: 통계 계산
# (7) join: 여러 데이터프레임 병합
# (8) slice: 특정 행 선택

# 문제1. 직원 이름(ENAME), 직업(JOB), 그리고 부서 번호(DEPTNO) 열만 선택하세요.

# 문제2. 급여(SAL)가 2000 이상인 직원만 필터링하세요.
sal_2000=subset(emp,SAL>=2000)
print(sal_2000)
# 문제3. 급여(SAL)를 기준으로 내림차순으로 정렬하세요.
sorted_by_sal=emp%>% arrange(desc(SAL))
print(sorted_by_sal)
# 문제4. 부서 번호(DEPTNO)가 30인 직원 중, 이름(ENAME)과 급여(SAL)만 선택하고 급여 순으로 내림차순 정렬하세요.
dep_30=emp%>%filter(DEPTNO==30)%>%select('ENAME','SAL')%>%arrange(desc(SAL))
print(dep_30)
# 문제5. 직업(JOB)이 "MANAGER"인 직원 중, 부서 번호(DEPTNO)와 급여(SAL)를 선택하고 급여 순으로 오름차순 정렬하세요.
job_ma=emp%>%filter(JOB=='MANAGER')%>%select('DEPTNO','SAL')%>%arrange(SAL)
print(job_ma)
# 문제6. 급여(SAL)가 1500 이상이고 부서 번호(DEPTNO)가 20인 직원의 이름(ENAME), 직업(JOB), 그리고 급여(SAL)를 선택한 뒤 이름 순으로 정렬(오름차순)하세요.
sal_1500=emp%>%filter(SAL>=1500&DEPTNO==20)%>%select('ENAME','JOB','SAL')%>%arrange(ENAME)
print(sal_1500)
# 문제7.  직업(JOB)이 "SALESMAN"인 직원 중, 급여(SAL)가 1500 이상인 직원의 이름(ENAME), 급여(SAL), 부서 번호(DEPTNO)를 선택하고 급여 순으로 내림차순 정렬하세요.
job_sal=emp%>%filter(JOB=="SALESMAN")%>%filter(SAL>=1500)%>%select('ENAME','SAL','DEPTNO')%>% arrange(desc(SAL))
print(job_sal)
# 문제 8. 부서 번호(DEPTNO)가 10 또는 30인 직원 중, 이름(ENAME), 직업(JOB), 급여(SAL)을 선택하고 이름 순으로 정렬하세요.
dep_1030=emp%>%filter(DEPTNO==10|30)%>%select('ENAME','JOB','SAL')%>%arrange(ENAME)
print(dep_1030)
# 문제 9. mutate()를 사용하여 급여(SAL)에 보너스(COMM, NA는 0으로 간주)를 더한 총 급여(Total_Salary) 열을 추가하세요.
mu_sal=emp%>%mutate(Total_Salary=SAL+ifelse(is.na(COMM),0,COMM))
print(mu_sal)

