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
    
    let editButton: DRTextButton = DRTextButton(
        title: StringLiterals.AddCourseOrSchedule.AddSecondView.edit,
        buttonName: .med_white_0,
        isEnabled: false
    )
    
    private let guideLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.AddCourseOrSchedule.AddSecondView.guideLabel,
        textLabelType: .clear(.med13_gray400),
        alignment: .left
    )
    
    var addPlaceCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let nextBtn: DRTextButton = DRTextButton(
        title: StringLiterals.AddCourseOrSchedule.AddSecondView.addSecondDoneBtnOfSchedule,
        buttonName: .bold_purple_14,
        isEnabled: false
    )
    
    
    // MARK: - Properties
    
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
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(153)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(inAddScheduleSecondView.separatorLine.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().offset(ScreenUtils.width * 16/375)
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
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(54)
        }
    }
    
    override func setStyle() {
        addPlaceCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 14.0
            layout.itemSize = CGSize(width: ScreenUtils.width * 343/375, height: 76)
            $0.collectionViewLayout =  layout
            $0.isScrollEnabled = true
            $0.showsVerticalScrollIndicator = false
            $0.dragInteractionEnabled = true
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
        let state: TextButtonType = isAble ? .med_white_0_purple : .med_white_0
        editButton.setButtonStyle(state, isEnabled: isAble)
    }
    
    func changeNextBtnState(flag: Bool) {
        let state: TextButtonType = flag ? .bold_purple_14 : .bold_gray200_14
        nextBtn.setButtonStyle(state, isEnabled: flag)
    }
    
}
