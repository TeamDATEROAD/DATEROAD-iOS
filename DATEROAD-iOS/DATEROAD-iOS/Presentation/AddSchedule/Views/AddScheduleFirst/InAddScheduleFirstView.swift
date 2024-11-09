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
    
    let dateNameTextField = UITextField()
    
    let visitDateContainer = UIView()
    
    private let visitDateLabel = UILabel()
    
    private let visitDateImage = UIImageView()
    
    let dateStartAtContainer = UIView()
    
    private let dateStartTimeLabel = UILabel()
    
    private let dateStartTimeImage = UIImageView()
    
    private let tagContainer = UIView()
    
    private let tagTitleLabel = UILabel()
    
    let datePlaceContainer = UIView()
    
    private let datePlaceLabel = UILabel()
    
    private let datePlaceImage = UIImageView()
    
    let sixCheckNextButton = UIButton()
    
    let tendencyTagCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    // MARK: - Properties
    
    private let enabledButtonType: DRButtonType = EnabledButton()
    
    private let disabledButtonType: DRButtonType = DisabledButton()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(dateNameTextField,
                         visitDateContainer,
                         dateStartAtContainer,
                         tagContainer,
                         datePlaceContainer,
                         sixCheckNextButton)
        
        visitDateContainer.addSubviews(visitDateLabel, visitDateImage)
        
        dateStartAtContainer.addSubviews(dateStartTimeLabel, dateStartTimeImage)
        
        tagContainer.addSubviews(tagTitleLabel, tendencyTagCollectionView)
        
        datePlaceContainer.addSubviews(datePlaceLabel, datePlaceImage)
    }
    
    override func setLayout() {
        dateNameTextField.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        visitDateContainer.snp.makeConstraints {
            $0.top.equalTo(dateNameTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        visitDateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        visitDateImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(19)
            $0.width.equalTo(15)
            $0.height.equalTo(17)
        }
        
        dateStartAtContainer.snp.makeConstraints {
            $0.top.equalTo(visitDateContainer.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        dateStartTimeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        dateStartTimeImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(18)
            $0.size.equalTo(17)
        }
        
        tagContainer.snp.makeConstraints {
            $0.top.equalTo(dateStartAtContainer.snp.bottom).offset(24)
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
        
        datePlaceContainer.snp.makeConstraints {
            $0.top.equalTo(tagContainer.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        datePlaceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        datePlaceImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(18)
            $0.width.equalTo(10)
            $0.height.equalTo(5)
        }
        
        sixCheckNextButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(52)
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
        
        [dateNameTextField, visitDateContainer, dateStartAtContainer].forEach { view in
            view.do {
                $0.backgroundColor = UIColor(resource: .gray100)
                $0.layer.cornerRadius = 13
                $0.layer.borderWidth = 0
                $0.layer.borderColor = UIColor(resource: .alertRed).cgColor
            }
        }
        
        visitDateImage.image = UIImage(resource: .calendar)
        dateStartTimeImage.image = UIImage(resource: .time)
        
        dateNameTextField.do {
            $0.setPlaceholder(placeholder: StringLiterals.AddCourseOrSchedule.AddFirstView.dateNmaePlaceHolder,
                              fontColor: .gray300,
                              font: .suit(.body_semi_13))
            $0.setLeftPadding(amount: 16)
            $0.setRightPadding(amount: 6)
        }
        
        visitDateLabel.do {
            $0.setLabel(text: StringLiterals.AddCourseOrSchedule.AddFirstView.visitDateLabel,
                        alignment: .left,
                        textColor: UIColor(resource: .gray300),
                        font: UIFont.suit(.body_semi_13))
        }
        
        dateStartTimeLabel.do {
            $0.setLabel(text: StringLiterals.AddCourseOrSchedule.AddFirstView.dateStartTimeLabel,
                        alignment: .left,
                        textColor: UIColor(resource: .gray300),
                        font: UIFont.suit(.body_semi_13))
        }
        
        tagTitleLabel.do {
            $0.setLabel(alignment: .left,
                        textColor: UIColor(resource: .drBlack),
                        font: .suit(.body_semi_15))
            $0.text = StringLiterals.AddCourseOrSchedule.AddFirstView.tagTitle
        }
        
        datePlaceContainer.do {
            $0.backgroundColor = .gray100
            $0.layer.cornerRadius = 14
        }
        
        datePlaceLabel.do {
            $0.setLabel(text: StringLiterals.AddCourseOrSchedule.AddFirstView.datePlaceLabel,
                        alignment: .left,
                        textColor: UIColor(resource: .gray300),
                        font: .suit(.body_semi_13))
        }
        
        datePlaceImage.do {
            $0.image = UIImage(resource: .downArrow)
            $0.contentMode = .scaleToFill
        }
        
        sixCheckNextButton.do {
            $0.setTitle(StringLiterals.AddCourseOrSchedule.AddFirstView.addFirstNextBtnOfSchedule, for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_med_13)
            $0.setButtonStatus(buttonType: disabledButtonType)
        }
    }
    
}


// MARK: - Extension Methods

extension InAddScheduleFirstView {
    
    func updateDateName(text: String) {
        dateNameTextField.text = text
        dateNameTextField.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
    }
    
    func updateVisitDate(text: String) {
        visitDateLabel.do {
            $0.text = text
            $0.textColor = UIColor(resource: .drBlack)
        }
    }
    
    func updatedateStartTime(text: String) {
        let updatedText = text
            .replacingOccurrences(of: "오전", with: "AM")
            .replacingOccurrences(of: "오후", with: "PM")
        
        dateStartTimeLabel.do {
            $0.text = updatedText
            $0.textColor = UIColor(resource: .drBlack)
        }
    }
    
    func updateTagButtonStyle(btn: UIButton, isSelected: Bool) {
        btn.do {
            $0.configuration?.background.backgroundColor = isSelected ? UIColor(resource: .deepPurple) : UIColor(resource: .gray100)
            $0.configuration?.baseForegroundColor = isSelected ? UIColor(resource: .drWhite) : UIColor(resource: .drBlack)
        }
    }
    
    func updateSixCheckButton(isValid: Bool) {
        let btnState = isValid ? enabledButtonType : disabledButtonType
        sixCheckNextButton.setButtonStatus(buttonType: btnState)
    }
    
    func updateTagCount(count: Int) {
        tagTitleLabel.text = "데이트 코스와 어울리는 태그를 선택해 주세요 (\(count)/3)"
    }
    
    func updateTag(button: UIButton, buttonType: DRButtonType) {
        button.setButtonStatus(buttonType: buttonType)
    }
    
    func updateDateLocation(text: String) {
        if text.count != 0 {
            datePlaceLabel.do {
                $0.textColor = UIColor(resource: .drBlack)
                $0.text = text
            }
        } else {
            datePlaceLabel.do {
                $0.setLabel(text: StringLiterals.AddCourseOrSchedule.AddFirstView.datePlaceLabel,
                            alignment: .left,
                            textColor: UIColor(resource: .gray300),
                            font: .suit(.body_semi_13))
            }
        }
    }
    
}

