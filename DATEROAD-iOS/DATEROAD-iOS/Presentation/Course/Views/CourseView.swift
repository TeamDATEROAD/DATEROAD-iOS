//
//  CourseView.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/10/24.
//

import UIKit

import SnapKit
import Then

class CourseView: BaseView {
    
    // MARK: - UI Properties
    
    private let courseLabel = UILabel()
    
    private let addCourseButton = UIButton()
    
    private let locationFilterButton = UIButton()
    
    let priceCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Properties
    
    private let enabledButtonType: DRButtonType = EnabledButton()
    
    private let disabledButtonType: DRButtonType = DisabledButton()
    
    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(
            courseLabel,
            addCourseButton,
            locationFilterButton,
            priceCollectionView
        )
    }
    
    override func setLayout() {
        
        courseLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(63)
            $0.leading.equalToSuperview()
        }
        
        addCourseButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(63)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(44)
            $0.height.equalTo(30)
        }
        
        locationFilterButton.snp.makeConstraints {
            $0.top.equalTo(courseLabel.snp.bottom).offset(29)
            $0.leading.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
        
        priceCollectionView.snp.makeConstraints {
            $0.top.equalTo(locationFilterButton.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(30)
        }
    
        
    }
    
    override func setStyle() {
        courseLabel.do {
            $0.text = StringLiterals.Course.course
            $0.textColor = UIColor(resource: .drBlack)
            $0.font = UIFont.suit(.title_bold_20)
        }
        
        addCourseButton.do {
            $0.roundedButton(cornerRadius: 15, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.backgroundColor = UIColor(resource: .deepPurple)
            //수민이꺼 머지하면 이미지 가져다 쓰기
            //$0.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
        }
        
        locationFilterButton.do {
            $0.setTitle("지역", for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_med_13)
            $0.roundedButton(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            $0.contentHorizontalAlignment = .left
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 128, bottom: 0, right: 0)
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.setTitleColor(UIColor(resource: .gray400), for: .normal)
            $0.setImage(UIImage(resource: .icDropdown), for: .normal)
        }
    }
    
}

extension CourseView {
    
    func updatePrice(button: UIButton, buttonType: DRButtonType, isSelected: Bool) {
        button.setButtonStatus(buttonType: buttonType)
        isSelected ? button.setTitleColor(UIColor(resource: .drWhite), for: .normal)
        : button.setTitleColor(UIColor(resource: .gray400), for: .normal
    )
    }
   
}

