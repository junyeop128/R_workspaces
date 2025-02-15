# 주어진 코드
x = 42
y = "R 프로그래밍"
z = TRUE

# 각 변수의 자료형을 출력하는 코드를 작성하세요.
# 힌트: typeof() 함수를 사용하세요.
print(typeof(x))
print(typeof(y))
print(typeof(z))

# 다음 벡터에서 20보다 큰 숫자만 선택하여 출력하세요.
# 주어진 벡터
numbers = c(10, 15, 20, 25, 30, 35)
# 20보다 큰 숫자만 선택하고 출력하는 코드를 작성하세요.
print(numbers>20)

# 주어진 데이터프레임
people = data.frame(
  name = c("Alice", "Bob", "Charlie", "Diana"),
  age = c(25, 35, 30, 28),
  gender = c("여", "남", "남", "여")
)

# (1) 데이터의 상위 행 5개 출력
print(head(people,5))


# (2) 전체 컬럼을 출력하기


# (3) 데이터의 행과 열의 개수를 출력하기
print(dim(people))

# (4) 3번째 컬럼의 3번째 값은 무엇인가?
# 힌트: data[row_condition, column_condition] 콤마를 기준으로 왼쪽은 행 조건, 오른쪽은 열 조건입니다.

genders=df$gender
result=df[,c("여", "남", "남", "여"),3]
print(result)

# (5) 데이터 마지막 3개행을 출력하기


