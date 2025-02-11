//
//  AddScheduleViewModel.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import Foundation

final class AddScheduleViewModel: Serviceable {
    
    let viewPath: String
    
    var isBroughtData: Bool
    
    var viewedDateCourseByMeData: CourseDetailViewModel?
    
    // MARK: - Initializer
    
    init(viewPath: String, isBroughtData: Bool) {
        self.viewPath = viewPath
        self.isBroughtData = isBroughtData
        
        fetchTagData()
        bindViewModel()
    }
    
    
    //MARK: - AddFirstCourse 사용되는 ViewModel
    
    var tagData: [ProfileTagModel] = []
    
    var pastDateTagIndex = [Int]()
    
    var selectedTagData: [String] = []
    
    // 데이트 이름
    let inputDateName: ObservablePattern<String> = ObservablePattern(nil)
    let outputDateNameVaild: ObservablePattern<Bool> = ObservablePattern(false)    
    
    // 데이트 방문일자
    let inputVisitDate: ObservablePattern<Date> = ObservablePattern(nil)
    let outputVisitDateVaild: ObservablePattern<Bool> = ObservablePattern(false)
    
    // 데이트 시작시간
    let inputDataStartAtTransForm: ObservablePattern<Date> = ObservablePattern(nil)
    let inputDateStartAt: ObservablePattern<String> = ObservablePattern(nil)
    let outputDateStartAtVaild: ObservablePattern<Bool> = ObservablePattern(nil)
    
    // 데이트 태그
    let outputDateTag: ObservablePattern<Bool> = ObservablePattern(false)
    
    // 데이트 로케이션
    let inputDateLocation: ObservablePattern<[String]> = ObservablePattern(Array(repeating: "", count: 2))
    let outputDateLocation: ObservablePattern<String> = ObservablePattern("")
    
    let inputIsBroughtData: ObservablePattern<Bool> = ObservablePattern(false)
    let outputIsBroughtDataConfigured: ObservablePattern<Bool> = ObservablePattern(false)
    
    
    //MARK: - AddSecondView 전용 Viewmodel 변수
    
    var pastDatePlaces = [TimelineModel]()
    
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
    
    
    //MARK: - AddSchedule Amplitude 관련 변수
    
    var addScheduleAmplitude = AddScheduleAmplitudeState()
    
    // tag 세팅 함수
    private func fetchTagData() {
        tagData = TendencyTag.allCases.map { $0.tag }
    }
    
    private func bindViewModel() {
        inputDateName.bind { [weak self] value in
            guard let self,
                  let value else {return}
            self.addScheduleAmplitude.dateTitle = !value.isEmpty ? true : false
            self.satisfyDateName(str: value)
        }
        
        inputVisitDate.bind { [weak self] _ in
            guard let self else {return}
            self.addScheduleAmplitude.dateDate = true
            self.setVisitDate()
        }
        
        inputDataStartAtTransForm.lazyBind { [weak self] selectedDate in
            guard let self,
                  let selectedDate else {return}
            var formattedTime = DateFormatterManager.shared.timeFormatter.string(from: selectedDate)
            formattedTime = formattedTime
                .replacingOccurrences(of: "오전", with: "AM")
                .replacingOccurrences(of: "오후", with: "PM")
            self.inputDateStartAt.value = formattedTime
        }
        
        inputDateStartAt.bind { [weak self] _ in
            guard let self else {return}
            self.addScheduleAmplitude.dateTime = true
            self.setDateStartAt()
        }
        
        inputDateLocation.lazyBind { [weak self] locationArr in
            guard let self, let locationArr else {return}
            isDateLocationValid(LocationArr: locationArr)
        }
        
        inputIsBroughtData.lazyBind { [weak self] isBroughtData in
            guard let self, let isBroughtData else {return}
            if isBroughtData {
                self.fetchPastDate()
                AmplitudeManager.shared.trackEventWithProperties(StringLiterals.Amplitude.EventName.viewAddBringcourse, properties: [StringLiterals.Amplitude.Property.viewPath: viewPath])
            }
        }
    }
    
}


//MARK: - AddScheduleViewModel: PastDateSetting

extension AddScheduleViewModel {
    
    func isDateLocationValid(LocationArr: [String]) {
        if !LocationArr.contains("") && LocationArr.count == 2 {
            addScheduleAmplitude.dateArea = true
            outputDateLocation.value = LocationArr[1]
        }
    }
    
