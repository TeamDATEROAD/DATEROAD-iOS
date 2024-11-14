//
//  ProfileViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/5/24.
//

import UIKit

final class ProfileViewModel: Serviceable {
    
    var type: ObservablePattern<NetworkType> = ObservablePattern(nil)
    
    var tagData: [ProfileTagModel] = []
    
    var selectedTagData: [String]
    
    var profileData: ObservablePattern<ProfileModel>
    
    var isDefaultImage: Bool = false
    
    var isTagChangeValid: Bool = false
    
    var startFromProfileChange: Bool = false
    
    var startFromNickNameChange: Bool = false
    
    var profileImage: ObservablePattern<UIImage>
    
    var existingNickname: ObservablePattern<String>
    
    var isExistedNickname: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var nickname: ObservablePattern<String>
    
    var tagCount: ObservablePattern<Int> = ObservablePattern(0)
    
    var isValidNicknameCount: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isValidNickname: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isValidTag: ObservablePattern<Bool> = ObservablePattern(false)
    
    var isValidRegistration: ObservablePattern<Bool> = ObservablePattern(false)
    
    var is5orLess: ObservablePattern<Bool> = ObservablePattern(false)
    
    var onLoading: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onSuccessRegister: ((Bool) -> Void)?
    
    var onSuccessEdit: ((Bool) -> Void)?
    
    var onReissueSuccess: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onEditProfileLoading: ObservablePattern<Bool> = ObservablePattern(nil)
    
    var onFailNetwork: ObservablePattern<Bool> = ObservablePattern(false)
    
    var alertMessage: ObservablePattern<String> = ObservablePattern(nil)

    
    
    init(profileData: ProfileModel) {
        self.profileData = ObservablePattern(profileData)
        self.profileImage = ObservablePattern(profileData.profileImage)
        self.existingNickname = ObservablePattern(profileData.nickname)
        self.nickname = ObservablePattern(profileData.nickname)
        self.selectedTagData = profileData.tags
        fetchTagData()
    }
    
}

// 프로필 등록 & 수정 공통 메소드

extension ProfileViewModel {
    
    func fetchTagData() {
        tagData = TendencyTag.allCases.map { $0.tag }
    }
    
    /// TODO: 기존 프사와 같은 이미지를 골랐음에도 flag 값이 false로 반환됨
    /// 추후 Image 비교 로직 구현해야함
    func isProfileImageChange(selectedImage: UIImage) -> Bool {
        if let profileImage = profileImage.value {
            print("기존 값과 같은지 비교 : \(profileImage.isEqual(selectedImage))")
            let flag = profileImage.isEqual(selectedImage)
            return !flag
        } else {
            return false
        }
    }
    
    // 닉네임 글자 수 확인 => 유효카운트 여부 & 5자초과 여부 업데이트
    func checkValidNicknameCount() {
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
        
        isTagChangeValid = isTagChange()
        
        if count >= 1 && count <= 3 && isTagChangeValid
            || startFromProfileChange || startFromNickNameChange {
            self.isValidTag.value = true
        } else {
            self.isValidTag.value = false
        }
    }
    
    func isTagChange() -> Bool {
        let beforeData = profileData.value?.tags
        let currentData = selectedTagData
        return beforeData == currentData ? false : true
    }
    
    func checkValidRegistration() {
        guard let isValidNickname = isValidNickname.value,
              let isValidTag = isValidTag.value,
              let is5CntVaild = is5orLess.value else { return }
        
        self.isValidRegistration.value = (isValidNickname && isValidTag && is5CntVaild)
    }
    
    func postSignUp() {
        self.onLoading.value = true
        let socialType = UserDefaults.standard.bool(forKey: StringLiterals.Network.socialType)
        
        guard let name = self.nickname.value else { return }
        self.checkDefaultImage()
        let requestBody = PostSignUpRequest(userSignUpReq: UserSignUpReq(name: name, platform: socialType ? SocialType.KAKAO.rawValue : SocialType.APPLE.rawValue),
                                            image: self.profileImage.value,
                                            tag: self.selectedTagData)
        
        NetworkService.shared.authService.postSignUp(requestBody: requestBody) { response in
            switch response {
            case .success(let data):
                UserDefaults.standard.setValue(data.userID, forKey: StringLiterals.Network.userID)
                UserDefaults.standard.setValue(data.accessToken, forKey: StringLiterals.Network.accessToken)
                UserDefaults.standard.setValue(data.refreshToken, forKey: StringLiterals.Network.refreshToken)
                self.onSuccessRegister?(true)
                self.onLoading.value = false
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.type.value = NetworkType.postSignUp
                    self.onReissueSuccess.value = isSuccess
                }
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
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.type.value = NetworkType.getDoubleCheck
                    self.onReissueSuccess.value = isSuccess
                }
            case .requestErr:
                self.isValidNickname.value = false
            case .serverErr:
                self.alertMessage.value = StringLiterals.Alert.serverError
            case .networkFail:
                self.alertMessage.value = StringLiterals.Alert.networkFail
            default:
                print("Failed to fetch get double check")
                self.isValidNickname.value = false
                return
            }
        }
    }
    
}

// 프로필 수정 관련 메소드

extension ProfileViewModel {
    
    func patchEditProfile() {
        self.onEditProfileLoading.value = true
        self.onFailNetwork.value = false
        guard let name = self.nickname.value else { return }
        checkDefaultImage()
        let requestBody = PatchEditProfileRequest(name: name,
                                                  tags: self.selectedTagData,
                                                  image: self.profileImage.value,
                                                  isDefaultImage: self.isDefaultImage)
        
        NetworkService.shared.userService.patchEditProfile(requestBody: requestBody) { response in
            switch response {
            case .success(_):
                self.onSuccessEdit?(true)
                self.onEditProfileLoading.value = false
            case .reIssueJWT:
                self.patchReissue { isSuccess in
                    self.type.value = NetworkType.patchEditProfile
                    self.onReissueSuccess.value = isSuccess
                }
            default:
                print("Failed to fetch patch edit profile")
                self.onFailNetwork.value = true
                self.onSuccessEdit?(false)
            }
        }
    }
    
    func compareExistingNickname() {
        isExistedNickname.value = existingNickname.value == nickname.value
    }
    
    func checkDefaultImage() {
        if self.profileImage.value == UIImage(resource: .emptyProfileImg) {
            self.profileImage.value = nil
            self.isDefaultImage = true
        } else {
            self.isDefaultImage = false
        }
    }
    
}

