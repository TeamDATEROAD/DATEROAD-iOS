//
//  ProfileViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/5/24.
//

import Foundation

final class ProfileViewModel {
    
    // TODO: - 중복 확인 로직 추가 예정

    var tagData: [String] = []
    
    var nickname: ObservablePattern<String> = ObservablePattern("")
    
    var tagCount: ObservablePattern<Int> = ObservablePattern(0)
        
    var onValidNickname: ((Bool) -> Void)?
    
    var onValidSelect: ((Bool) -> Void)?
    
    var onSuccessRegister: ((Bool) -> Void)?
 
    init() {
        fetchTagData()
    }
    
}

extension ProfileViewModel {
    
    func fetchTagData() {
        tagData = TendencyTag.allCases.map { $0.tagTitle }
    }
    
    
    func checkValidNickname() {
        let nickname = self.nickname.value ?? ""
        if nickname.isEmpty {
            self.onValidNickname?(false)
        } else {
            // TODO: - 닉네임이 비어있지 않은 경우 중복 확인 처리 로직 추가 예정
            self.onValidNickname?(true)
        }
    }
    
    func countSelectedTag(isSelected: Bool) {
        let oldCount = tagCount.value ?? 0
        
        if isSelected {
            tagCount.value = oldCount + 1
        } else {
            tagCount.value = oldCount - 1
        }
        
        checkTagCount()
    }
    
    func checkTagCount() {
        guard let count = tagCount.value else { return }

        if count >= 1 && count <= 3 {
            self.onValidSelect?(true)
        } else {
            self.onValidSelect?(false)
        }
    }
    
    func checkValidRegistration() {
        
    }
}