    // 일정등록(불러오기) 시 데이터 세팅 함수
    func fetchPastDate() {
        //isSuccessGetData가 true인 시점에 불러와야 data안의 값들이 공란이 아님.
        //추후 리펙
        viewedDateCourseByMeData?.isSuccessGetData.bind { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess == true {
                self.setLoading(isLoading: true)
                if let data = self.viewedDateCourseByMeData {
                    inputDateName.value = data.titleHeaderData.value?.title
                    inputDateStartAt.value = data.startAt
                    outputDateLocation.value = data.titleHeaderData.value?.city
                    
                    //동네.KOR 불러와서 지역, 동네 ENG 버전 알아내는 미친 로직
                    let cityName = data.titleHeaderData.value?.city ?? ""
                    if let result = LocationMapper.getCountryAndCity(from: cityName) {
                        let country = result.country.rawValue
                        let city = result.city.rawValue
                        self.inputDateLocation.value?[0] = country
                        self.inputDateLocation.value?[1] = city
                        self.outputDateLocation.value = city
                    }
                    
                    //태그 추적해서 미리 셀렉 및 개수 표시 해버리는 진짜 미쳐버린 로직
                    guard let tags = viewedDateCourseByMeData?.tagArr else {return}
                    selectedTagData = tags.map { $0.tag }
                    pastDateTagIndex = getTagIndices(from: selectedTagData)
                    pastDateTagIndex.sort()
                    
                    print("pastDateTagIndex values: \(pastDateTagIndex)")
                    outputDateTag.value = true
                    addScheduleAmplitude.dateTagNum = selectedTagData.count
                    
                    outputDateNameVaild.value = true
                    outputDateStartAtVaild.value = true
                    
                    ///코스 등록 2 AddPlaceCollectionView 구성
                    if let result = data.timelineData.value {
                        pastDatePlaces = result
                    }
                    
                    self.setLoading(isLoading: false)
                    outputIsBroughtDataConfigured.value = true
                }
            }
        }
    }
    
    //불러온 데이터에 선택된 tag index 값 넣어주는 함수
    func getTagIndices(from tags: [String]) -> [Int] {
        return tags.compactMap { tag in
            TendencyTag.allCases.firstIndex { $0.tag.english == tag }
        }
    }
    
}


//MARK: - viewModel: AddScheduleFirstVC 함수

extension AddScheduleViewModel {
    
    private func satisfyDateName(str: String) {
        let minimumDateNameLength = 5
        outputDateNameVaild.value = str.count >= minimumDateNameLength
        
    }
    
    private func setVisitDate() {
        guard let date = inputVisitDate.value else {return}
        let formattedDate = DateFormatterManager.shared.dateFormatter.string(from: date)
        outputVisitDateVaild.value = !(formattedDate.isEmpty)
    }
    
    func setDateStartAt() {
        outputDateStartAtVaild.value = !(inputDateStartAt.value?.isEmpty ?? true)
    }
    
    func countSelectedTag(isSelected: Bool, tag: String) {
        if isSelected {
            if !selectedTagData.contains(tag) {
                selectedTagData.append(tag)
            }
        } else {
            if let index = selectedTagData.firstIndex(of: tag) {
                selectedTagData.remove(at: index)
            }
        }
        print("selectedTagData: \(selectedTagData.count)")
        outputDateTag.value = true
        addScheduleAmplitude.dateTagNum = selectedTagData.count
    }
    
    func isEnableNextButton() -> Bool {
        guard let dateNameVaild = outputDateNameVaild.value,
              let isValidTag = outputDateTag.value,
              let visitDateVaild = outputVisitDateVaild.value,
              let dateStartAtVaild = outputDateStartAtVaild.value
        else {
            print("isOkSixBtn guard let Error")
            return false
        }
        let isDateLocationVaild = outputDateLocation.value != ""
        
        return [dateNameVaild, isValidTag, visitDateVaild, isDateLocationVaild, dateStartAtVaild].allSatisfy { $0 }
    }
    
}


//MARK: - viewModel: AddScheduleSecondVC 함수

extension AddScheduleViewModel {
    
    func updatePlaceCollectionView() {
        print(addPlaceCollectionViewDataSource)
    }
    
