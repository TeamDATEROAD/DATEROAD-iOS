//
//  InAddScheduleFirstView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import UIKit

import SnapKit
import Then

final class InAddScheduleFirstView: BaseView {
    
    // MARK: - UI Properties
    
    let dateNameTextField = DRTextField(type: .addCourseSchedule(.dateName))
    
    let visitDateTextField = DRTextField(type: .addCourseSchedule(.visitDate))
    
    let dateStartAtTextField = DRTextField(type: .addCourseSchedule(.dateStartAt))
    
    private let tagContainer = UIView()
    
    private let tagTitleLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.AddCourseOrSchedule.AddFirstView.tagTitle,
        textLabelType: .clear(.semi15_black),
        alignment: .left
    )
    
    let datePlaceTextField = DRTextField(type: .addCourseSchedule(.dateLocation))
    
    let sixCheckNextButton: DRTextButton = DRTextButton(title: StringLiterals.AddCourseOrSchedule.AddFirstView.addFirstNextBtnOfSchedule,
                                                        buttonName: .bold_gray200_14,
                                                        isEnabled: false)
    
    let tendencyTagCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    // MARK: - Properties
    
    private let enabledButtonType: DRButtonType = EnabledButton()
    
    private let disabledButtonType: DRButtonType = DisabledButton()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(
            dateNameTextField,
            visitDateTextField,
            dateStartAtTextField,
            tagContainer,
            datePlaceTextField,
            sixCheckNextButton
        )
        
        tagContainer.addSubviews(tagTitleLabel, tendencyTagCollectionView)
    }
    
    override func setLayout() {
        dateNameTextField.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        visitDateTextField.snp.makeConstraints {
            $0.top.equalTo(dateNameTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        dateStartAtTextField.snp.makeConstraints {
            $0.top.equalTo(visitDateTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        tagContainer.snp.makeConstraints {
            $0.top.equalTo(dateStartAtTextField.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(140)
        }
        
        tagTitleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        tendencyTagCollectionView.snp.makeConstraints {
            $0.top.equalTo(tagTitleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        datePlaceTextField.snp.makeConstraints {
            $0.top.equalTo(tagContainer.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        sixCheckNextButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(54)
        }
    }
    
    override func setStyle() {
        tendencyTagCollectionView.do {
            $0.contentInsetAdjustmentBehavior = .never
            $0.showsVerticalScrollIndicator = false
            let layout = CollectionViewLeftAlignFlowLayout()
            layout.cellSpacing = 8
            $0.collectionViewLayout = layout
        }
    }
    
}


// MARK: - Extension Methods

extension InAddScheduleFirstView {
    
    func updateDateName(text: String) {
        dateNameTextField.text = text
    }
    
    func updateVisitDate(text: String) {
        visitDateTextField.text = text
    }
    
    func updatedateStartTime(text: String) {
        dateStartAtTextField.text = text
            .replacingOccurrences(of: "오전", with: "AM")
            .replacingOccurrences(of: "오후", with: "PM")
    }
    
    func updateTagButtonStyle(btn: UIButton, isSelected: Bool) {
        btn.do {
            $0.configuration?.background.backgroundColor = isSelected ? UIColor(resource: .deepPurple) : UIColor(resource: .gray100)
            $0.configuration?.baseForegroundColor = isSelected ? UIColor(resource: .drWhite) : UIColor(resource: .drBlack)
        }
    }
    
    func updateSixCheckButton(isValid: Bool) {
        let btnState: TextButtonType = isValid ? .bold_purple_14 : .bold_gray200_14
        sixCheckNextButton.setButtonStyle(btnState, isEnabled: isValid)
    }
    
    func updateTagCount(count: Int) {
        tagTitleLabel.text = "데이트 코스와 어울리는 태그를 선택해 주세요 (\(count)/3)"
    }
    
    func updateTag(button: UIButton, buttonType: DRButtonType) {
        button.setButtonStatus(buttonType: buttonType)
    }
    
    func updateDateLocation(text: String) {
        datePlaceTextField.text = text
    }
    
}

