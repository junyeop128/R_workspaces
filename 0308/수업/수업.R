library(dplyr) # 로드
emp=read.csv('emp.csv') # 파일 불러오기
# group_by + summarize
# group_by(~로) : 그룹핑할 대상을 선정 
# 데이터 자체는 숫자가 아니며, 계산적 의미가 없는 범주형 형태의 group_by
# 특정 열 컬럼 묶어 그룹화합니다.
# db의 그룹바이는 단독으로 사용 가능하나, r에서는 단독 불가
group_job=emp%>%group_by(JOB)
print(group_job) # Groups:   JOB [5] -> 5개밖에 없음을 알려줌

# R의 GROUP_BY는 SUMMARIZE, MUTATE, FILTER 등의 기능과 함께 
# 사용하여 그룹별로 계산 진행
# summarize : 요약

# 부서별(group_by) 급여 평균 계산
dep_avg_sal=emp%>%group_by(DEPTNO)%>%summarize(AVG_SAL=mean(SAL,na.rm=TRUE))
print(dep_avg_sal)

# 직업별 평균 급여 계산, 단 평균 급여 내림차순 정렬해라.
job_avg_sal=emp%>%group_by(JOB)%>%summarize(AVG_SAL=mean(SAL,na.rm=TRUE))%>%arrange(desc(AVG_SAL))
print(job_avg_sal)

# 직업(JOB)별 직원 수 계산, 단 직원 수 내림차순 정렬
job_count=emp%>%group_by(JOB)%>%summarize(EMP_COUNT=n())%>%arrange(desc(EMP_COUNT)) # n(): 행의 갯수
print(job_count)

# CSV 파일 2개 이용하기
emp=read.csv('emp.csv')
dept=read.csv('dept.csv')
# 두 데이터프레임 병합 (교집합을 이용한 병합) => JOIN(내부조인)
emp_with_dept=emp%>%inner_join(dept,by="DEPTNO") # by="DEPTNO" 로 병합을 할거야
# View(emp_with_dept) # 각 사원의 근무지
# 보스턴도 출력하고 싶어
# 40번 부서(dept에만 존재)인 운영팀도 출력 # dept%>%left_join: 왼쪽에 있는 데이터프레임을 교집합과 상관없이 다 병합할게 
emp_with_dept1=dept%>%left_join(emp,by="DEPTNO")
print(emp_with_dept1) #  40 OPERATIONS   BOSTON    NA   <NA>      <NA>   NA       <NA>   NA   NA
# 사원번호 포함해 결측값으로 표시

### full_join(합집합): emp, dept 모두 가져오는 역할 (모두 병합)
emp_full_joined=full_join(emp,dept,by="DEPTNO")
# View(emp_full_joined)

# 근무지가 "DALLAS"인 직원들의 '이름' 출력하기 # DALLAS 라는 열이 없으므로 조인부터 
emp_with_los=emp%>%inner_join(dept,by="DEPTNO")%>%filter(LOC=="DALLAS")%>%select(ENAME,LOC)
print(emp_with_los)

# Slice: 특정 위치 조회
result=emp%>%slice(2,4) # 2행과 4행 출력
print(result)

result=emp%>%slice(1:5) # 1행~5행 츨력
print(result)

# 부서별 최대 연봉 사원 조회
result=emp%>%group_by(DEPTNO)%>%slice_max(SAL,n=1) # n: 행, n=1 행 1개만
print(result)
