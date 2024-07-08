//
//  UserInfoView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/8/24.
//

import UIKit

final class UserInfoView: BaseView {
    
    // MARK: - UI Properties
    
    private let profileImageView: UIImageView = UIImageView()
    
    private let nicknameLabel: UILabel = UILabel()
    
    private let editProfileButton: UIImageView = UIImageView()
    
    let tagCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let pointView: UIView = UIView()
    
    private let userPointLabel: UILabel = UILabel()
    
    private let pointLabel: UILabel = UILabel()
    
    private let goToPointHistoryLabel: UILabel = UILabel()
    
    private let rightArrowButton: UIImageView = UIImageView()
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(profileImageView,
                         nicknameLabel,
                         editProfileButton,
                         tagCollectionView,
                         pointView)
        
        pointView.addSubviews(userPointLabel,
                              pointLabel,
                              rightArrowButton,
                              goToPointHistoryLabel)
    }
    
    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.size.equalTo(44)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
        
        editProfileButton.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.leading.equalTo(nicknameLabel.snp.trailing).offset(5)
            $0.centerY.equalTo(profileImageView)
        }
        
        tagCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
            $0.height.equalTo(30)
        }
        
        pointView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(90)
        }
        
        userPointLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(14)
        }
        
        pointLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(14)
            $0.trailing.equalTo(goToPointHistoryLabel.snp.leading)
        }
        
        rightArrowButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.width.equalTo(4)
            $0.height.equalTo(7)
            $0.centerY.equalTo(goToPointHistoryLabel)
        }
        
        goToPointHistoryLabel.snp.makeConstraints {
            $0.bottom.equalTo(pointLabel)
            $0.trailing.equalTo(rightArrowButton.snp.leading).offset(-10)
            $0.width.equalTo(86)
        }
        
    }
    
    override func setStyle() {
        profileImageView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 22
            $0.contentMode = .scaleAspectFill
        }
        
        nicknameLabel.do {
            $0.setLabel(textColor: UIColor(resource: .drBlack), font: UIFont.suit(.title_extra_24))
        }
        
        editProfileButton.do {
            $0.image = UIImage(resource: .icPencil)
        }
        
        tagCollectionView.do {
            $0.contentInsetAdjustmentBehavior = .never
            $0.backgroundColor = UIColor(resource: .gray100)
        }
        
        pointView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.layer.cornerRadius = 14
            $0.clipsToBounds = true
        }
        
        userPointLabel.do {
            $0.setLabel(alignment: .left,
                        textColor: UIColor(resource: .gray400),
                        font: UIFont.suit(.body_med_13))
            $0.numberOfLines = 1
            $0.textAlignment = .left
        }
        
        pointLabel.do {
            $0.setLabel(text: StringLiterals.MyPage.goToPointHistory,
                        alignment: .left,
                        textColor: UIColor(resource: .drBlack),
                        font: UIFont.suit(.title_extra_24))
        }
        
        goToPointHistoryLabel.do {
            $0.setLabel(text: StringLiterals.MyPage.goToPointHistory,
                        alignment: .left,
                        textColor: UIColor(resource: .gray400),
                        font: UIFont.suit(.body_med_13))
        }
        
        rightArrowButton.do {
            $0.image = UIImage(resource: .arrowRightMini)
        }
    }
    
    
}

extension UserInfoView {
    
    // TODO: - 서버 통신 후 변경 예정
    func bindData(userInfo: UserInfoModel) {
        self.profileImageView.image = UIImage(resource: .emptyProfileImg)
        self.nicknameLabel.text = userInfo.nickname
        self.userPointLabel.text = userInfo.nickname + " 님의 포인트"
        self.pointLabel.text = String(userInfo.point) + " P"
        
    }
}
