//
//  AddScheduleSecondViewModel.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 10/22/24.
//

import UIKit

//MARK: - AddScheduleFirstViewController ViewModel

/// 일정등록 화면2 관련 ViewModel
class AddScheduleSecondViewModel: AddScheduleSecondViewModelInterface {
    
    init(amplitudeModel: AddScheduleAmplitude) {
        self.amplitudeModel = amplitudeModel
    }
    
    var addPlaceCollectionViewDataSource: [AddCoursePlaceModel] = []
    
    let datePlace: ObservablePattern<String> = ObservablePattern(nil)
    
    let timeRequire: ObservablePattern<String> = ObservablePattern(nil)
    
    let isValidOfSecondNextBtn: ObservablePattern<Bool> = ObservablePattern(false)
    
    let editBtnEnableState: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isChange: (() -> Void)?
    
    var amplitudeModel: AddScheduleAmplitude
    
    
    //MARK: - AddSecondView 전용 func
    
    func updatePlaceCollectionView() {
        print(addPlaceCollectionViewDataSource)
    }
    
    func updateTimeRequireTextField(text: String) {
        timeRequire.value = formatTimeRequireText(text: text)
    }
    
    /// 소요시간 표기전환 코드
    private func formatTimeRequireText(text: String) -> String {
        guard let doubleValue = Double(text) else { return text }
        return doubleValue.truncatingRemainder(dividingBy: 1) == 0 ? "\(Int(doubleValue)) 시간" : "\(doubleValue) 시간"
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
        
        self.amplitudeModel.dateDetailLocation = false
        self.amplitudeModel.dateDetailTime = false
        self.isChange?()
    }
    
    func isDataSourceNotEmpty() {
        let flag = (addPlaceCollectionViewDataSource.count >= 1) ? true : false
        editBtnEnableState.value = flag
    }
    
    func isSourceMoreThanOne() {
        let cnt = addPlaceCollectionViewDataSource.count
        self.amplitudeModel.dateCourseNum = cnt
        let flag = (cnt >= 2)
        print("지금 데이터소스 개수 : \(addPlaceCollectionViewDataSource.count)\nflag: \(flag)")
        isValidOfSecondNextBtn.value = flag
    }
    
}
