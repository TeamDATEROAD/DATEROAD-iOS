//
//  MyPageView.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/8/24.
//

import UIKit

final class MyPageView: BaseView {
    
    // MARK: - UI Properties
    
    let userInfoView: UserInfoView = UserInfoView()
    
    let myPageTableView: UITableView = UITableView(frame: .zero, style: .plain)
    
    let withdrawalButton: DRTextButton = DRTextButton(title: StringLiterals.MyPage.withdrawal, buttonName: .med_white_0)
    
    
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
            userInfoView,
            myPageTableView,
            withdrawalButton
        )
    }
    
    override func setLayout() {
        userInfoView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(230)
        }
        
        myPageTableView.snp.makeConstraints {
            $0.top.equalTo(userInfoView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        // TODO: - bottom 탭바 기준으로 수정 예정
        withdrawalButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(110)
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor(resource: .drWhite)
        
        userInfoView.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.roundCorners(cornerRadius: 14, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
        
        myPageTableView.do {
            $0.separatorStyle = .none
            $0.rowHeight = 60
            $0.isScrollEnabled = false
        }
    }
    
}

extension MyPageView {
    
    func registerCell() {
        myPageTableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.cellIdentifier)
    }
    
}
