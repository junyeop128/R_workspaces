# 종로구와 중구, 용산구가 현재 가장 폐업율이 높음
# 왜 높을까?
# 1) 물가가 상승한 것일까?
# 2) 노인수가 급증한 것일까? 노인수가 급증했다고 가정 

# 종로구 노인 인구 비율 조회하기

library(dplyr) # 전처리 도구
library(ggplot2) # 시각화 도구

elder=read.csv("고령 인구현황.csv",fileEncoding ='CP949',encoding='UTF-8',check.names = FALSE) # 컬럼 이름이 한글

# 전처리 (종로구의 22,23,24년 65세 이상 전체 컬럼 조회)
data1=elder%>%filter(행정구역=='서울특별시 종로구 (1111000000)')%>%select(`2022년_65세이상전체`,`2023년_65세이상전체`,`2024년_65세이상전체`)
# View(data1)

# 변화된 데이터를 선 그래프로 변환
df=data.frame(time=c('2022-01-01','2023-01-01','2024-01-01'),elder_count=c(elder$`2022년_65세이상전체`,elder$`2023년_65세이상전체`,elder$`2024년_65세이상전체`))
#  형변환
df$time=as.Date(df$time) # 문자-> 날짜
df$elder_count=as.numeric(gsub(",","",df$elder_count)) # 콤마 제거 후 숫자로 변환 
# print(df) # 결과확인

# 그래프
p=ggplot(data=df,aes(x=time,y=elder_count)) + geom_line() + labs(title="종로구 인구수 변화",x="연도",y="노인(65세 이상) 수") 
# print(p) 

# 상승률 계산: 최종값- 초기값 / 초기값 * 100
# 올해-작년/작년*100
# increase_rate 컬럼 생성
# diff: 연속된 값들 사이의 차이를 계산 

# 노인율 = 초기노인율 + 노인증가율
# 폐업율 = 초기폐업율 + 폐업증가율
# 폐업 확률(가중 평균) = (노인율 * 노인 가중치) + (폐점율 * 폐점 가중치) # 가중치는 우리가 정하는 것
# 전체 가중치를 1이라 할때, 노인 가중치를 0.6(유동인구 중가), 폐업 가중치 0.4(임대료상승, 경기침체,...)

# 1) 노인 증가율
elder$increase_rate=c(0,diff(df$elder_count)/df$elder_count[-length(df$elder_count)] * 100)
# print(df) 

# 2) 노인율 
elder2=read.csv('2022_2024_주민등록인구기타현황(고령 인구현황)_연간.csv',fileEncoding ='CP949',encoding='UTF-8',check.names = FALSE) 

# 데이터 내 콤마 제거 (2024년도_65세 이상 전체 컬럼들 콤마 제거)
elder2=elder2%>%mutate(인구수_2024=as.numeric(gsub(",","",`2024년 전체`))
                       ,노인수_2024=as.numeric(gsub(",","",`2024_65세이상전체`)),
                       인구수대비노인율=(노인수_2024/인구수_2024)*100)
View(elder2)

# 노인율 = 초기 노인율(2024년 가정)
jongno_init_elder_rate=elder2%>%filter(행정구역=='서울특별시 종로구 (1111000000)')%>%select(인구수대비노인율)
# print(jongno_init_elder_rate)

# 최종결과 
jongno=jongno_init_elder_rate+3.7
print(jongno)

# 폐업율 = 초기폐업율(13% 가정) + 폐업증가율 # close= 13
# 가중치 설정 # 가중치 0.6과 0.4 설정 이후 상대적 기여도 비율 6:4라고 가정
elder_w=0.6 # 노인 가중치(노인인구수 증가...)
close_w=0.4 # 폐점 가중치(임대료 상승, 경기침체 등...)

# 최종 폐점 확률(종로구)
close_rate=(jongno*elder_w)+(close*close_w) 
print('종로구 신규오픈 시 예상 폐점 확률 : ')
print(close_rate$인구수대비노인율) # 최종 폐점확률 20% 



# diff
x=c(10,20,30,40)
print(diff(x)) # 1. 20-10 / 30-20 / 40-30 

# length: 길이
print(length(df$elder_count)) # 데이터 수(길이) == count
print('종로구 신규오픈 시 예상 폐점 확률 :')
print(close_rate$인구수대비노인율) # 최종 폐점확률 20%























