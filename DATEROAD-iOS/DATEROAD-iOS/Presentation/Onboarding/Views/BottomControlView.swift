//
//  BottomControlView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/9/24.
//

import UIKit

final class BottomControlView: BaseView {
    
    // MARK: - UI Properties
    
    let pageControl: UIPageControl = UIPageControl()
    
    let nextButton: UIButton = UIButton()
    
    
    // MARK: - Properties
    
    let buttonStyle: DRButtonType = NextButton()
    
    
    // MARK: - Methods
    
    override func setHierarchy() {
        self.addSubviews(nextButton, pageControl)
    }
    
    override func setLayout() {
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(pageControl.snp.top).offset(ScreenUtils.height / 812 * -24)
            $0.height.equalTo(ScreenUtils.height / 812 * 54)
            $0.horizontalEdges.equalToSuperview().inset(ScreenUtils.width / 375 * 66)
        }
        
        pageControl.snp.makeConstraints {
            $0.bottom.centerX.equalToSuperview()
            $0.height.equalTo(ScreenUtils.height / 812 * 8)
        }
    }
    
    override func setStyle() {
        nextButton.setButtonStatus(buttonType: buttonStyle)
        
        pageControl.do {
            $0.numberOfPages = 3
            $0.currentPage = 0
            $0.pageIndicatorTintColor = UIColor(resource: .gray200)
            $0.currentPageIndicatorTintColor = UIColor(resource: .deepPurple)
        }
    }
    
}

extension BottomControlView {
    
    func updateBottomButtonText(buttonText: String) {
        self.nextButton.setTitle(buttonText, for: .normal)
    }
    
}
