# 초기하분포(비복원추출에서 사용되는 이산형 확률분포)
# 이산형: 연속적이지 않고 구별되는 값 vs 주사위를 던져 나온 수

# 52장의 뽑기 카드에서 당첨 카드(4장)가 포함된 상태로 
# 무작위 5장을 뽑을 때 정확히 2장의 당첨 카드를 뽑을 확률을 R로 구현해보자. 

N= 52 # 모집단
n= 5 # 표본의 수
x= 4 # 당첨카드 수
K= 4 # 성공 항목의 수

# 초기하분포 확률 계산
result=dhyper(x,K,N-K,n) * 100 # R에서는 dhyper로 쉽게 구할 수 있음
cat('5장 중 2장의 당첨카드를 뽑을 확률 : ', result, '\n') # 약 4%

# 실생활 예시
# 품질관리
# 100개의 부품 중의 10개가 불량품이고, 검사관이 15개를 무작위로 추출 시, 3개의 불량품이 포함될 확률을 계산
N= 100 # 모집단(100개의 부품)
n= 15  # 표본의 수(비복원추출)
x= 3   # 성공항목의 수
K= 10  # 불량품

# 초기하분포
result=dhyper(x,K,N-K,n) * 100
cat('15개 중 정확히 3개의 불량품이 포함될 확률 : ', result, '\n') # 약 13%

# 예제 1

# 1. 상원쿠팡은 총 4개의 창고 중 Location_3 창고에서 5만원 이상 제품 중 결함이 있는 제품 총 개수 K를 구하시오.

setwd("D:/R-DATA")
warehouse1=read.csv('warehouse_data_1000.csv')
print(str(warehouse1)) # 전처리 전, 데이터 프레임 구조 반드시 확인
data1=warehouse1%>%filter(Price>=50000 & Warehouse_Location == 'Location_3' & Defective == 'Y')%>%nrow()
print(data1)

# 2. Location_3 창고에 입고된 총 제품 모집단, 1번 정답 결함제품 수라고 할 때, 10개의 제품을 
data2= warehouse1%>%filter(Warehouse_Location=='Location_3')%>%nrow()
N=data2 # 모집단
n= 10  # 표본의 수(비복원추출)
x= 5  # 불량품 5개
K=data1 # 불량품
# 초기하분포 확률 계산
P=dhyper(x,K,N-K,n) * 100 
cat('10개중 5개의 불량품이 포함될 확률 : ', P, '\n') # 약 1.3%

# 예제 2 

# 1. 
# 모집단 N: Location_2 창고에 입고된 총 제품 수
# K(모집단 중 원하는 갯수): Location_2 창고에서 2025-03-01 ~ 2025-03-21 사이에 입고된 제품 중 가장 결함이 많은 아이템의 총 개수
# n(표본크기): 5
# x(표본 중 원하는 갯수): 1개

data1=warehouse1%>%filter(Warehouse_Location == 'Location_2')%>%nrow()
print(data1) # 250
data2=warehouse1%>%filter(Warehouse_Location == 'Location_2' & Arrival_Date >= as.Date('2025-03-01') & Arrival_Date <= as.Date('2025-03-21') & Defective == 'N')%>%
  group_by(Item_Name)%>%summarise(Defect_count=n())%>%arrange(desc(Defect_count))
print(data2) 
# 가장 결함이 많은 아이템 추출
most_defect_item=data2%>%slice(1)
print(most_defect_item)
# 초기하분포 확률 계산
N=data1
K=most_defect_item$Defect_count
n=5
x=1

P=dhyper(x,K,N-K,n) * 100 
print(P) # 약 39%


                            














































