# 대문자와 소문자 구별 필수(오타주의)
# 사람끼리 정보를 주고받을 때는 주소와 문자로
# 논리형이 필요(true,false)

# R 특별 (범주형데이터: 혈액형, 성별, 고객만족도)
# 범주형 데이터-? 그룹핑 , 계산적 의미 불필요

# 5. ***** 결측값: 관측/측정에 실패한 값

x=10
print(x)

# 벡터와 데이터프레임(행과 열로 구성된 2차원 구조)
# 성

df=data.frame(
  ID=c(1,2,3) ,
  NAME=c('김길동','홍길동','박길동')
)
#View(df)

# 데이터프레임 조회
print(head(df,2))
#1~2행까지 출력
print(dim(df)) # 행과 열의 수
print(tail(df,2)) # 아래에서부터 2행 출력
print(str(df)) # 각 열의 데이터 타입 제시

# 특정 열 선택
NAME=df$NAME
print(NAME)

# 다중 열 선택
emp=df[,c('ID','NAME')]
print(emp)  # id, name 컬럼만 조회

# 새로운 열 추가
df$JOB=c('MANAGER','SALES','MANAGER')
#View(df)

# 새로운 열 'SAL(급여)' 추가
df$SAL=c(15000,30000,50000)
#View(df)

# 특정 열의 값 수정 
df$SAL=df$SAL*2 # 기존급여의 2배
print(df)

# 데이터프레임을 액셀 파일로 변경
write.csv(df,file='sample_data.frame.csv')
# 기본 경로는 '문서'에 저장됨









