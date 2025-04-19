//
//  InAddScheduleSecondView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/18/24.
//

import UIKit

import SnapKit
import Then

final class InAddScheduleSecondView: BaseView {
    
    // MARK: - UI Properties
    
    private let contentTitleLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.AddCourseOrSchedule.AddSecondView.contentTitleLabelOfSchedule,
        textLabelType: .clear(.bold17_black),
        alignment: .left
    )
    
    private let contentSubTitleLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.AddCourseOrSchedule.AddSecondView.subTitleLabel,
        textLabelType: .clear(.med13_gray400),
        alignment: .left
    )
    
    private let placeRegistrationContainer: UIView = UIView()
    
    let datePlaceTextField: DRTextField = DRTextField(type: .addCourseSchedule(.datePlace))
    
    let timeRequireButton: DRTextButton = DRTextButton(title: StringLiterals.AddCourseOrSchedule.AddSecondView.timeRequiredPlaceHolder, buttonName: .semi_gray100_14)
    
    let addPlaceButton: DRImageButton = DRImageButton(image: UIImage(resource: .icAddcourseGray),
                                                      buttonName: .gray100_gray300_14,
                                                      isEnabled: false)
    
    let separatorLine: UIView = UIView()
    
    
    // MARK: - Properties
    
    private let enabledButtonType: DRButtonType = EnabledButton()
    
    private let disabledButtonType: DRButtonType = DisabledButton()
    
    private let addCourseDisabledButtonType: DRButtonType = addCoursePlaceDisabledButton()
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubviews (
            contentTitleLabel,
            contentSubTitleLabel,
            placeRegistrationContainer,
            separatorLine
        )
        
        placeRegistrationContainer.addSubviews(
            datePlaceTextField,
            timeRequireButton,
            addPlaceButton
        )
    }
    
    override func setLayout() {
        contentTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27)
            $0.horizontalEdges.equalToSuperview()
        }
        
        contentSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(contentTitleLabel.snp.bottom).offset(2)
            $0.horizontalEdges.equalToSuperview()
        }
        
        placeRegistrationContainer.snp.makeConstraints {
            $0.top.equalTo(contentSubTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        datePlaceTextField.snp.makeConstraints {
            $0.verticalEdges.leading.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(ScreenUtils.width / 375 * 206)
        }
        
        addPlaceButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
            $0.width.equalTo(ScreenUtils.width / 375 * 44)
        }
        
        timeRequireButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalTo(datePlaceTextField.snp.trailing).offset(ScreenUtils.width / 375 * 8)
            $0.trailing.equalTo(addPlaceButton.snp.leading).offset(ScreenUtils.width / 375 * -8)
        }
        
        separatorLine.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    override func setStyle() {        
        separatorLine.backgroundColor = UIColor(resource: .gray200)
    }
    
}


// MARK: - Extension Methods

extension InAddScheduleSecondView {
    
    func updateDatePlace(text: String) {
        datePlaceTextField.text = text
    }
    
    func updatetimeRequire(text: String) {
        let isEmpty = text.isEmpty
        let text = isEmpty ? StringLiterals.AddCourseOrSchedule.AddSecondView.timeRequiredPlaceHolder : text
        let state: TextButtonType = isEmpty ? .semi_gray100_14 : .semi_gray100_14_black
        timeRequireButton.setTitle(text, for: .normal)
        timeRequireButton.setButtonStyle(state)
    }
    
    func changeAddPlaceButtonState(flag: Bool) {
        let state: ImageButtonType = flag ? .deepPurple_white_14 : .gray100_gray300_14
        let image = flag ? UIImage(resource: .icAddcourseWhite) : UIImage(resource: .icAddcourseGray)
        addPlaceButton.setButtonStyle(
            image,
            state,
            isEnabled: flag
        )
    }
    
    /// 장소 등록 마치면 실행되는 함수
    func finishAddPlace() {
        // textfield 값 초기화 및 장소 등록 버튼 비활성화
        datePlaceTextField.text = ""
        timeRequireButton.setTitle(StringLiterals.AddCourseOrSchedule.AddSecondView.timeRequiredPlaceHolder, for: .normal)
        addPlaceButton.setButtonStyle(
            UIImage(resource: .icAddcourseGray),
            .gray100_gray300_14,
            isEnabled: false
        )
    }
    
}

