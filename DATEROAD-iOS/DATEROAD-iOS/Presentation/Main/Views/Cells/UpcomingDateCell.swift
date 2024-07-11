//
//  UpcomingDateCell.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/10/24.
//

import UIKit

final class UpcomingDateCell: BaseCollectionViewCell {
    
    // MARK: - UI Properties
    
    private let logoImage: UIImageView = UIImageView()
    
    private let pointLabel: DRPaddingLabel = DRPaddingLabel()
    
    private let profileImage: UIImageView = UIImageView()

    private var dateTicketView: DateTicketView = DateTicketView()

    private var emptyTicketView: EmptyTicketView = EmptyTicketView()

    
    // MARK: - Properties
    
    private var isEmpty: Bool = false
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(logoImage,
                         pointLabel,
                         profileImage,
                         dateTicketView,
                         emptyTicketView)
    }
    
    override func setLayout() {
        logoImage.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.size.equalTo(44)
        }
        
        pointLabel.snp.makeConstraints {
            $0.centerY.equalTo(logoImage)
            $0.trailing.equalToSuperview().inset(17)
            $0.height.equalTo(33)
        }
        
        profileImage.snp.makeConstraints {
            $0.centerY.equalTo(logoImage)
            $0.size.equalTo(33)
            $0.trailing.equalToSuperview()
        }
        
        dateTicketView.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(104)
        }
        
        emptyTicketView.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
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
        }
        
        profileImage.do {
            $0.layer.cornerRadius = $0.frame.size.width / 2
            $0.image = UIImage(resource: .emptyProfileImg)
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFit
        }
    }
}

extension UpcomingDateCell {
    
    // TODO: - 0일 때 D-Day 변환 하는 거 수정 & 다가오는 일정 없는 경우 수정
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
    }
}