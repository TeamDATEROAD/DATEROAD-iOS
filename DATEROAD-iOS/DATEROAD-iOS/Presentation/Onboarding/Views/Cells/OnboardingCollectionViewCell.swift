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
        
    let nextButton: UIButton = UIButton()
    
    
    // MARK: - Properties
    
    private let nextButtonType: DRButton = NextButton()
    
    private let enabledButtonType: DRButton = EnabledButton()

    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.contentView.addSubviews(backgroundImage,
            mainInfoLabel,
            subInfoLabel,
            nextButton)
    }
    
    override func setLayout() {
        self.contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainInfoLabel.snp.makeConstraints {
            $0.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(80)
            $0.centerX.equalToSuperview()
        }
        
        subInfoLabel.snp.makeConstraints {
            $0.top.equalTo(mainInfoLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(backgroundImage).inset(38)
            $0.height.equalTo(54)
            $0.horizontalEdges.equalToSuperview().inset(16)
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
        
    }
    
    // 각 온보딩 페이지에 맞는 데이터를 세팅해주는 메소드
    func setOnboardingData(data: OnboardingModel) {
        if let bgIMG = data.bgIMG {
            self.backgroundImage.image = bgIMG
        } else {
            self.backgroundImage.isHidden = true
        }
        
        for index in 0..<data.pointText.count {
            self.mainInfoLabel.setAttributedText(fullText: data.mainInfo,
                                                 pointText: data.pointText[index],
                                                 pointColor: UIColor(resource: .deepPurple),
                                                 lineHeight: 1.04)
        }
        
        self.subInfoLabel.text = data.subInfo
        
        self.nextButton.setTitle(data.buttonText, for: .normal)
        self.nextButton.setButtonStatus(buttonType: data.buttonType)
    }
    
}
