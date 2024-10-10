//
//  UpcomingDateCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import UIKit

import Kingfisher

final class UpcomingDateCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let logoImage: UIImageView = UIImageView()
    
    let pointLabel: DRPaddingLabel = DRPaddingLabel()
    
    private let profileImage: UIImageView = UIImageView()

    var dateTicketView: DateTicketView = DateTicketView()

    var emptyTicketView: EmptyTicketView = EmptyTicketView()

    
    // MARK: - Properties
    
    private var isEmpty: Bool = false
    
    weak var delegate: CellImageLoadDelegate?

    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        self.profileImage.image = nil
        self.pointLabel.text = nil
        self.profileImage.backgroundColor = .clear // 배경색 초기화
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2  // cornerRadius 다시 적용
        self.profileImage.clipsToBounds = true
    }
    
    override func setHierarchy() {
        self.addSubviews(logoImage,
                         pointLabel,
                         profileImage,
                         dateTicketView,
                         emptyTicketView)
    }
    
    override func setLayout() {
        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIApplication.shared.statusBarFrame.size.height)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(44)
        }
        
        pointLabel.snp.makeConstraints {
            $0.centerY.equalTo(logoImage)
            $0.trailing.equalToSuperview().inset(31)
            $0.height.equalTo(33)
        }
        
        profileImage.snp.makeConstraints {
            $0.centerY.equalTo(logoImage)
            $0.size.equalTo(33)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        dateTicketView.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(104)
        }
        
        emptyTicketView.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(104)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .deepPurple)
        
        logoImage.do {
            $0.image = UIImage(resource: .symbolLogo)
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
        }
        
        pointLabel.do {
            $0.backgroundColor = UIColor(resource: .mediumPurple)
            $0.roundedLabel(cornerRadius: 18, maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
            $0.setLabel(textColor: UIColor(resource: .drWhite), font: UIFont.suit(.body_bold_13))
            $0.setPadding(top: 0, left: 14, bottom: 0, right: 23)
            $0.isUserInteractionEnabled = true
        }
        
        profileImage.do {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = $0.frame.size.width / 2
            $0.image = UIImage(resource: .emptyProfileImg)
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
        }
    }
    
}

extension UpcomingDateCell {
    
    func bindData(upcomingData: UpcomingDateModel?, mainUserData: MainUserModel?) {
        if let upcomingData {
            emptyTicketView.isHidden = true
            dateTicketView.isHidden = false
            dateTicketView.bindData(data: upcomingData)
        } else {
            emptyTicketView.isHidden = false
            dateTicketView.isHidden = true
        }
        
        guard let point = mainUserData?.point else { return }
        pointLabel.text = "\(point) P"
        
        guard let imageUrl = mainUserData?.imageUrl else {
            self.profileImage.image = UIImage(resource: .emptyProfileImg)
            self.delegate?.cellImageLoaded()
            return
        }
        let url = URL(string: imageUrl)
        self.profileImage.kf.setImage(with: url) { result  in
            self.delegate?.cellImageLoaded()
        }
        profileImage.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = $0.frame.size.width / 2
            $0.backgroundColor = .clear
        }
    }
    
}
