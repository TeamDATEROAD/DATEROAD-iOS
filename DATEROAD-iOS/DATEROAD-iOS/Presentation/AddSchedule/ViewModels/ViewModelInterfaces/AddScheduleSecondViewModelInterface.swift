//
//  AddScheduleSecondViewModelInterface.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 10/22/24.
//

import UIKit

/// 일정등록 화면2 Interface
protocol AddScheduleSecondViewModelInterface {
    
    //MARK: - Observable & Properties
    
    var addPlaceCollectionViewDataSource: [AddCoursePlaceModel] { get set }
    
    var datePlace: ObservablePattern<String> { get }
    
    var timeRequire: ObservablePattern<String> { get }
    
    var isValidOfSecondNextBtn: ObservablePattern<Bool> { get }
    
    var editBtnEnableState: ObservablePattern<Bool> { get }
    
    var isChange: (() -> Void)? { get set }
    
    
    //MARK: - Func()
    
    /// Related to DatePlace List
    /// - 업데이트된 장소 목록 출력
    func updatePlaceCollectionView()
    
    /// Related to TimeRequire
    /// - 소요시간 표시
    func updateTimeRequireTextField(text: String)
    
    /// Related to AddPlace
    /// - 장소 등록 버튼 유효성 검사
    func isAbleAddBtn() -> Bool
    
    /// Related to AddPlace
    /// - 입력한 장소 List에 등록
    func tapAddBtn(datePlace: String, timeRequire: String)
    
    /// Related to EditBtn
    /// - List에 추가된 장소가 1개 이상 여부
    /// - Edit Btn 활성화 관련
    func isDataSourceNotEmpty()
    
    /// Related to DatePlace List
    /// - List에 추가된 장소 2개 이상 여부
    /// - dataSource 개수 >= 2 라면 등록 버튼 활성화
    func isSourceMoreThanOne()
    
}
