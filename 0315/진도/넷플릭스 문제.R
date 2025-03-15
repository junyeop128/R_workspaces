print(list.files())
print(getwd())  # getwd: Get Working Directory(불러오는 역할)
setwd("D:/R-DATA") 
library(dplyr)
netflix=read.csv("netflix.csv") # 데이터셋 읽기

# 문제 3: 데이터셋에서 title, type, release_year 열만 선택하세요.
result1=netflix%>%select('title','type','release_year')
print(result1)

# 문제 5: 2021년에 출시된 영화만 필터링하세요.
result3=netflix%>%filter(release_year==2021)
print(result3)

# 문제 6: TV-MA 등급의 TV 프로그램만 필터링하세요.
result4=netflix%>%filter(type=="TV Show" & rating=="TV-MA")
print(result4)

# 문제 7: director가 "Mike Flanagan"인 영화의 title, director, country 열을 선택하세요.
result5= netflix%>%filter(type == "Movie" & director == "Mike Flanagan")%>%select('title','director','country')
print(result5)

# 문제 10: TV 프로그램(type == "TV Show") 중 시즌 수(duration)를 기준으로 오름차순으로 정렬하세요. # []? <- 시즌과 seasons 걸러내기
# 문제 발생: 컬럼에 숫자와 문자가 같이 공존하므로, 문자열 제거(특정 문자로 대체) ---> gsub() 
result8=netflix%>%filter(type == "TV Show")%>%mutate(seasons=as.numeric(gsub(" Season[s]?","",duration)))%>%arrange(duration)
print(result8)
# seasons(새로운 열)=as.numeric(gsub(" Season[s]?","",duration)) # " Season[s]?" : 공백 존재하므로, 스페이스바 + -s존재하므로 [s]
# 텍스트 데이터에서 숫자만 추출 뒤 정렬하는 게 포인트

# 문제: 2021년에 제작된 영화의 평균 길이
# 문자 제거 -> gsub(문자제거) -> as.numeric (형변환) 
result = netflix %>% 
  filter(type == 'Movie' & release_year == 2021) %>% 
  summarise(avg_duraion = mean(as.numeric(gsub(" min","",duration
  ))))

# 년도별 제작된 영화의 평균 길이
result = netflix %>% 
  filter(type == 'Movie') %>% 
  group_by(release_year) %>% 
  summarise(avg_duraion = mean(as.numeric(gsub(" min","",duration
  )),na.rm = TRUE)) 

# 장르가 코미디인 영화의 제목(콤마로 구분되는 경우)
# listed_in %in% c('Comedies') : listed_in에 Comedies기 포함되었는지 체크해줌.
result=netflix%>%filter(type == "Movie" & listed_in %in% c('Comedies')) %>% select(title) 
# View(result)

# International TV Shows 장르에 속하고, TV-MA등급인 TV-Show의 title과 제작 국가 추출
result=netflix%>%filter(type == "TV Show" & listed_in %in% c('International TV Shows') & rating == "TV-MA") %>% select(title,country)
# View(result)
# nrows(): 행의 수, number of rows
result=netflix%>%filter(type == "TV Show" & listed_in %in% c('International TV Shows') & rating == "TV-MA") %>% nrow()

# United Statues에서 제작된 영화의 개수 추출
result=netflix%>%filter(type == "Movie" & country %in% c('United States')) %>% nrow()
# View(result)

# 국가별 영화 수 
# country != '' (빈값 체크하는 방법)
result=netflix %>% filter(country !=''& type == "Movie" )%>% group_by(country) %>% summarise(count=n())
# View(result)

# 국가별 영화 수 -> 가장 영화가 많은 국가를 상위 5개만 추출
# 등수 구하는 사전 작업 시, 정렬이 우선시 되어야 함
result=netflix %>% filter(country !=''& type == "Movie" )%>% group_by(country) %>% summarise(count=n()) %>% arrange(desc(count)) %>% slice_head(n=5)
# View(result)

# 감독별 가장 많이 넷플릭스에 등록한 감독 상위 한명 추출
result=netflix %>% filter(director !='') %>% group_by(director) %>% summarise(count=n()) %>% arrange(desc(count)) %>% slice_head(n=1)
# View(result)

# 넷플릭스에서 가장 많이 등장하는 장르 상위 5개 추출
# install.packages("tidyr") # separate_rows(사용 가능): dplyr 문법 아님 # ctrl+enter
# *** separate_rows: 콤마로 구분된 문자열 처리 시, 사용
# separate_rows(listed_in, sep=  ", ") : listed_in을 분류할거고, 콤마 기준으로 분리할거야! 
library(tidyr)
result=netflix %>% separate_rows(listed_in, sep=  ", ") %>% group_by(listed_in) %>% summarise(count=n()) %>% arrange(desc(count)) %>% slice_head(n=5)
# View(result)

# 날짜로 포맷팅되어있는 경우
result=netflix%>%select(date_added)%>%slice_head(n=5)
# View(result)
  






















