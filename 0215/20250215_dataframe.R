### 데이터프레임
# R기초 단계에서 가장 중요한 것이 데이터 프레임과 벡터임 

# R프로그래밍에서 데이터프레임은 데이터를 '행'과 '열'로 
# 구성한 2차원 구조
# 디양한 데이터 유형을 한 테이블로 저장할 수 있는 자료구조
# 데이터프레임으로 통계분석, 데이터 처리, 그래프 시각화

# 구조: 행과 열
# 행: row() _ 관측치
# 열: col() _ 속성

vec1=c(1,2,3)
vec2=c('Alice','Bob','Charlie') # 문자형
vec3=c(25,30,35)
vec4=c(50000,60000,70000)

# 데이터프레임 생성 : data.frame() 
df=data.frame(vec1,vec2,vec3,vec4)
print(df)

# 검증 방법(데이터 프레임 조회하는 다양한 방법*****)
print(head(df,1)) # 1행만 출력
print(head(df,2)) # 1~2행 출력

print(head(df)) # 뒤에 숫자를 쓰지 않으면, 1~6행까지 출력 

# 행과 열의 수를 알고 싶어
print(dim(df)) # 3행 4열

# 전체 column 조회
print(colnames(df)) # 카테고리

# 마지막 1행 출력
print(tail(df,1)) 

View(df) # 보기 쉽게 액셀형태로 보여줌 

## 특정 열만 선택하기
# '$' 기호를 선택하면 결과는 벡터 형태로 변환
names=df$name # 데이터프레임의 NAME에 해당하는 열 가져오기
cat('특정 열 추출:',names,'\n') 

# Age만 출력 # 특정 열 접근은 $
ages=df$vec1
cat('특정 열 추출:',age,'\n') 

## 다수 열 선택
# 이름과 나이만 출력
result=df[,c('vec1','vec2')]
print(result)

# ID와 SALARY만 출력
result=df[,c('vec3','vec4')]
print(result)

# 특정 열값 수정 및 추가
df$vec4=df$vec4+100
print(df)

# age 열 값 수정 
df$vec3=df$vec3+1
print(df)

# 새로운 열 추가하기
df$Penalty=c('TRUE','FALSE','TRUE') # 팩터형(범주형) 변수
View(df)









