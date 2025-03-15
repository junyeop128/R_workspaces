# 날짜로 포맷팅되어있는 경우
Sys.setlocale("LC_TIME","C") # 임시로 장소 변경
result='September 24, 2021' # R은 해당 문자를 바로 날짜형으로 변환 불가능 하다
result=as.Date(result,format='%B %d, %Y') # 형식 맞추기
print(result) 
formatted_date=format(result,'%Y') #년도만 추출
print(formatted_date) 

result1='2025-03-15'
date=as.Date(result)
formatted_date=format(date,'%Y') # 문제없이 Date로 형변환
print(formatted_date)

# 2021년에 추가된 영화의 타이틀 추출[응용]
# 1)  formatted_add_data 컬럼 추가
result2=netflix%>%mutate(formatted_add_date=as.Date(date_added,format='%B %d, %Y'))
# View(result2) : 컬럼 추가 확인

result3=netflix%>%filter(type=='Movie'&format(formatted_add_date,'%Y')==2021) %>% select(title)

View(result3) # 21년도에 넷플릭스에 추가된 영화

