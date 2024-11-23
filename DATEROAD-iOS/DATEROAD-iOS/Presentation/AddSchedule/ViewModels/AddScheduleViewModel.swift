//
//  AddScheduleViewModel.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import UIKit

//MARK: - AddScheduleViewModel _ with Interface

final class AddScheduleViewModel: Serviceable {
    
    // MARK: - Initializer
    
    init() {
        addScheduleAmplitude.initAmplitudeVar()
        addScheduleFirstViewModel.fetchTagData()
    }
    
    /// Todo: 로직개선
    /// - First에 amplitude를 init하지 않는 이유는 VC에서 amplitude 관련 로직을 처리하기 때문
    /// - 따라서 First or Second 방식 중 통일되도록 개선하는 것이 좋아 보임
    lazy var addScheduleFirstViewModel: AddScheduleFirstViewModelInterface = AddScheduleFirstViewModel(addScheduleAmplitude: addScheduleAmplitude, setLoading: self.setLoading)
    
    lazy var addScheduleSecondViewModel: AddScheduleSecondViewModelInterface = AddScheduleSecondViewModel(addScheduleAmplitude: addScheduleAmplitude)
    
    let addScheduleAmplitude: AddScheduleAmplitude = AddScheduleAmplitude()
    
    var pastDatePlaces = [TimelineModel]()
    
    var selectedTagData: [String] = []
    
    var pastDateTagIndex = [Int]()
    
    
    //MARK: - AddFirstCourse 사용되는 ViewModel
    
    // 데이트 이름 유효성 판별 (true는 통과)
    let dateName: ObservablePattern<String> = ObservablePattern(nil)
    
    let isDateNameVaild: ObservablePattern<Bool> = ObservablePattern(nil)
    
    private let minimumDateNameLength = 5
    
    // 방문 일자 유효성 판별 (true는 통과)
    let visitDate: ObservablePattern<String> = ObservablePattern(nil)
    
    let isVisitDateVaild: ObservablePattern<Bool> = ObservablePattern(nil)
    
    // 데이트 시작시간 유효성 판별 (self.count > 0 인지)
    let dateStartAt: ObservablePattern<String> = ObservablePattern(nil)
    
    let isDateStartAtVaild: ObservablePattern<Bool> = ObservablePattern(nil)
    
    // 코스 등록 태그 생성
    var tagData: [ProfileTagModel] = []
    
    // 선택된 태그
    let isOverCount: ObservablePattern<Bool> = ObservablePattern(false)
    
    let isValidTag: ObservablePattern<Bool> = ObservablePattern(nil)
    
    let tagCount: ObservablePattern<Int> = ObservablePattern(0)
    
    private let minTagCnt = 1
    
    private let maxTagCnt = 3
    
    // 코스 지역 유효성 판별
    let dateLocation: ObservablePattern<String> = ObservablePattern(nil)
    
    let isDateLocationVaild: ObservablePattern<Bool> = ObservablePattern(nil)
    
    // 기타
    var isTimePicker: Bool?
    
    var country = ""
    
    var city = ""
    
    
    //MARK: - AddSecondView 전용 Viewmodel 변수
    
    var addPlaceCollectionViewDataSource: [AddCoursePlaceModel] = []
    
    let datePlace: ObservablePattern<String> = ObservablePattern(nil)
    
    let timeRequire: ObservablePattern<String> = ObservablePattern(nil)
    
    let isValidOfSecondNextBtn: ObservablePattern<Bool> = ObservablePattern(false)
    
    let editBtnEnableState: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isChange: (() -> Void)?
    
    var isEditMode: Bool = false
    
    let onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    let isSuccessPostData: ObservablePattern<Bool> = ObservablePattern(false)
    
    let onLoading: ObservablePattern<Bool> = ObservablePattern(false)
    
    let onFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
    
}

extension AddScheduleViewModel {
    
    /// 로딩뷰 세팅 함수
    func setLoading(isLoading: Bool) {
        self.onLoading.value = isLoading
    }
    
    /// Post 이전 prepare DatePlaceList
    private func preparePlacesForPost() -> [PostAddSchedulePlace] {
        var places: [PostAddSchedulePlace] = []
        
        for (index, model) in addScheduleSecondViewModel.addPlaceCollectionViewDataSource.enumerated() {
            if let timeString = model.timeRequire.split(separator: " ").first,
               let duration = Float(timeString) {
                let place = PostAddSchedulePlace(title: model.placeTitle, duration: duration, sequence: index)
                places.append(place)
            } else {
                print("❌ Failed to convert time")
            }
        }
        
        print(addScheduleSecondViewModel.addPlaceCollectionViewDataSource, "addPlaceCollectionViewDataSource : \(addScheduleSecondViewModel.addPlaceCollectionViewDataSource)")
        print(places, "places : \(places)")
        
        return places
    }
    
    func postAddScheduel() {
        self.setLoading(isLoading: true)
        
        let datePlaces = preparePlacesForPost()
        
        guard let dateName = addScheduleFirstViewModel.dateName.value,
              let visitDate = addScheduleFirstViewModel.visitDate.value,
              let dateStartAt = addScheduleFirstViewModel.dateStartAt.value
        else {
            print("failed to guard let")
            self.onFailNetwork.value = true // 네트워크 실패 상태 전달
            return
        }
        
        let country = addScheduleFirstViewModel.country
        let city = addScheduleFirstViewModel.city
        let postAddScheduleTags = addScheduleFirstViewModel.selectedTagData.map { PostAddScheduleTag(tag: $0) }
        
        NetworkService.shared.addScheduleService.postAddSchedule(course: PostAddScheduleRequest(
            title: dateName,
            date: visitDate,
            startAt: dateStartAt,
            tags: postAddScheduleTags,
            country: country,
            city: city,
            places: datePlaces)) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    print("Success: \(response)")
                    self.setLoading(isLoading: false)
                    self.isSuccessPostData.value = true
                case .reIssueJWT:
                    self.patchReissue { isSuccess in
                        self.onReissueSuccess.value = isSuccess
                    }
                default:
                    self.onFailNetwork.value = true
                    print("Failed to another reason")
                    return
                }
            }
    }
    
}
