//
//  ProfileViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/5/24.
//

import UIKit

final class ProfileViewModel {
    
    var tagData: [ProfileTagModel] = []
    
    var selectedTagData: [String] = []
    
    var profileData: ObservablePattern<ProfileModel> = ObservablePattern(ProfileModel(profileImage: nil, nickname: "", tags: [])) 
    
    var profileImage: ObservablePattern<UIImage> = ObservablePattern(nil)
    
    var existingNickname: ObservablePattern<String> = ObservablePattern("")
    
    var isExistedNickname: ObservablePattern<Bool> = ObservablePattern(true)
    
    var nickname: ObservablePattern<String> = ObservablePattern("")
    
    var tagCount: ObservablePattern<Int> = ObservablePattern(0)
    
    var isValidNicknameCount: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isValidNickname: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isOverCount: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isValidTag: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isValidRegistration: ObservablePattern<Bool> = ObservablePattern(false)
   
   var is5orLess: ObservablePattern<Bool> = ObservablePattern(false)
            
    var onSuccessRegister: ((Bool) -> Void)?
    
    var onSuccessEdit: ((Bool) -> Void)?
 
    init() {
        fetchTagData()
    }
    
}

extension ProfileViewModel {
    
    func fetchTagData() {
        tagData = TendencyTag.allCases.map { $0.tag }
    }
    
    // 닉네임 글자 수 확인 => 유효카운트 여부 & 5자초과 여부 업데이트
    func checkValidNickname() {
        guard let nickname = self.nickname.value else { return }
        if nickname.count >= 2 && nickname.count <= 5 {
            self.isValidNicknameCount.value = true
           self.is5orLess.value = true
        } else {
           self.is5orLess.value = false
           if nickname.count < 2 {
                self.isValidNicknameCount.value = false
            }
        }
    }
    
    func countSelectedTag(isSelected: Bool, tag: String) {
          if isSelected {
             if !selectedTagData.contains(tag) {
                 selectedTagData.append(tag)
             }
          } else {
             if let index = selectedTagData.firstIndex(of: tag) {
                 selectedTagData.remove(at: index)
             }
          }
        
        checkTagCount()
       }
    
    
    func checkTagCount() {
        let count = selectedTagData.count
        self.tagCount.value = count

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
              let isValidTag = isValidTag.value,
              let is5CntVaild = is5orLess.value else { return }

        self.isValidRegistration.value = (isValidNickname && isValidTag && is5CntVaild) ? true : false
    }
    
    func checkExistingNickname() {
        isExistedNickname.value = existingNickname.value == nickname.value ? true : false
    }
    
    func postSignUp(image: UIImage?) {
        let socialType = UserDefaults.standard.bool(forKey: "SocialType")
        
        guard let name = self.nickname.value else { return }

        let requestBody = PostSignUpRequest(userSignUpReq: UserSignUpReq(name: name,
                                                                         platform: socialType 
                                                                         ? SocialType.KAKAO.rawValue
                                                                         : SocialType.APPLE.rawValue),
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
    
    func getDoubleCheck() {
        guard let name = self.nickname.value else { return }
        
        NetworkService.shared.authService.getDoubleCheck(name: name) { response in
            switch response {
            case .success(_):
                self.isValidNickname.value = true
            case .requestErr:
                self.isValidNickname.value = false
            default:
                print("Failed to fetch get double check")
                self.isValidNickname.value = false
                return
            }
        }
    }
    
    func patchEditProfile() {
        guard let name = self.nickname.value else { return }
        let requestBody = PatchEditProfileRequest(name: name, tags: self.selectedTagData, image: self.profileImage.value)
        
        NetworkService.shared.userService.patchEditProfile(requestBody: requestBody) { response in
            switch response {
            case .success(_):
                self.onSuccessEdit?(true)
            default:
                print("Failed to fetch patch edit profile")
                self.onSuccessEdit?(false)
            }
        }
    }
}
