//
//  UserInfoView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/8/24.
//

import UIKit

import Kingfisher

final class UserInfoView: BaseView {
    
    // MARK: - UI Properties
    
    let profileImageView: UIImageView = UIImageView()
    
    private let nicknameLabel: UILabel = UILabel()
    
    let editProfileButton: UIImageView = UIImageView()
    
    let tagCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let pointView: UIView = UIView()
    
    private let userPointLabel: UILabel = UILabel()
    
    private let pointLabel: UILabel = UILabel()
    
    let goToPointHistoryStackView: UIStackView = UIStackView()
    
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
                              goToPointHistoryStackView)
        
        goToPointHistoryStackView.addArrangedSubviews(goToPointHistoryLabel,rightArrowButton)
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
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(14)
            $0.trailing.equalTo(goToPointHistoryLabel.snp.leading)
        }
        
        goToPointHistoryStackView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.trailing.equalToSuperview().inset(14)
            $0.height.equalTo(20)
            $0.centerY.equalTo(pointLabel)
        }
    }
    
    override func setStyle() {
        self.isUserInteractionEnabled = true
        
        profileImageView.do {
            $0.image = UIImage(resource: .emptyProfileImg)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 22
            $0.contentMode = .scaleAspectFill
        }
        
        nicknameLabel.setLabel(textColor: UIColor(resource: .drBlack), font: UIFont.systemFont(ofSize: 24, weight: .black))
        
        editProfileButton.do {
            $0.image = UIImage(resource: .icPencil)
            $0.isUserInteractionEnabled = true
        }
        
        tagCollectionView.do {
            $0.contentInsetAdjustmentBehavior = .never
            $0.backgroundColor = UIColor(resource: .gray100)
            
            let layout = CollectionViewLeftAlignFlowLayout()
            layout.cellSpacing = 8
            $0.collectionViewLayout = layout
        }
        
        pointView.do {
            $0.backgroundColor = UIColor(resource: .drWhite)
            $0.layer.cornerRadius = 14
            $0.clipsToBounds = true
        }
        
        userPointLabel.do {
            $0.setLabel(text: "님의 포인트",
                        alignment: .left,
                        textColor: UIColor(resource: .gray400),
                        font: UIFont.systemFont(ofSize: 13, weight: .medium))
            $0.numberOfLines = 1
            $0.textAlignment = .left
        }
        
        goToPointHistoryStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.isUserInteractionEnabled = true
        }
        
        pointLabel.setLabel(text: "0 P",
                            alignment: .left,
                            textColor: UIColor(resource: .drBlack),
                            font: UIFont.suit(.title_extra_24))
        
        goToPointHistoryLabel.setLabel(text: StringLiterals.MyPage.goToPointHistory,
                                       alignment: .left,
                                       textColor: UIColor(resource: .gray400),
                                       font: UIFont.suit(.body_med_13))
        
        rightArrowButton.image = UIImage(resource: .arrowRightMini)
    }
    
}

extension UserInfoView {
    
    func bindData(userInfo: MyPageUserInfoModel) {
        if let imageURL = userInfo.imageURL  {
            let url = URL(string: imageURL)
            self.profileImageView.kf.setImage(with: url,
                                              placeholder: UIImage(resource: .placeholder),
                                              options: [.transition(.none), .cacheOriginalImage])
        } else {
            self.profileImageView.image = UIImage(resource: .emptyProfileImg)
        }
        
        self.nicknameLabel.text = userInfo.nickname
        self.userPointLabel.text = userInfo.nickname + "님의 포인트"
        self.pointLabel.text = String(userInfo.point) + " P"
    }
    
}
