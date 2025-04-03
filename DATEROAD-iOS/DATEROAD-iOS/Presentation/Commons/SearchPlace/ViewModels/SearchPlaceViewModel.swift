//
//  SearchPlaceViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 3/31/25.
//

import UIKit

final class SearchPlaceViewModel {
    
    var searchPlaceData: ObservablePattern<[SearchPlaceModel]> = ObservablePattern(SearchPlaceModel.dummyData)
    
    var filteredSearchPlaceData: ObservablePattern<[SearchPlaceModel]> = ObservablePattern(nil)
    
    var inputPlace: ObservablePattern<String> = ObservablePattern(nil)
    
    var initialBottomSheet: ObservablePattern<Bool> = ObservablePattern(true)
    
}


// MARK: - Search Place TextField

extension SearchPlaceViewModel {
    
    func clearTextField() {
        inputPlace.value = nil
    }
    
//    func filterSearchPlace(_ searchText: String) {
//        if searchText.isEmpty {
//            filteredSearchPlaceData.value = []
//        } else {
//            let queryLowercased = searchText.lowercased()
//            let queryInitials = extractInitialConsonants(searchText)
//            
//            filteredSearchPlaceData.value = searchPlaceData.value?.filter { place in
//                let placeLowercased = place.name.lowercased()                // 대소문자 구분 없이 필터링
//                let placeInitials = extractInitialConsonants(place.name)     // 초성 필터링
//                return placeLowercased.contains(queryLowercased) || placeInitials.contains(queryInitials)
//            }
//        }
//        print("filteredSearchPlaceData \(filteredSearchPlaceData.value)")
//    }
    func filterSearchPlace(_ searchPlaceData: GetSearchPlaceResponse) {
        if searchPlaceData.meta.totalCount == 0 {
            filteredSearchPlaceData.value = []
        } else {
            filteredSearchPlaceData.value = searchPlaceData.documents.map { SearchPlaceModel(name: $0.placeName, address: $0.addressName) }
        }
        print("filteredSearchPlaceData \(filteredSearchPlaceData.value)")
    }
    
    
    // 초성 추출 메소드
    func extractInitialConsonants(_ text: String) -> String {
        let consonants = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ"      // 상수 정의: 한글 초성 리스트를 문자열로 저장
        let baseCode = UnicodeScalar("가").value            // 유니코드 값과 초성 간 간격을 설정
        let initialOffset = 588

        var result = ""

        for char in text {
            if let scalar = char.unicodeScalars.first {
                let unicode = scalar.value

                if (baseCode...baseCode + 11171).contains(unicode) {
                    let index = (unicode - baseCode) / UInt32(initialOffset)
                    result.append(consonants[String.Index(utf16Offset: Int(index), in: consonants)])
                } else {
                    result.append(char)
                }
            }
        }
        return result
    }
}


// MARK: - Network Method

extension SearchPlaceViewModel {
    
    func getSearchPlace() async {
        guard let inputPlace = inputPlace.value else { return }
        let request = GetSearchPlaceRequest.init(query: inputPlace)
        
        NetworkService.shared.searchPlaceService.getSearchPlace(request) { response in
            switch response {
            case .success(let searchPlaceData):
                self.filterSearchPlace(searchPlaceData)
                
            default:
                self.filteredSearchPlaceData.value = []
            }
        }
    }
    
}
