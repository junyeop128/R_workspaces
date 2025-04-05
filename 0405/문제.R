# 표준오차
# 어떤 포장 식품의 포장 겉면의 내용물 중량이 300g이라고 표시되어있음.
# 실제 무게를 추정하기 위해 시중의 매장에서 
# 10개의 제품을 구입하여 조사한 결과의 표본오차 구하기

# 데이터
weights=c(310,295,298,302,305,285,300,311,301,294)
# 벡터의 갯수는 length(weights) 이용
weights_sd=sd(weights)
sample_size=length(weights) # 벡터 안 요소 개수 확인

# 표준오차 계산
sem= weights_sd/sqrt(sample_size)
cat('표준 오차 : ',round(result,2),'\n') # 2.45153

# T- 검정
# 귀무가설 출발
  # 1. 일 표본: 표본 vs 알려진 모집단 평균
  # 2. 독립 표본: 서로 다른 두 집단 비교
  # 3. 대응 표본: 