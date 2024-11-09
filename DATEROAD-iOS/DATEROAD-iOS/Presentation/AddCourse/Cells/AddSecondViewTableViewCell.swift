//
//  AddSecondViewTableViewCell.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/10/24.
//

import UIKit

import SnapKit
import Then

final class AddSecondViewCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let placeTitleLabel: UILabel = UILabel()
    
    private let timeRequireContainer: UIView = UIView()
    
    private let timeRequireLabel: UILabel = UILabel()
    
    let moveAbleButton: UIButton = UIButton()
    
    
    // MARK: - Properties
    
    private var isEditMode: Bool = false
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubview(contentView)
        
        contentView.addSubviews(placeTitleLabel,
                                timeRequireContainer,
                                moveAbleButton)
        
        timeRequireContainer.addSubview(timeRequireLabel)
    }
    
    override func setLayout() {
        placeTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(17)
            $0.trailing.equalTo(timeRequireContainer.snp.leading).offset(-20)
            $0.width.equalTo(198)
            $0.height.equalToSuperview()
        }
        
        timeRequireContainer.snp.makeConstraints {
            $0.leading.equalTo(placeTitleLabel.snp.trailing).offset(20)
            $0.verticalEdges.equalToSuperview().inset(13)
            $0.width.equalTo(59)
        }
        
        timeRequireLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        moveAbleButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(3)
            $0.size.equalTo(44)
            $0.centerY.equalToSuperview()
        }
    }
    
    override func setStyle() {
        contentView.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.layer.cornerRadius = 14
        }
        
        placeTitleLabel.do {
            $0.setLabel(alignment: .left,
                        numberOfLines: 2,
                        textColor: UIColor(resource: .drBlack),
                        font: UIFont.systemFont(ofSize: 15, weight: .bold))
            $0.text = "test"
        }
        
        timeRequireContainer.do {
            $0.backgroundColor = UIColor(resource: .gray200)
            $0.layer.cornerRadius = 10
        }
        
        timeRequireLabel.do {
            $0.text = "test"
            $0.setLabel(textColor: UIColor(resource: .drBlack), font: .suit(.body_med_13))
        }
        
        moveAbleButton.do {
            $0.setImage(UIImage(resource: .icMovecourse), for: .normal)
        }
    }
    
}


// MARK: - Extension Methods

extension AddSecondViewCollectionViewCell {
    
    func configure(model: AddCoursePlaceModel) {
        self.placeTitleLabel.text = model.placeTitle
        self.timeRequireLabel.text = model.timeRequire
    }
    
    /// editMode 활성화라면
    func updateEditMode(flag: Bool) {
        let image = flag ? UIImage(resource: .icDeletecourse) : UIImage(resource: .icMovecourse)
        
        moveAbleButton.setImage(image, for: .normal)
    }
    
    func pastDatePlaceConfigure(model: DatePlaceModel) {
        self.placeTitleLabel.text = model.name
        self.timeRequireLabel.text = model.duration
    }
    
}
