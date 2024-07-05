//
//  ProfileViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/5/24.
//

import Foundation

final class ProfileViewModel {
    
    var tagData: [String] = []
 
    init() {
        fetchTagData()
    }
    
}

extension ProfileViewModel {
    
    func fetchTagData() {
        tagData = TendencyTag.allCases.map { $0.tagTitle }
    }
}
