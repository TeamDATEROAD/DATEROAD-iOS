//
//  BannerImageCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/11/24.
//

import UIKit

final class BannerImageCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
        
    private let bannerImage: UIImageView = UIImageView()
        
    private let tagLabel: DRPaddingLabel = DRPaddingLabel()
    
    private let titleView: UIView = UIView()
    
    private let titleLabel: UILabel = UILabel()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(bannerImage,
                         tagLabel,
                         titleView,
                         titleLabel)
    }
    
    override func setLayout() {
        bannerImage.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview().inset(30)
        }
        
        tagLabel.snp.makeConstraints {
            $0.top.leading.equalTo(bannerImage).inset(13)
            $0.height.equalTo(22)
        }
        
        titleView.snp.makeConstraints {
            $0.centerY.equalTo(bannerImage)
            $0.leading.equalTo(bannerImage).inset(13)
            $0.width.equalTo(176)
            $0.height.equalTo(42)
        }
        
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(titleView)
            $0.top.equalTo(titleView)
        }

    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        bannerImage.do {
            $0.backgroundColor = UIColor.clear
            $0.clipsToBounds = true
            $0.contentMode = .scaleToFill
            $0.roundCorners(cornerRadius: 14, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner])
        }
        
        tagLabel.do {
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.textColor = UIColor(resource: .drWhite)
            $0.font = UIFont.suit(.body_semi_13)
            $0.roundedLabel(cornerRadius: 12, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner])
            $0.setPadding(top: 2, left: 10, bottom: 2, right: 10)
        }
        
        titleView.do {
            $0.backgroundColor = UIColor.clear
        }
        
        titleLabel.do {
            $0.backgroundColor = UIColor.clear
            $0.numberOfLines = 2
            $0.lineBreakMode = .byCharWrapping
            $0.setLabel(alignment: .left, textColor: UIColor(resource: .gray400), font: UIFont.suit(.body_bold_15))
        }
    }
}

extension BannerImageCollectionViewCell {
    
    // TODO: - 인덱스 바인딩 해주기
    func bindData(bannerData: BannerModel?) {
        guard let bannerData else { return }
//        if let url = URL(string: bannerData.imageUrl) {
//            self.bannerImage.kf.setImage(with: url)
//        } else {
//            self.bannerImage.image = UIImage(resource: .thirdOnboardingBG)
//        }
        self.bannerImage.image = UIImage(resource: .testImage2)
        self.tagLabel.text = bannerData.tag
        self.titleLabel.text = bannerData.title
    }

}
