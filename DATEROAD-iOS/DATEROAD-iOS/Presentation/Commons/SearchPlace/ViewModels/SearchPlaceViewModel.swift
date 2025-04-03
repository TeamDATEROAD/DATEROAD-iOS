//
//  SearchPlaceViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/31/25.
//

import UIKit

final class SearchPlaceViewModel {
    
    var selectedPlaceData: ObservablePattern<SearchPlaceModel> = ObservablePattern(nil)
    
    var filteredSearchPlaceData: ObservablePattern<[SearchPlaceModel]> = ObservablePattern(nil)
    
    var inputPlace: ObservablePattern<String> = ObservablePattern(nil)
    
    var initialBottomSheet: ObservablePattern<Bool> = ObservablePattern(true)
    
    var page: Int = 1
    
    var isEnd: Bool = false
    
}


// MARK: - Search Place TextField

extension SearchPlaceViewModel {
    
    func filterSearchPlace(_ searchPlaceData: GetSearchPlaceResponse) {
        if searchPlaceData.meta.totalCount == 0 {                                 // 검색 결과 없는 경우
            filteredSearchPlaceData.value = []
        } else {
            let newFilteredData = searchPlaceData.documents.map {
                SearchPlaceModel(name: $0.placeName, address: $0.addressName)
            }
            
            if page == 2 {                                                        // 새로운 검색에 대한 데이터 세팅
                filteredSearchPlaceData.value = newFilteredData
            } else {                                                              // 기존 검색에 대한 추가 데이터 세팅
                filteredSearchPlaceData.value?.append(contentsOf: newFilteredData)
            }
        }
    }

}


// MARK: - Network Method

extension SearchPlaceViewModel {
    
    func getSearchPlace() {
        guard let inputPlace = inputPlace.value, !isEnd else { return }      // 입력값이 nil이거나, 마지막 페이지인 경우 서버 통신 X
        let request = GetSearchPlaceRequest.init(query: inputPlace, page: page)
        
        NetworkService.shared.searchPlaceService.getSearchPlace(request) { response in
            switch response {
            case .success(let searchPlaceData):
                self.isEnd = searchPlaceData.meta.isEnd                     // 마지막 페이지 확인 변수 저장
                self.page += 1                                              // 현재 페이지 변수 증가
                self.filterSearchPlace(searchPlaceData)                     // 데이터 저장
                
            default:
                self.page = 1
                self.filteredSearchPlaceData.value = []
            }
        }
    }
    
}
