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
    
    let leftBackgroundView = UIView()
    
    let timelineView = DRTimelineView()
    
    let moveAbleButton: DRImageButton = DRImageButton(image: UIImage(resource: .icMovecourse), buttonName: .gray100_gray300_14)
    
    
    // MARK: - Properties
    
    private var isEditMode: Bool = false
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubview(contentView)
        
        contentView.addSubviews(leftBackgroundView, moveAbleButton)
        
        leftBackgroundView.addSubview(timelineView)
    }
    
    override func setLayout() {
        leftBackgroundView.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
            $0.trailing.equalToSuperview().inset(52)
        }
                              
        timelineView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(17)
        }
        
        moveAbleButton.snp.makeConstraints {
            $0.trailing.verticalEdges.equalToSuperview()
            $0.width.equalTo(44)
        }
    }
    
    override func setStyle() {
        self.do {
            $0.backgroundColor = .clear
            $0.clipsToBounds = true
        }
        
        leftBackgroundView.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.layer.cornerRadius = 14
            $0.clipsToBounds = true
        }
        
        moveAbleButton.do {
            $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
        }
    }
    
}


// MARK: - Extension Methods

extension AddSecondViewCollectionViewCell {
    
    func configure(model: AddCoursePlaceModel) {
        timelineView.do {
            $0.locationLabel.text = model.placeTitle
            $0.addressLabel.text = model.address.abbreviatedString(20)
            $0.timeLabel.text = model.timeRequire
        }
    }
    
    /// editMode 활성화라면
    func updateEditMode(flag: Bool) {
        let image = flag ? UIImage(resource: .icDeletecourse) : UIImage(resource: .icMovecourse)
        
        moveAbleButton.setImage(image, for: .normal)
        moveAbleButton.configuration?.background.backgroundColor = flag ? .clear : .gray100
//        moveAbleButton.setNeedsUpdateConfiguration()
    }
    
    func pastDatePlaceConfigure(model: TimelineModel) {
        timelineView.do {
            $0.locationLabel.text = model.title
            // TODO: - 모델 수정 후 수정
            $0.addressLabel.text = "서울특별시 데로로로 데로로로"
            $0.timeLabel.text = model.duration
        }
    }
    
}
