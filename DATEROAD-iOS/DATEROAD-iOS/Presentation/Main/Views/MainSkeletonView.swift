//
//  MainSkeletonView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 10/29/24.
//

import UIKit


final class MainSkeletonView: BaseView {
    
    // MARK: - UI Properties
    
    private let logoImage: UIImageView = UIImageView()
    
    private let pointLabel: UIView = UIView()
    
    private let ticketImage: UIImageView = UIImageView()
    
    private let whiteBackgroundView: UIView = UIView()
    
    private let firstHotCourseLabel: UIView = UIView()
    
    private let secondHotCourseLabel: UIView = UIView()
    
    private let thirdHotCourseLabel: UIView = UIView()
    
    private let firstLocationLabel: UIView = UIView()
    
    private let firstImageView: UIView = UIView()
    
    private let firstPrimaryLabel: UIView = UIView()
    
    private let firstSecondaryLabel: UIView = UIView()
    
    private let firstCostLabel: UIView = UIView()
    
    private let firstTimeLabel: UIView = UIView()
    
    private let secondLocationLabel: UIView = UIView()
    
    private let secondImageView: UIView = UIView()
    
    private let secondPrimaryLabel: UIView = UIView()
    
    private let secondSecondaryLabel: UIView = UIView()
    
    private let secondCostLabel: UIView = UIView()
    
    private let secondTimeLabel: UIView = UIView()
    
    private let bannerImageView: UIView = UIView()
    
    
    override func setHierarchy() {
        self.addSubviews(logoImage,
                         pointLabel,
                         ticketImage,
                         whiteBackgroundView)
        whiteBackgroundView.addSubviews(firstHotCourseLabel,
                                        secondHotCourseLabel,
                                        thirdHotCourseLabel,
                                        firstLocationLabel,
                                        firstImageView,
                                        firstPrimaryLabel,
                                        firstSecondaryLabel,
                                        firstCostLabel,
                                        firstTimeLabel,
                                        secondLocationLabel,
                                        secondImageView,
                                        secondPrimaryLabel,
                                        secondSecondaryLabel,
                                        secondCostLabel,
                                        secondTimeLabel,
                                        bannerImageView)
    }
    
