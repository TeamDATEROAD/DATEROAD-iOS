//
//  ProfileViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/5/24.
//

import UIKit

final class ProfileViewModel {
    
    // TODO: - 중복 확인 로직 추가 예정

    var tagData: [ProfileModel] = []
    
    var selectedTagData: [String] = []
    
    var nickname: ObservablePattern<String> = ObservablePattern("")
    
    var tagCount: ObservablePattern<Int> = ObservablePattern(0)
    
    var isValidNicknameCount: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isValidNickname: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isOverCount: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isValidTag: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isValidRegistration: ObservablePattern<Bool> = ObservablePattern(false)
        
    var onSuccessRegister: ((Bool) -> Void)?
 
    init() {
        fetchTagData()
    }
    
}

extension ProfileViewModel {
    
    func fetchTagData() {
        tagData = TendencyTag.allCases.map { $0.tag }
    }
    
    func checkValidNickname() {
        guard let nickname = self.nickname.value else { return }
        if nickname.count >= 2 && nickname.count <= 5 {
            // TODO: - 닉네임이 글자 수 충족 -> 중복 확인 처리 로직 추가 예정

            self.isValidNicknameCount.value = true
            self.isValidNickname.value = true
        } else {
            if nickname.count < 2 {
                self.isValidNicknameCount.value = false
            }
            self.isValidNickname.value = false
        }
    }
    
    func countSelectedTag(isSelected: Bool) {
        guard let oldCount = tagCount.value else { return }
        
        if isSelected {
            tagCount.value = oldCount + 1
        } else {
            if oldCount != 0 {
                tagCount.value = oldCount - 1
            }
        }
        
        checkTagCount()
    }
    
    func checkTagCount() {
        guard let count = tagCount.value else { return }

        if count >= 1 && count <= 3 {
            self.isValidTag.value = true
            self.isOverCount.value = false
        } else {
            self.isValidTag.value = false
            if count > 3 {
                self.isOverCount.value = true
            }
        }
        print(count)
    }
    
    func checkValidRegistration() {
        guard let isValidNickname = isValidNickname.value,
            let isValidTag = isValidTag.value else { return }
        
        self.isValidRegistration.value = isValidNickname && isValidTag ? true : false
    }
    
    func postSignUp(image: UIImage?) {
        let socialType = UserDefaults.standard.bool(forKey: "SocialType")
        
        guard let name = self.nickname.value else { return }

        var requestBody = PostSignUpRequest(userSignUpReq: UserSignUpReq(name: name,
                                                                         platform: socialType ? SocialType.kakao.rawValue : SocialType.apple.rawValue),
                                            image: image,
                                            tag: self.selectedTagData)
        
        NetworkService.shared.authService.postSignUp(requestBody: requestBody) { response in
            switch response {
            case .success(let data):
                UserDefaults.standard.setValue(data.userID, forKey: "userID")
                UserDefaults.standard.setValue(data.accessToken, forKey: "accessToken")
                UserDefaults.standard.setValue(data.refreshToken, forKey: "refreshToken")
                print("post \(data)")
                self.onSuccessRegister?(true)
            default:
                print("Failed to fetch post signup")
                self.onSuccessRegister?(false)
                return
            }
            
        }
    }
}
