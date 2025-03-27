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
    
    private let nicknameLabel: DRTextLabel = DRTextLabel(textLabelType: .clear(.systemBold24_black))
    
    let editProfileButton: DRImageButton = DRImageButton(image: UIImage(resource: .icPencil), buttonName: .clear_black_0)
    
    let tagCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let pointView: UIView = UIView()
    
    private let userPointLabel: DRTextLabel = DRTextLabel(
        title: "님의 포인트",
        textLabelType: .clear(.systemMed13_gray400),
        alignment: .left,
        numberOfLines: 1
    )
    
    private let pointLabel: DRTextLabel = DRTextLabel(
        title: "0 P",
        textLabelType: .clear(.extra24_black),
        alignment: .left
    )
    
    let goToPointHistoryStackView: UIStackView = UIStackView()
    
    private let goToPointHistoryLabel: DRTextLabel = DRTextLabel(
        title: StringLiterals.MyPage.goToPointHistory,
        textLabelType: .clear(.med13_gray400),
        alignment: .left
    )
    
    private let rightArrowButton: DRImageButton = DRImageButton(image: UIImage(resource: .arrowRightMini), buttonName: .clear_gray400_0)
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubviews(
            profileImageView,
            nicknameLabel,
            editProfileButton,
            tagCollectionView,
            pointView
        )
        
        pointView.addSubviews(
            userPointLabel,
            pointLabel,
            goToPointHistoryStackView
        )
        
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
        
        goToPointHistoryStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.isUserInteractionEnabled = true
        }
    }
    
}

extension UserInfoView {
    
    func bindData(userInfo: MyPageUserInfoModel) {
        if let imageURL = userInfo.imageURL  {
            let url = URL(string: imageURL)
            self.profileImageView.kf.setImage(
                with: url,
                placeholder: UIImage(resource: .placeholder),
                options: [.transition(.none), .cacheOriginalImage]
            )
        } else {
            self.profileImageView.image = UIImage(resource: .emptyProfileImg)
        }
        
        self.nicknameLabel.text = userInfo.nickname
        self.userPointLabel.text = userInfo.nickname + "님의 포인트"
        self.pointLabel.text = String(userInfo.point) + " P"
    }
    
    func registerCell() {
        tagCollectionView.register(TendencyTagCollectionViewCell.self, forCellWithReuseIdentifier: TendencyTagCollectionViewCell.cellIdentifier)
    }
    
}
