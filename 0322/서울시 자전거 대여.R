# library(dplyr)
library(ggplot2)
setwd("D:/R-DATA") 
bicycle_data=read.csv('seoul_public_bicycle_data.csv',fileEncoding = 'CP949',encoding = "UTF-8",check.names = FALSE)

### 공통조건: 그래프 3개 모두 저장

# 1. 대여소번호별 이용 건 수 막대그래프 표현
# 조건) x축: 대여소번호, y축: 이용건 수

# 1-1) 전처리 작업 
data1=bicycle_data%>%group_by(대여소번호)%>%summarise(sum_count=n())
# View(data1)
# 1-2) 그래프 작업
p = ggplot(bicycle_data,aes(x=대여소번호,y=data1)) + geom_col() + labs(title = '대여소 번호 별 이용 건 수', x = '대여소번호', y = '이용건수')
print(p)
pdf.options(family="Korea1deb")
ggsave('대여소번호별 이용건수.pdf')
       
# 2. 정기권을 구매한 이용자 중 연령대 별 평균 운동량 막대그래프로 표현
# 조건) 단, 이용시간(분) 5분 이하는 평균에서 제외
# 조건) x축: 연령대, y축: 평균 운동량

# 2-1) 전처리 작업
data2=bicycle_data%>%filter(대여구분코드=="정기권")%>%group_by(연령대코드)%>%summarise(avg_p=ifelse(`이용시간(분)`<=5,"",mean(운동량)))
View(data2)

# 2-2) 그래프 작업
p = ggplot(bicycle_data,aes(x=연령대,y=data2)) + geom_col() + labs(title = '연령대별 평균 운동량', x = '연령대', y = '평균 운동량') 
print(p)
pdf.options(family="Korea1deb")
ggsave('연령대별 평균 운동량.pdf')

# 3. 연령대코드별 이용시간과 운동량을 비교하는 산점도 그래프 표현
# 조건) x축: 이용시간, y축: 운동량
# 조건1) 연령대 별 색깔(10대:노랑(yellow), 20대: 블루(blue), 30대: 보라(purple), 40대: 초록(green), 50대: 블랙(black) # scale_color_manual(values=c("Male"="blue","Female"="red")) 필요
# 조건2) 연령대 별 중 운동량을 스케일(minmax) 후 0.5 이상인 회원은 세모표시(17)  : mutate 필요

# 3-1) 전처리 작업
# 3-1-1) 조건2를 이용한 minmax화
data3=bicycle_data%>%filter(연령대코드="10대:70대")%>%group_by(연령대코드)
# 3-1-2) 조건1을 이용한 필터링

data3=bicycle_data%>%mutate(
  
  
  %>%mutate(BMI=`체중(5kg단위)`/(`신장(5cm단위)`/100)^2,Grade=ifelse(혈색소>=16,"High","Normal"),Gender=ifelse(성별==1,"Male","Female"))
# 3-2) 그래프 작업
p = ggplot(bicycle_data,aes(x=연령대,y=data2)) 
  
  
  

(ifelse(연령대코드=="10대",ifelse(연령대코드=="20대",ifelse(연령대코드=="30대",ifelse(연령대코드=="40대",
                                                                    ifelse(연령대코드=="50대",ifelse(연령대코드=="60대",scale_color_manual()
                                                                                                
                                                                                               # 문제: 2021년에 제작된 영화의 평균 길이
                                                                                               # 문자 제거 -> gsub(문자제거) -> as.numeric (형변환) 
                                                                                               result = netflix %>% 
                                                                                                 filter(type == 'Movie' & release_year == 2021) %>% 
                                                                                                 summarise(avg_duraion = mean(as.numeric(gsub(" min","",duration
                                                                                                 ))))


                                                       

  p = ggplot(data = health_data3, aes(x = `식전혈당(공복혈당)`,y = 허리둘레)) +
  geom_point(aes(color = Gender, shape = Grade), size = 1.5) +
  scale_color_manual(values = c("Male" = "blue", "Female" = "red")) +
  scale_shape_manual(values = c("High" = 11, "Normal" = 16)) +
  geom_smooth(method = "lm", color = "orange") +
  labs(title = "식전혈당(공복혈당) vs 허리둘레"
       , x = "식전혈당(공복혈당)"
       , y = "허리둘레"
       , color = "Gender"
       , shape = "Grade") +
  theme_minimal() #뒤에 회색 배경 지우기






