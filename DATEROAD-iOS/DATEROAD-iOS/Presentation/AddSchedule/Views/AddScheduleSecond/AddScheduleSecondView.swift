//
//  AddScheduleSecondView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import UIKit

import SnapKit
import Then

final class AddScheduleSecondView: BaseView {
    
    // MARK: - UI Properties
    
    let inAddScheduleSecondView = InAddScheduleSecondView()
    
    let editButton: UIButton = UIButton()
    
    private let guideLabel: UILabel = UILabel()
    
    var addPlaceCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let nextBtn: UIButton = UIButton()
    
    
    // MARK: - Properties
    
    private let enabledConfirmButtonType: DRButtonType = EnabledButton()
    
    private let disabledConfirmButtonType: DRButtonType = DisabledButton()
    
    private let enabledButtonType: DRButtonType = addCourseEditEnableButton()
    
    private let disabledButtonType: DRButtonType = addCourseEditDisableButton()
    
    private let warningType: DRErrorType = Warning()
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubviews(inAddScheduleSecondView,
                         editButton,
                         guideLabel,
                         addPlaceCollectionView,
                         nextBtn
        )
    }
    
    override func setLayout() {
        inAddScheduleSecondView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(153)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(inAddScheduleSecondView.separatorLine.snp.bottom).offset(10)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(59)
            $0.height.equalTo(30)
        }
        
        guideLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(editButton)
        }
        
        addPlaceCollectionView.snp.makeConstraints {
            $0.top.equalTo(editButton.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(nextBtn.snp.top).offset(-16)
        }
        
        nextBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(6)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(54)
        }
    }
    
    override func setStyle() {
        addPlaceCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 14.0
            layout.itemSize = CGSize(width: ScreenUtils.width * 0.914, height: 54)
            $0.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
            $0.collectionViewLayout =  layout
            $0.isScrollEnabled = true
            $0.showsVerticalScrollIndicator = false
            $0.dragInteractionEnabled = true
        }
        
        editButton.do {
            $0.setTitle(StringLiterals.AddCourseOrSchedule.AddSecondView.edit, for: .normal)
            $0.setButtonStatus(buttonType: enabledButtonType)
        }
        
        guideLabel.do {
            $0.setLabel(alignment: .left, textColor: UIColor(resource: .gray400), font: .suit(.body_med_13))
            $0.text = StringLiterals.AddCourseOrSchedule.AddSecondView.guideLabel
        }
        
        nextBtn.do {
            $0.setButtonStatus(buttonType: disabledConfirmButtonType)
            $0.setTitle(StringLiterals.AddCourseOrSchedule.AddSecondView.addSecondDoneBtnOfSchedule, for: .normal)
        }
    }
    
}


// MARK: - View Methods

extension AddScheduleSecondView {
    
    /// editMode 활성화라면
    func updateEditBtnText(flag: Bool) {
        let text = flag ? StringLiterals.AddCourseOrSchedule.AddSecondView.done : StringLiterals.AddCourseOrSchedule.AddSecondView.edit
        editButton.setTitle(text, for: .normal)
    }
    
    func editBtnState(isAble: Bool) {
        let state = isAble ? enabledButtonType : disabledButtonType
        editButton.do {
            $0.setButtonStatus(buttonType: state)
        }
    }
    
    func changeNextBtnState(flag: Bool) {
        let state = flag ? enabledConfirmButtonType : disabledConfirmButtonType
        nextBtn.setButtonStatus(buttonType: state)
    }
    
}
