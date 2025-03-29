# 특정 지역의 상권 생존률과 폐업률 알아보기 (가중치 없음)

library(dplyr) # 전처리 도구
library(ggplot2) # 그래프 도구

elder=read.csv("seoul_commercial_analysis.csv",fileEncoding ='CP949',encoding='UTF-8',check.names = FALSE) 

# 2024년도 통계를 바탕으로 2025년도 생존률, 폐업률 예상
# 데이터가 분기 데이터임
# substr: 특정 위치 문자만 추출(오려내기) 을 이용해 2024년 1분기부터 4분기까지 
# 운영_영업_개월_평균,폐업_영업_개월_평균,서울_운영_영업_개월_평균,서울_폐업_영업_개월_평균 
# 총 4개의 컬럼 평균 구하기

# 전처리
# data1=substr(elder$기준_년분기_코드,5,5)
# data2=elder%>%filter(data1==1:4)%>%group_by(자치구_코드)%>%summarise(mutate(avg_1=mean(운영_영업_개월_평균),avg_2=mean(폐업_영업_개월_평균)))
# View(data2)
# data3=elder%>%filter(data1==1:4)%>%group_by(자치구_코드)%>%summarise(mean(운영_영업_개월_평균),mean(폐업_영업_개월_평균))
# View(data3)
                                                                       
                                                                       
data2=elder%>%filter(data1==1:4)%>%mutate(avg_1=mean(운영_영업_개월_평균))
print(data2)
data3=elder%>%filter(data1==1:4)%>%mutate(avg_2=mean(폐업_영업_개월_평균))
print(data3)
data4=elder%>%filter(data1==1:4)%>%mutate(avg_2=mean(서울_운영_영업_개월_평균))
print(data4)
data5=elder%>%filter(data1==1:4)%>%mutate(avg_4=mean(서울_폐업_영업_개월_평균))
print(data5)

# 정답
# 분기로 되어있는 데이터를 연도로 바꾸자
seoul_commercial_data=elder%>%mutate(year=substr(기준_년분기_코드,1,4))
# View(seoul_commercial_data)

seoul_2024_data=seoul_commercial_data%>%filter(year==2024)%>%group_by(자치구_코드_명)%>%summarise(
  avg_1=mean(운영_영업_개월_평균), avg_2=mean(폐업_영업_개월_평균), avg_3=mean(서울_운영_영업_개월_평균), avg_4=mean(서울_폐업_영업_개월_평균)
)
# View(seoul_2024_data)

# 서초구 생존률 
# 2024년도 데이터가 없으므로, 2022년도로 대체(구했다고 가정)
seochogu_live_rate=33 # 24년 서초구 생존률 : 33% 가정
seochogu_close_rate=32 # 24년 서초구 폐업율 : 32% 가정

# 서초구 평균영업, 평균 폐업 조회
seochogu=seoul_2024_data%>%filter(자치구_코드_명=="서초구")%>%select(avg_1,avg_2)
View(seochogu)
                                  
# 2025년 서초구 상권 생존율, 폐업률 계산
생존확률_2025=seochogu_live_rate * (seochogu$avg_1 / seochogu$avg_1+ seochogu$avg_2)
폐업확률_2025=seochogu_close_rate * (seochogu$avg_2 / seochogu$avg_1+ seochogu$avg_2)

# 결과 출력
# %.2f%% -> 소수점 2자리까지만 출력
cat(sprintf('2025년 서초구 상권 생존확률 예상 : %.2f%%\n',생존확률_2025),
    sprintf('2025년 서초구 상권 폐업확률 예상 : %.2f%%\n',폐업확률_2025))

# 종로구 생존확률, 폐업확률 구하기 

# 24년 종로구 상권 생존율 = 20% (가정)
jongnogu_live_rate=20
# 24년 종로구 상권 폐업율 = 35% (가정)
jongnogu_close_rate=35
# 종로구 평균 영업, 평균 폐업 조회
jongnogu=seoul_2024_data%>%filter(자치구_코드_명=="종로구")%>%select(avg_1,avg_2)
View(jongnogu)
# 2024년 종로구 상권 생존율, 폐업률 계산
생존확률_2025=jongnogu_live_rate * (jongnogu$avg_1 / jongnogu$avg_1 + jongnogu$avg2)
폐업확률_2025=jongnogu_close_rate * (jongnogu$avg_2 / jongnogu$avg_1 + jongnogu$avg2)

# 결과 출력
# %.2f%% -> 소수점 2자리까지만 출력
cat(sprintf('2025년 종로구 상권 생존확률 예상 : %.2f%%\n',생존확률_2025),
    sprintf('2025년 종로구 상권 폐업확률 예상 : %.2f%%\n',폐업확률_2025))

# 영업/폐업 지속 개월수를 고려한 




    
    















































