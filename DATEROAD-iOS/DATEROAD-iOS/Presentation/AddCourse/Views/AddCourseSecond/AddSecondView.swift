//
//  AddSecondView.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/9/24.
//

import UIKit

import SnapKit
import Then

final class AddSecondView: BaseView {
    
    // MARK: - UI Properties
    
    private let container: UIView = UIView()
    
    private let contentTitleLabel: UILabel = UILabel()
    
    private let contentSubTitleLabel: UILabel = UILabel()
    
    private let placeRegistrationContainer: UIView = UIView()
    
    let datePlaceTextField: UITextField = UITextField()
    
    let timeRequireButton: DRTextButton = DRTextButton(title: StringLiterals.AddCourseOrSchedule.AddSecondView.timeRequiredPlaceHolder, buttonName: .semi_gray100_14)
    
    let addPlaceButton: UIButton = UIButton()
    
    let separatorLine: UIView = UIView()
    
    let nextBtn: DRTextButton = DRTextButton(
        title: StringLiterals.AddCourseOrSchedule.AddSecondView.addSecondNextBtnOfCourse,
        buttonName: .bold_gray200_14,
        isEnabled: false
    )
    
    
    // MARK: - Properties
    
    private let enabledButtonType: DRButtonType = EnabledButton()
    
    private let disabledButtonType: DRButtonType = DisabledButton()
    
    private let addCourseDisabledButtonType: DRButtonType = addCoursePlaceDisabledButton()
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        addSubviews(container,
                    contentTitleLabel,
                    contentSubTitleLabel,
                    placeRegistrationContainer,
                    separatorLine,
                    nextBtn)
        
        placeRegistrationContainer.addSubviews(datePlaceTextField,
                                               timeRequireButton,
                                               addPlaceButton)
    }
    
    override func setLayout() {
        contentTitleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
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
            $0.leading.equalTo(datePlaceTextField.snp.trailing).offset(ScreenUtils.width / 375 * 8).priority(.low)
            $0.trailing.equalTo(addPlaceButton.snp.leading).offset(ScreenUtils.width / 375 * -8).priority(.low)
        }
        
        separatorLine.snp.makeConstraints {
            $0.top.equalTo(placeRegistrationContainer.snp.bottom).offset(21)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        nextBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(54)
        }
    }
    
    override func setStyle() {
        contentTitleLabel.setLabel(text: StringLiterals.AddCourseOrSchedule.AddSecondView.contentTitleLabelOfCourse,
                                   alignment: .left,
                                   textColor: UIColor(resource: .drBlack),
                                   font: .suit(.body_bold_17))
        
        contentSubTitleLabel.setLabel(text: StringLiterals.AddCourseOrSchedule.AddSecondView.subTitleLabel,
                                      alignment: .left,
                                      textColor: UIColor(resource: .gray400),
                                      font: .suit(.body_med_13))
        
        datePlaceTextField.do {
            $0.setPlaceholder(placeholder: StringLiterals.AddCourseOrSchedule.AddSecondView.datePlacePlaceHolder,
                              fontColor: UIColor(resource: .gray300),
                              font: UIFont.suit(.body_semi_13))
            $0.setLeftPadding(amount: 14)
            $0.setRightPadding(amount: 4)
            $0.textAlignment = .left
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.layer.borderWidth = 0
            $0.layer.cornerRadius = 14
            $0.autocorrectionType = .no
            $0.spellCheckingType = .no
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 13, weight: .semibold), .foregroundColor: UIColor(resource: .drBlack)]
            $0.defaultTextAttributes = attributes
        }
        
        addPlaceButton.do {
            $0.setImage(UIImage(resource: .icAddcourseWhite), for: .normal)
            $0.setImage(UIImage(resource: .icAddcourseGray), for: .disabled)
            $0.setButtonStatus(buttonType: addCourseDisabledButtonType)
            $0.imageView?.snp.makeConstraints {
                $0.size.equalTo(14)
            }
        }
        
        separatorLine.backgroundColor = UIColor(resource: .gray200)
    }
    
}


// MARK: - Extension Methods

extension AddSecondView {
    
    func updateDatePlace(text: String) {
        datePlaceTextField.text = text
        datePlaceTextField.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
    }
    
    func updatetimeRequire(text: String) {
        let isEmpty = text.isEmpty
        let text = isEmpty ? StringLiterals.AddCourseOrSchedule.AddSecondView.timeRequiredPlaceHolder : text
        let state: ButtonName = isEmpty ? .semi_gray100_14 : .semi_gray100_14_black
        timeRequireButton.setTitle(text, for: .normal)
        timeRequireButton.setButtonStyle(state)
    }
    
    func changeAddPlaceButtonState(flag: Bool) {
        let state = flag ? enabledButtonType : addCourseDisabledButtonType
        addPlaceButton.setButtonStatus(buttonType: state)
    }
    
    /// 장소 등록 마치면 실행되는 함수
    func finishAddPlace() {
        // textfield 값 초기화 및 장소 등록 버튼 비활성화
        datePlaceTextField.text = ""
        timeRequireButton.setTitle(StringLiterals.AddCourseOrSchedule.AddSecondView.timeRequiredPlaceHolder, for: .normal)
        addPlaceButton.setButtonStatus(buttonType: addCourseDisabledButtonType)
    }
    
    func changeNextBtnState(flag: Bool) {
        let state: ButtonName = flag ? .bold_purple_14 : .bold_gray200_14
        nextBtn.setButtonStyle(state, isEnabled: flag)
    }
    
}
