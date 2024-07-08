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
    
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubviews(userInfoView, myPageTableView)
    }
    
    override func setLayout() {
        userInfoView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(230)
        }
        
        myPageTableView.snp.makeConstraints {
            $0.top.equalTo(userInfoView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(240)
        }
    }
    
    override func setStyle() {
        userInfoView.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.roundCorners(cornerRadius: 14, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
        
        myPageTableView.do {
            $0.separatorStyle = .none
            $0.rowHeight = 60
        }
    }
 
}
