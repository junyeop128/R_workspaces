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

# 날짜/시간 데이터 처리
# as.Date() : 문자형을 날짜형으로 변환
# difftime: 두 날짜간의 차이 계산
# format <- ****** : 특정 형식으로 변환

dates=c('2025-03-08','2025-03-01','2025-01-01') # 문자로 인식
# 1) 날짜형으로 변환
dates= as.Date(dates) 
str(dates) # 데이터 타입 확인
# 2) 오늘 날짜 확인 
today=Sys.Date() # Sys : 시스템 
print(today)
# 3) 오늘 날짜와 각 날짜의 차이 계산
result=today-dates
print(result) # 0  7 66 : 오늘로부터 7일이 지남
result= dates + 7 # 각 날짜에 일수 더하기
print(result) # 각 날짜에 7일을 더한 결과
# 4) 날짜 포맷 변경
formatted_dates=format(dates,'%Y년 %m월 %d일')
print(formatted_dates)
formatted_dates=format(dates,'%y년 %m월 %d일')
print(formatted_dates)
# 5) 두 날짜간의 차이
hire_date=as.Date('2025-01-02') # 입사 날짜
current_date=as.Date('2025-02-13') # 특정 날짜
# 근속일 계산
days=difftime(current_date,hire_date)
print(days) # Time difference of 42 days
# units='mins' : 두 날짜간의 분
# units='hours' : 두 날짜간의 시간
# units='weeks' : 두 날짜간의 주
days=difftime(current_date,hire_date,units='mins') 
print(days) # Time difference of 60480 mins

# 특정 기간에 고용된 직원 조회(81년 01월 01일부터 12월 31일 사이에 입사한 직원)
result=emp%>%filter(HIREDATE>=as.Date('1981-01-01')&HIREDATE<=as.Date('1981-12-31'))
print(result)

# 월별 고용된 사원 수 집계

# 월 데이터 추출  # emp$HIRE_MONTH : 새로운 열 생성
emp$HIRE_MONTH=format(as.Date(emp$HIREDATE),'%Y-%m')
month_hire=emp%>%group_by(HIRE_MONTH) %>% summarize(EMP_COUNT=n()) # n(): 행의 수
print(month_hire)

# 문자열 데이터 처리******
# substr(): 특정 위치의 문자열 조회
# strsplit() : 특정 구분자를 기준으로 나눔 **** (실무에서 정말 많이 활용됨)
# gsub() : 다른 문자로 대체
 
text= "안녕하세요. 곧 점심시간입니다."
result=substr(text,1,5)
print(result) # text를 1번쨰부터 5번쨰까지 추출

text="오늘 점심은 라볶이, 돈까스, 햄버거입니다."
result=strsplit(text,split=',')  # ,를 기준으로 문장 분해
print(result) # "오늘 점심은 라볶이" " 돈까스"            " 햄버거입니다."    

phone='010-5555-3333' # 문자에 기호 붙어있으면 분석하기 어렵
result=strsplit(phone,split='-')
print(result)  # "010"  "5555" "3333"

# 단어 대체
text="고양이가 방에서 놀고 있어요."
result=gsub("고양이","강아지",text) # 고양이-> 강아지
print(result)

# 실무 예제 
text="사과12312312"

# 숫자 제거
result=gsub("[0-9]+","",text) # [0-9]+: 정규표현식(암기표현 아님)
print(result)

# 예제) emp에서 사원 이름 첫 두글자만 추출
# mutate()로 새로운 컬럼 생성
emp_name=emp%>%mutate(ENAME_SHORT=substr(ENAME,1,2))
# View(emp_name)

# mutate() 이용해서 입사년도 컬럼 추가 (substr 이용)
emp_hiredate=emp%>%mutate(HIRE_YEAR=substr(HIREDATE,1,4))
# View(emp_hiredate)

# 커미션(commission)이 결측값이 아닌 직원 중 부서별 평균 커미션과 최대 커미션 알아내기
# !is.na
# filter
# group_by(dept) + summarize : 단독 사용 불가
# mean(COMM)
# max(COMM)
emp_com=emp%>%filter(!is.na(COMM))%>%group_by(DEPTNO)%>%summarize(AVG_COMM=mean(COMM),MAX_C0MM=max(C0MM))
#View(result)

# 직업(JOB)이 MANAGER인 사원 필터링 후 부서번호 별 총 급여 합계 조회
result_ma=emp%>%filter(JOB=="MANAGER")%>%group_by(DEPTNO)%>%summarize(TOTAL_SAL=sum(SAL,na.rm = TRUE))

# filter
# group_by(DEPTNO) + summarize
# sum(SAL)


# 데이터 스케일링, 데이터 이상치 제거 <- 기초통계 시간에 진행
