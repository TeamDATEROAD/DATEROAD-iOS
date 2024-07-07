//
//  UpcomingDateScheduleViewController.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 7/8/24.
//

import UIKit

import SnapKit
import Then

class UpcomingDateScheduleViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let titleLabel = UILabel()
    
    private var dateRegisterButton = UIButton()
    
    private var pastDateButton = UIButton()
    
    
    // MARK: - Properties
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setHierarchy() {
        
        self.view.addSubviews(titleLabel, dateRegisterButton, pastDateButton)
    }
    
    override func setLayout() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(13)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(28)
        }
        
        dateRegisterButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
            $0.width.equalTo(44)
        }
        
        pastDateButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(127)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(44)
            $0.width.equalTo(177)
        }
    }
    
    override func setStyle() {
        self.view.backgroundColor = UIColor(resource: .drWhite)
        
        titleLabel.do {
            $0.font = UIFont.suit(.title_bold_20)
            $0.textColor = UIColor(resource: .drBlack)
            $0.text = "데이트 일정"
        }
        
        dateRegisterButton.do {
            $0.backgroundColor = UIColor(resource: .deepPurple)
            $0.setImage(UIImage(resource: .plusSchedule), for: .normal)
            $0.addTarget(self, action: #selector(pushToDateRegisterVC), for: .touchUpInside)
            $0.roundedButton(cornerRadius: 14, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        }
        
        pastDateButton.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.roundedButton(cornerRadius: 13, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
            $0.setTitle("지난 데이트 보기", for: .normal)
            $0.titleLabel?.font = UIFont.suit(.body_bold_15)
            $0.titleLabel?.textColor = UIColor(resource: .drBlack)
            $0.addTarget(self, action: #selector(pushToPastDateVC), for: .touchUpInside)
        }
        

    }

}

// MARK: - Private Method

private extension UpcomingDateScheduleViewController {
    @objc
    func pushToDateRegisterVC() {
       print("일정 등록으로 이동")
    }
    
    @objc
    func pushToPastDateVC() {
       print("지난 데이트로 이동")
    }
    
}

