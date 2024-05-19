import requests
from urllib.parse import urlparse
import json
import back_end

class GPS():   
    def __init__(self, x, y):
        self.x = y
        self.y = x


    def __get_location_name(self): #이건됨
        #gps 경도 위도로 현재 위치의 정보 받기
        name_list = []
        payload = {
            "startX" : self.x, #출발지 X좌표입니다.
            "startY" : self.y, #출발지 Y좌표입니다.
            "endX" : self.x, #목적지 X좌표입니다.
            "endY" : self.y, #목적지 Y좌표입니다.
            "userX" : self.x, #사용자의 현재 X좌표입니다.
            "userY" : self.y, #사용자의 현재 Y좌표입니다.
            "sort"  : "distance", #검색 결과 정렬. • score : 랭킹 점수 높은순 (default) • distance : 가까운 거리순 • evcharger : 가까운 거리 내 사용 가능한 EV 충전기 많은순
            "page" : "1", #조회할 목록의 페이지를 지정합니다.
            "count" : "1", #페이지당 출력되는 개수를 지정합니다.
            "radius" : "0.1", #km 단위 검색 반경.
            "searchType" : "nearby", # keyword - 일반 키워드 검색 / category - 카테고리검색 (키워드 없음) / nearby - 근처검색( 키워드 없음)
            "lineString" : f'{self.x},{self.y}_{self.x},{self.y}'
        }

        try:
            url = f'https://apis.openapi.sk.com/tmap/poi/findPoiRoute?version={back_end.constant.tmap_version}&appKey={back_end.constant.tmap_key}'

            result = requests.post(url, json = payload).json()
            # for i in result["searchPoiInfo"]['pois']['poi']:
            #     name_list.append(json.dumps(i['name'],ensure_ascii=False))
            # return name_list
            return result["searchPoiInfo"]['pois']['poi'][0]['name']
        except:
            return "error not found"

    # def __get_location_biz_name(self): #이게안됨 여러개 말고 단일로 하나만 보내봐야 할듯
    #     #건물 이름으로 얻은 데이터 분석해서 장소 보내주기 
    #     biz_name_list = []      
    #     page = 1   #Number	선택	조회할 목록의 페이지를 지정합니다.
    #     count = 1	    #Number	선택	페이지당 출력되는 개수를 지정합니다.
    #     try:
    #         biz_name_list = self.__get_location_name()
    #         for i in biz_name_list:
    #             url = f'https://apis.openapi.sk.com/tmap/pois?version={back_end.constant.tmap_version}&page={page}&count={count}&searchKeyword={i}&appKey={back_end.constant.tmap_key}'
    #             result = requests.get(url).json()
    #             biz_name_list.append(json.dumps(result["searchPoiInfo"]['pois']['poi'][0]['lowerBizName'],ensure_ascii=False))
    #         return biz_name_list
    #     except:
    #         return "default"
    
    def __get_name_result(self,name):
        if name in "카페 디저트 베이커리 테이크아웃커피 빙수 플라워카페 케이크전문 차 스마일명품찹쌀꽈배기 아이스크림":
            return "카페"
        elif name in "문구점":
            return "문구점"
        elif name in "한식 뷔페 초밥 롤 칼국수 만두 육류 고기요리 샤브샤브 돼지고기구이 배트남음식 국수 백숙 삼계탕 중식당 일식당 식당 패밀리레스토랑 생선구이 국밥 순대 순댓국 양갈비 종합분식 이탈리아음식 곱창 막창 닭요리 생선회 감자탕 두부요리 일식 초밥뷔페 초밥 찌개 전골 돈가스 술집 매운탕 해물탕 양식 와인 지자카야 바(BAR) 포장마차 족발 보쌈 복어료리 한정식 햄버거 요리주점 주꾸미요리":
            return "식당"
        elif name in "영화관":
            return "영화관"
        elif name in "마트 쇼핑 슈퍼 반려동물용품 식료품 정육점 수입식품 애견사료 몰류센터 장난감 종합가전 ":
            return "마트"
        elif name in "편의점 ":
            return "편의점"
        elif name in "도서관":
                return "도서관"
        elif name in "미용실":
            return "미용실"
        elif name in "서점 독립서점 아동도서 ":
            return "서점"
        elif name in "가정의학과 종합병원 피부과 병원 의원 소아청소년과 비뇨의학과 성형외과 안과 산부인과 보건소 신경외과 정형외과 한의원 내과 안과 치과 한방병원 이비인후과 정신건강의학과 요양병원":
            return "병원"
        else:
            return "default"


    def gps_analyzer(self):
        #건물 이름으로 얻은 데이터 분석해서 장소 라벨 보내주기 ex)식당, 병원, 약국, 학교
        headers = back_end.constant.naver_headers
        #headers = {'X-Naver-Client-Id':client_id, 'X-Naver-Client-Secret':client_secret}
        url_base="https://openapi.naver.com/v1/search/local.json?query="
        keyword = self.__get_location_name()
        url_middle="$&start="
        number='1'

        url = url_base + keyword + url_middle + number
        if(keyword == "error not found"):
            result_json = {'category': 'default'}
            return result_json

        # with open (back_end.constant.AAC_FILE, "r", encoding='cp949') as f:
        #         saved_data = json.load(f)

        result = requests.get(url,headers = back_end.constant.naver_headers).json()
        try:
            data_result = []
            #BdUse = json.dumps(result['items'][0]["category"],indent=4,ensure_ascii=False)
            BdUse = result['items'][0].pop('category', None)
            # data_temp = BdUse.split('>')
            # data= data_temp.split(',')
            data = BdUse.split('>')
            for i in data: 
                 data_result.append(i.split(','))
            data_result = sum(data_result,[])
            #data = data.split(',')
            #data = data[0].split(',')
            #data = data[0]
            # for i in saved_data["AAC"]:
            #     if(i["name"]==data[-1]):
            #         result_json = {'category': data[-1]}
            #         break;
            #     else:
            #         result_json = {'category': 'default'}
            # print(data_result)
            # print(data_result[-1])
            for i in data_result:
                print(i)
                if self.__get_name_result(i) != 'default':
                    result_json = {'category': self.__get_name_result(i)}
                    return result_json
            result_json = {'category': 'default'}
            return result_json 
            #result_json = {'category': 'self.__get_name_result(data)'}
            #return result_json
        except:
            result_json = {'category': 'default'}
            return result_json
        
