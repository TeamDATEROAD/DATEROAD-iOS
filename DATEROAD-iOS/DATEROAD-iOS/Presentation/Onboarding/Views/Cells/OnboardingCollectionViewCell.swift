//
//  OnboardingCollectionViewCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/3/24.
//

import UIKit

final class OnboardingCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let backgroundImage: UIImageView = UIImageView()
    
    private let mainInfoLabel: UILabel = UILabel()
    
    private let subInfoLabel: UILabel = UILabel()
    
    private let hintInfoLabel: UILabel = UILabel()
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.contentView.addSubviews(backgroundImage,
                                     mainInfoLabel,
                                     subInfoLabel,
                                     hintInfoLabel)
    }
    
    override func setLayout() {
        self.contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainInfoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(ScreenUtils.height / 812  * 532)
            $0.centerX.equalToSuperview()
        }
        
        subInfoLabel.snp.makeConstraints {
            $0.top.equalTo(mainInfoLabel.snp.bottom).offset(ScreenUtils.height / 812  * 10)
            $0.centerX.equalToSuperview()
        }
        
        hintInfoLabel.snp.makeConstraints {
            $0.top.equalTo(subInfoLabel.snp.bottom).offset(ScreenUtils.height / 812 * 6)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        backgroundImage.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        
        mainInfoLabel.do {
            $0.setLabel(textColor: UIColor(resource: .drBlack), font: UIFont.suit(.title_extra_24))
        }
        
        subInfoLabel.do {
            $0.setLabel(textColor: UIColor(resource: .gray500), font: UIFont.suit(.body_med_15))
        }
        
        hintInfoLabel.do {
            $0.setLabel(textColor: UIColor(resource: .gray400), font: UIFont.suit(.cap_reg_11))
        }
    }
    
    // 각 온보딩 페이지에 맞는 데이터를 세팅해주는 메소드
    func setOnboardingData(data: OnboardingModel) {
        self.backgroundImage.image = data.bgIMG
        
        for index in 0..<data.pointText.count {
            self.mainInfoLabel.setAttributedText(fullText: data.mainInfo,
                                                 pointText: data.pointText[index],
                                                 pointColor: UIColor(resource: .deepPurple),
                                                 lineHeight: 1.04)
        }
        
        self.subInfoLabel.text = data.subInfo
        
        if let hintText = data.hintInfo {
            self.hintInfoLabel.text = hintText
        } else {
            self.hintInfoLabel.isHidden = true
        }
    }
    
}
