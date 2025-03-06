//
//  OnboardingView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/3/24.
//

import UIKit


protocol OnboardingDelegate: AnyObject {

    func didTapNextButton()
    
}

final class OnboardingView: BaseView {
    
    // MARK: - UI Properties
    
    let onboardingCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let bottomControlView: BottomControlView = BottomControlView()
    
    
    // MARK: - Properties
    
    weak var delegate: OnboardingDelegate?
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(onboardingCollectionView, bottomControlView)
    }
    
    override func setLayout() {
        onboardingCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomControlView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(ScreenUtils.height / 812 * 24)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(ScreenUtils.height / 812 * 90)
        }
    }
    
    override func setStyle() {
        onboardingCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            $0.collectionViewLayout = layout
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.contentInsetAdjustmentBehavior = .never
            $0.isPagingEnabled = true
            $0.isScrollEnabled = true
        }
    }
    
}


// MARK: - Methods

extension OnboardingView {
    
    func setAddTarget() {
        bottomControlView.nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
}


// MARK: - @objc Methods

extension OnboardingView {
    
    @objc
    func didTapNextButton() {
        delegate?.didTapNextButton()
    }
    
}
