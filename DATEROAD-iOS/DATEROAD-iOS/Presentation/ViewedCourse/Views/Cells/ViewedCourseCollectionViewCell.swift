//
//  ViewedCourseCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/7/24.
//

import UIKit

import SnapKit
import Then

class ViewedCourseCollectionViewCell: BaseCollectionViewCell {

    // MARK: - UI Properties
    
    private var thumbnailImageView = UIImageView()
    
    private var infoView = UIView()
    
    private var locationLabel = UILabel()
    
    private var titleLabel = UILabel()
    
    private var expenseButton = UIButton()
    
    private var timeButton = UIButton()
    
    // MARK: - Properties
    
    var viewedCourseItemRow: Int?
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(thumbnailImageView, infoView)
        infoView.addSubviews(locationLabel, 
                             titleLabel,
                             expenseButton, 
                             timeButton)
    }
    
    override func setLayout() {
        thumbnailImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(120)
        }
        
        infoView.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview().inset(10)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(9)
            $0.height.equalTo(18)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(locationLabel.snp.bottom).offset(5)
            $0.height.equalTo(42)
        }
        
        expenseButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.height.equalTo(26)
           //$0.width.equalTo(150)
        }
        
        timeButton.snp.makeConstraints {
            $0.leading.equalTo(expenseButton.snp.trailing).offset(6)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.height.equalTo(26)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        thumbnailImageView.do {
            $0.roundCorners(cornerRadius: 14, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.borderColor = UIColor(resource: .alertRed).cgColor
            $0.layer.borderWidth = 3
        }
        
        locationLabel.do {
            $0.font = UIFont.suit(.body_med_13)
            $0.textColor = UIColor(resource: .gray400)
            $0.textAlignment = .left
        }
        
        titleLabel.do {
            $0.font = UIFont.suit(.body_bold_15)
            $0.textColor = UIColor(resource: .drBlack)
            $0.textAlignment = .left
            $0.numberOfLines = 2
        }
        
        expenseButton.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.roundedButton(cornerRadius: 20, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
            $0.setTitleColor(UIColor(resource: .gray400), for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_med_13)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            $0.imageEdgeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 5)
            $0.setImage(UIImage(systemName: "s.circle"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFill
        }
        
        timeButton.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.roundedButton(cornerRadius: 20, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
            $0.setTitleColor(UIColor(resource: .gray400), for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_med_13)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            $0.setImage(UIImage(systemName: "clock"), for: .normal)
        }
        
    }

}

extension ViewedCourseCollectionViewCell {
    func dataBind(_ viewedCourseData: ViewedCourseModel, _ viewedCourseItemRow: Int?) {
        self.thumbnailImageView.image = UIImage(resource: .secondOnboardingBG)
        self.locationLabel.text = viewedCourseData.courseLocation
        self.titleLabel.text = viewedCourseData.courseTitle
        self.expenseButton.setTitle(viewedCourseData.courseExpense, for: .normal)
        self.timeButton.setTitle(viewedCourseData.courseTime, for: .normal)
        self.viewedCourseItemRow = viewedCourseItemRow
    }
}