    func updateTimeRequireTextField(text: String) {
        var formattedText = text
        if let doubleValue = Double(text) {
            formattedText = doubleValue.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(doubleValue)) : String(doubleValue)
        }
        timeRequire.value = "\(formattedText) 시간"
    }
    
    func isAbleAddBtn() -> Bool {
        return !(datePlace.value?.isEmpty ?? true)
        && !(timeRequire.value?.isEmpty ?? true)
    }
    
    func tapAddBtn(datePlace: String, timeRequire: String) {
        addPlaceCollectionViewDataSource.append(AddCoursePlaceModel(placeTitle: datePlace, timeRequire: timeRequire))
        
        //viewmodel 값 초기화
        self.datePlace.value = ""
        self.timeRequire.value = ""
        
        self.addScheduleAmplitude.dateDetailLocation = false
        self.addScheduleAmplitude.dateDetailTime = false
        self.isChange?()
    }
    
    /// dataSource 개수 >= 2 라면 '확인' 버튼 활성화
    func isSourceMoreThanOne() {
        let cnt = addPlaceCollectionViewDataSource.count
        self.addScheduleAmplitude.dateCourseNum = cnt
        let flag = (cnt >= 2)
        print("지금 데이터소스 개수 : \(addPlaceCollectionViewDataSource.count)\nflag: \(flag)")
        isValidOfSecondNextBtn.value = flag
    }
    
    /// 데이터 0개면 true 반환
    func isDataSourceNotEmpty() {
        let flag = (addPlaceCollectionViewDataSource.count >= 1) ? true : false
        editBtnEnableState.value = flag
    }
    
    /// 로딩뷰 세팅 함수
    func setLoading(isLoading: Bool) {
        self.onLoading.value = isLoading
    }
    
    func postAddScheduel() {
        self.setLoading(isLoading: true)
        
        var places: [PostAddSchedulePlace] = []
        
        for (index, model) in addPlaceCollectionViewDataSource.enumerated() {
            // Extract the numeric part from the timeRequire string
            let timeComponents = model.timeRequire.split(separator: " ")
            
            if let timeString = timeComponents.first {
                if let duration = Float(timeString) {
                    let place = PostAddSchedulePlace(title: model.placeTitle, duration: duration, sequence: index)
                    places.append(place)
                    print("👍👍👍👍 : place added - \(place)")
                } else {
                    print("❌❌❌ Step 1: Failed to convert timeString \(timeString) to Float")
                }
            } else {
                print("❌❌❌ Step 2: Failed to extract timeString from \(model.timeRequire)")
            }
        }
        print(addPlaceCollectionViewDataSource, "addPlaceCollectionViewDataSource : \(addPlaceCollectionViewDataSource)")
        
        guard let dateName = inputDateName.value,
              let visitDate = inputVisitDate.value,
              let dateStartAt = inputDateStartAt.value
        else {return}
        let country = inputDateLocation.value?[0] ?? ""
        let city = inputDateLocation.value?[1] ?? ""
        let postAddScheduleTags = selectedTagData.map { PostAddScheduleTag(tag: $0) }
        let formattedDate = DateFormatterManager.shared.dateFormatter.string(from: visitDate)
        
        NetworkService.shared.addScheduleService.postAddSchedule(course: PostAddScheduleRequest(title: dateName,
                                                                                                date: formattedDate,
                                                                                                startAt: dateStartAt,
                                                                                                tags: postAddScheduleTags,
                                                                                                country: country,
                                                                                                city: city,
                                                                                                places: places)) { result in
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


//MARK: - AddScheduleAmplitudeState

struct AddScheduleAmplitudeState {
    
    // addSchedule 관련 amplitude 변수들
    var dateTitle: Bool = false
    var dateDate: Bool = false
    var dateTime: Bool = false
    var dateTagNum: Int = 0
    var dateArea: Bool = false
    var dateDetailLocation: Bool = false
    var dateDetailTime: Bool = false
    var dateCourseNum: Int = 0
    
    func sendAmplitudeEvent(step: Int) {
        guard let eventName = makeEventName(step: step) else {
            print("Invalid EventName in sendAmplitudeEvent")
            return
        }
        let properties = makeProperties(step: step)
        AmplitudeManager.shared.trackEventWithProperties(eventName, properties: properties)
    }
    
    func makeEventName(step: Int) -> String? {
        switch step {
        case 1:
            return StringLiterals.Amplitude.EventName.clickSchedule1Back
        case 2:
            return StringLiterals.Amplitude.EventName.clickSchedule2Back
        default:
            print("makeEventName Error")
            return nil
        }
    }
    
    func makeProperties(step: Int) -> [String: Any] {
        switch step {
        case 1:
            return [
                StringLiterals.Amplitude.Property.dateTitle: self.dateTitle,
                StringLiterals.Amplitude.Property.dateDate: self.dateDate,
                StringLiterals.Amplitude.Property.dateTime: self.dateTime,
                StringLiterals.Amplitude.Property.dateTagNum: self.dateTagNum,
                StringLiterals.Amplitude.Property.dateArea: self.dateArea
            ]
        case 2:
            return [
                StringLiterals.Amplitude.Property.dateDetailLocation: dateDetailLocation,
                StringLiterals.Amplitude.Property.dateDetailTime: dateDetailTime,
                StringLiterals.Amplitude.Property.dateCourseNum: dateCourseNum
            ]
        default:
            print("makeProperties Error")
            return [:]
        }
    }
    
}
