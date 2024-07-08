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
    
    
    // MARK: - Life Cycle
    
    override func setHierarchy() {
        self.addSubview(userInfoView)
    }
    
    override func setLayout() {
        userInfoView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(230)
        }
    }
    
    override func setStyle() {
        userInfoView.do {
            $0.backgroundColor = UIColor(resource: .gray100)
            $0.roundCorners(cornerRadius: 14, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
    }
    
    
    
}
