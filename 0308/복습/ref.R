print(list.files()) # R 경로 확인
setwd("D:/R-DATA") # 작업 디렉토리 변경
print(list.files()) # 변경 완료

# 데이터프레임(행과 열_(벡터)로 이루어진 2차원 구조)

# 데이터프레임 생성
df=data.frame(
  ID=c(1,2,3),
  Name=c('Brian','Bob','Jose')
)
# View(df) 

print(df$Name) # 특정 열 출력

df$ID2=df$ID + 2 # 기존 열(ID) 를 새로운 열(ID2)에 대입
print(df$ID2) # 특정 열을 가져와 값을 더한 후 새로운 열에 추가

# 결측치(Missing Value) : NA로 표기
# 예제 데이터 생성
data=c(1,2,NA,4,NA,6) # 결측치 2개 
print(is.na(data)) # 결측치 확인 : is-> ? na가 있니?
# FALSE FALSE  TRUE FALSE  TRUE FALSE : 결과값 확인(na가 있으면 TRUE, 없으면 FALSE)

print(!is.na(data)) # !(부정 연산자)
# TRUE  TRUE FALSE  TRUE FALSE  TRUE : 반대 결과값 확인

## csv() 파일 가져오기 
emp=read.csv("emp.csv") #  파일 읽어오기
# View(emp) # COMM (보너스) 값은 결측치값 존재

emp_clean=na.omit(emp) # omit(na가 있는 행 제거) : 독립적 사용 가능
View(emp_clean)

emp_comm=sum(emp$COMM,na.rm=TRUE) # na.rm (제거) : sum, mean 등 통계 연산자와 같이 사용
print(emp_comm)

### 문제풀이(데이터 전처리-> 80~90%)
install.packages('dplyr')
library(dplyr) 

emp=read.csv("emp.csv")

# 문제1. 직원 이름(ENAME), 직업(JOB), 그리고 부서 번호(DEPTNO) 열만 선택하세요.
selected_emp=emp%>%select(ENAME,JOB,DEPTNO)
print(selected_emp)

# 문제2. 급여(SAL)가 2000 이상인 직원만 필터링하세요. 
sal_2000=emp%>%filter(SAL>=2000)
print(sal_2000)

# 문제3. 급여(SAL)를 기준으로 내림차순으로 정렬하세요.
sorted_by_sal=emp%>% arrange(desc(SAL))
print(sorted_by_sal)

# 문제4. 부서 번호(DEPTNO)가 30인 직원 중, 이름(ENAME)과 급여(SAL)만 선택하고 급여 순으로 내림차순 정렬하세요.
# 부서 번호(DEPTNO)가 30인 직원 중=> filter
# 이름(ENAME)과 급여(SAL)만 선택하고 => select
# 급여 순으로 내림차순 정렬하세요. => arrange
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
# dep_1030=emp%>%filter(DEPTNO %in% c(10,30))%>%select('ENAME','JOB','SAL')%>%arrange(ENAME)

# 문제 9. mutate()를 사용하여 급여(SAL)에 보너스(COMM, NA는 0으로 간주)를 더한 총 급여(Total_Salary) 열을 추가하세요. # mutate() : 열 추가 
mu_sal=emp%>%mutate(Total_Salary=SAL+ifelse(is.na(COMM),0,COMM)) # Total_Salary=SAL+COMM
print(mu_sal) 

num=c(10,10,NA,5,NA)
result=ifelse(is.na(num),1,num) # is.na(num) : 대상이 1이면 TRUE, NUM 이면 FALSE
print(result) # 10 10  1  5  1









 