    override func setLayout() {
        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIApplication.shared.statusBarFrame.size.height)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(44)
        }
        
        pointLabel.snp.makeConstraints {
            $0.centerY.equalTo(logoImage)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(99)
            $0.height.equalTo(33)
        }
        
        ticketImage.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(104)
        }
        
        whiteBackgroundView.snp.makeConstraints {
            $0.top.equalTo(ticketImage.snp.bottom).offset(16)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        firstHotCourseLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.height.equalTo(27)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(155)
        }
        
        secondHotCourseLabel.snp.makeConstraints {
            $0.top.equalTo(firstHotCourseLabel.snp.bottom).offset(7)
            $0.height.equalTo(24)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(214)
        }
        
        thirdHotCourseLabel.snp.makeConstraints {
            $0.top.equalTo(secondHotCourseLabel.snp.bottom).offset(11)
            $0.height.equalTo(18)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(197)
        }
        
        firstLocationLabel.snp.makeConstraints {
            $0.top.equalTo(thirdHotCourseLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(26)
            $0.width.equalTo(77)
        }
        
        firstImageView.snp.makeConstraints {
            $0.top.equalTo(firstLocationLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(238)
        }
        
        firstPrimaryLabel.snp.makeConstraints {
            $0.top.equalTo(firstImageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(226)
            $0.height.equalTo(20)
        }
        
        firstSecondaryLabel.snp.makeConstraints {
            $0.top.equalTo(firstPrimaryLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(174)
            $0.height.equalTo(20)
        }
        
        firstCostLabel.snp.makeConstraints {
            $0.top.equalTo(firstSecondaryLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(98)
            $0.height.equalTo(26)
        }
        
        firstTimeLabel.snp.makeConstraints {
            $0.top.equalTo(firstSecondaryLabel.snp.bottom).offset(10)
            $0.leading.equalTo(firstCostLabel.snp.trailing).offset(6)
            $0.width.equalTo(73)
            $0.height.equalTo(26)
        }
        
        secondLocationLabel.snp.makeConstraints {
            $0.top.equalTo(thirdHotCourseLabel.snp.bottom).offset(12)
            $0.leading.equalTo(firstImageView.snp.trailing).offset(20)
            $0.height.equalTo(26)
            $0.width.equalTo(77)
        }
        
        secondImageView.snp.makeConstraints {
            $0.top.equalTo(secondLocationLabel.snp.bottom)
            $0.leading.equalTo(firstImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(238)
        }
        
        secondPrimaryLabel.snp.makeConstraints {
            $0.top.equalTo(secondImageView.snp.bottom).offset(8)
            $0.leading.equalTo(firstImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        secondSecondaryLabel.snp.makeConstraints {
            $0.top.equalTo(secondPrimaryLabel.snp.bottom).offset(6)
            $0.leading.equalTo(firstImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        secondCostLabel.snp.makeConstraints {
            $0.top.equalTo(secondSecondaryLabel.snp.bottom).offset(10)
            $0.leading.equalTo(firstImageView.snp.trailing).offset(20)
            $0.width.equalTo(98)
            $0.height.equalTo(26)
        }
        
        bannerImageView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(secondCostLabel.snp.bottom).offset(30)
            $0.height.equalTo(132)
        }
        
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .deepPurple)
        
        logoImage.do {
            $0.image = UIImage(resource: .symbolLogo)
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
        }
        
        setSkeletonLabel(view: pointLabel, bgColor: UIColor(resource: .mediumPurple), radius: 18)
        
        ticketImage.do {
            $0.image = UIImage(resource: .ticket)
            $0.contentMode = .scaleAspectFill
        }
        
        setSkeletonLabel(view: whiteBackgroundView, bgColor: UIColor(resource: .drWhite), radius: 20, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])

        setSkeletonLabel(view: firstHotCourseLabel)
        
        setSkeletonLabel(view: secondHotCourseLabel, radius: 6)
        
        setSkeletonLabel(view: thirdHotCourseLabel, radius: 6)
        
        setSkeletonLabel(view: firstLocationLabel,
                    bgColor: UIColor(resource: .gray200),
                    radius: 14,
                    corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])

        setSkeletonImage(view: firstImageView, radius: 13, corners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
        setSkeletonLabel(view: firstPrimaryLabel)
        
        setSkeletonLabel(view: firstSecondaryLabel)
        
        setSkeletonLabel(view: firstCostLabel, radius: 14)
        
        setSkeletonLabel(view: firstTimeLabel, radius: 14)
        
        setSkeletonLabel(view: secondLocationLabel,
                    bgColor: UIColor(resource: .gray200),
                    radius: 14,
                    corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])

        setSkeletonImage(view: secondImageView, radius: 13, corners: [.layerMinXMaxYCorner])
        
        setSkeletonLabel(view: secondPrimaryLabel, corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        
        setSkeletonLabel(view: secondSecondaryLabel, corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        
        setSkeletonLabel(view: secondCostLabel, radius: 14, corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        
        setSkeletonImage(view: bannerImageView)
    }
    
}

private extension MainSkeletonView {
    
    func setSkeletonLabel(view: UIView, bgColor: UIColor = UIColor(resource: .gray100), radius: CGFloat = 8,  corners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]) {
        view.do {
            $0.backgroundColor = bgColor
            $0.roundCorners(cornerRadius: radius, maskedCorners: corners)
        }
    }
    
    func setSkeletonImage(view: UIView, bgColor: UIColor = UIColor(resource: .gray100), radius: CGFloat = 14, corners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]) {
        view.do {
            $0.backgroundColor = bgColor
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.roundCorners(cornerRadius: radius, maskedCorners: corners)
        }
    }
    
}
