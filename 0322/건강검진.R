library(dplyr)
setwd("D:/R-DATA")
# 컬럼이 한글이거나 괄호 등이 있을 때,처리하는 방법: fileEncoding = 'CP949'(컬럼이 한글일때) , encoding = "UTF-8"(괄호 인식하기)
health_data=read.csv('health.csv',fileEncoding = 'CP949',encoding = "UTF-8",check.names = FALSE)

# View(health_data)
# 컬럼에 괄호가 있으면 ``으로 묶어줍니다. 
# health_data=health_data %>% select(`연령대코드(5세단위)`,`시력(좌)`) 
# print(health_data)

# 시력(좌)와 시력(우) 평균이 0.9이하이면, vision이라는 컬럼에 Check 아니면  No Check를 생성하시오.

# 컬럼 생성 -> mutate
# 평균 -> mean
# ~~라면 -> ifelse 구문 사용

result=health_data %>% mutate(vision=ifelse((`시력(좌)`+`시력(우)`)/2<=0.9,'Check','No Check'))
# View(result)

# vision별 Check와 No Check 수 조회하기 # n(): 그룹핑 결과 갯수
group_result=result%>%group_by(vision)%>%summarise(count=n())S
# View(result)

# 이완기 혈압이 평균보다 낮은 행의 수 출력
r_mean_result=result%>%filter(이완기혈압<=mean(이완기혈압))%>%nrow()
# View(r_mean_result)
# filter에 기초 통계량 사용 가능

# min-max 정규화
# 남성의 혈청지오티(간기능 검사)를 최소,최대(min-max) 적도로 변환 후, 변환된 값이 0.8이상인 남성의 연령대코드, 신장, 체중, 혈청지오티 추출하기(단, 혈청지오티로 내림차순 정렬)
# 혈청지오티 40U/L 이하는 정상
# 성별: 1(남자)
scaled_health=result%>%filter(성별==1)%>%mutate(AST_Scaled=(`혈청지오티(AST)`- min(`혈청지오티(AST)`))/(max(`혈청지오티(AST)`)-min(`혈청지오티(AST)`)))
# View(scaled_health)

result=scaled_health%>%filter(AST_Scaled>0.8)%>%select(`연령대코드(5세단위)`,`신장(5cm단위)`,`체중(5kg단위)`,`혈청지오티(AST)`)%>%arrange(desc(`혈청지오티(AST)`))
print(result) 

# 연령대코드  5에서 15사이 중, 연령대코드 별 시력(좌), 시력(우) 평균값 조회 (단, 시력(좌),시력(우)를 각각 내림차순)
result=health_data%>%filter(`연령대코드(5세단위)`>=5 & `연령대코드(5세단위)`)%>%group_by(`연령대코드(5세단위)`)%>%summarise(시력좌평균=mean(`시력(좌)`,na.rm=TRUE), 시력우평균=mean(`시력(우)`,na.rm=TRUE)) %>%  arange(desc())
