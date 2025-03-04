//
//  AddFirstView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/5/24.
//

import UIKit

import SnapKit
import Then

final class AddFirstView: BaseView {
    
    // MARK: - UI Properties
    
    private let textFieldStackView = UIStackView()
    
    let dateNameTextField = DRTextField(type: .AddCourseSchedule(.dateName))
    let visitDateTextField = DRTextField(type: .AddCourseSchedule(.visitDate))
    let dateStartAtTextField = DRTextField(type: .AddCourseSchedule(.dateStartAt))
    
    private let tagContainer = UIView()
    private let tagTitleLabel = UILabel()
    let tendencyTagCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let datePlaceTextField = DRTextField(type: .AddCourseSchedule(.dateLocation))
    
    private let sixCheckNextBtnContainer = UIView()
    let sixCheckNextButton = DRCommonButton(type: .nextValidType(title: StringLiterals.AddCourseOrSchedule.AddFirstView.addFirstNextBtnOfCourse))

    
    // MARK: - Properties
    
    private let enabledButtonType: DRButtonType = EnabledButton()
    
    private let disabledButtonType: DRButtonType = DisabledButton()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(
            textFieldStackView,
            tagContainer,
            datePlaceTextField,
            sixCheckNextBtnContainer)
        
        textFieldStackView.addArrangedSubviews(
            dateNameTextField,
            visitDateTextField,
            dateStartAtTextField)
        
        tagContainer.addSubviews(tagTitleLabel, tendencyTagCollectionView)
        
        sixCheckNextBtnContainer.addSubview(sixCheckNextButton)
    }
    
    override func setLayout() {
        textFieldStackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(184)
        }
        
        tagContainer.snp.makeConstraints {
            $0.top.equalTo(textFieldStackView.snp.bottom).offset(24)
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
        
        sixCheckNextBtnContainer.snp.makeConstraints {
            $0.top.equalTo(datePlaceTextField.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        sixCheckNextButton.snp.makeConstraints {
            $0.height.equalTo(54)
            $0.bottom.horizontalEdges.equalToSuperview()
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
        
        textFieldStackView.do {
            $0.axis = .vertical
            $0.spacing = 20
            $0.distribution = .fillEqually
        }
        
        [ dateStartAtTextField].forEach { view in
            view.do {
                $0.backgroundColor = UIColor(resource: .gray100)
                $0.layer.cornerRadius = 13
                $0.layer.borderWidth = 0
                $0.layer.borderColor = UIColor(resource: .alertRed).cgColor
            }
        }
        
        tagTitleLabel.do {
            $0.setLabel(alignment: .left,
                        textColor: UIColor(resource: .drBlack),
                        font: .suit(.body_semi_15))
            $0.text = StringLiterals.AddCourseOrSchedule.AddFirstView.tagTitle
        }
    }
    
}


// MARK: - Extension Methods

extension AddFirstView {
    
    func updateDateName(text: String) {
        dateNameTextField.text = text
        dateNameTextField.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
    }
    
    func updateVisitDate(text: String) {
        visitDateTextField.text = text
    }
    
    func updatedateStartTime(text: String) {
        let updatedText = text
            .replacingOccurrences(of: "오전", with: "AM")
            .replacingOccurrences(of: "오후", with: "PM")
        
        dateStartAtTextField.text = updatedText
    }
    
    func updateTagButtonStyle(btn: UIButton, isSelected: Bool) {
        btn.do {
            $0.configuration?.background.backgroundColor = isSelected ? UIColor(resource: .deepPurple) : UIColor(resource: .gray100)
            $0.configuration?.baseForegroundColor = isSelected ? UIColor(resource: .drWhite) : UIColor(resource: .drBlack)
        }
    }
    
    func updateSixCheckButton(isValid: Bool) {
        sixCheckNextButton.isEnabled = !isValid
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
