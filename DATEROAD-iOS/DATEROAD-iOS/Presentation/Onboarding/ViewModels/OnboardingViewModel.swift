//
//  OnboardingViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/3/24.
//

import UIKit

final class OnboardingViewModel {
    
    var datasource: [OnboardingModel] = []
    
    var currentPage: ObservablePattern<Int> = ObservablePattern(0)
    
    var goToNextVC: ((Bool) -> Void)?
    
    init() {
        fetchData()
    }
    
}

extension OnboardingViewModel {
    
    func fetchData() {
        datasource.append(contentsOf: [
            OnboardingModel(bgIMG: nil,
                            mainInfo: StringLiterals.Onboarding.firstMainInfoLabel,
                            subInfo: StringLiterals.Onboarding.firstSubInfoLabel,
                            pointText: [StringLiterals.Onboarding.dateCourse, StringLiterals.Onboarding.firstMainPoint],
                           buttonText: StringLiterals.Onboarding.next,
                           buttonType: NextButton()),
            OnboardingModel(bgIMG: UIImage(resource: .secondOnboardingBG),
                            mainInfo: StringLiterals.Onboarding.secondMainInfoLabel,
                            subInfo: StringLiterals.Onboarding.secondSubInfoLabel,
                            pointText: [StringLiterals.Onboarding.secondMainPoint],
                            buttonText: StringLiterals.Onboarding.next,
                            buttonType: NextButton()),
            OnboardingModel(bgIMG: UIImage(resource: .thirdOnboardingBG),
                            mainInfo: StringLiterals.Onboarding.thirdMainInfoLabel,
                            subInfo: StringLiterals.Onboarding.thirdSubInfoLabel,
                            pointText: [StringLiterals.Onboarding.thirdMainPoint],
                            buttonText: StringLiterals.Onboarding.createProfile,
                            buttonType: EnabledButton())
        ])
    }

    func handleToIndex() {
        if currentPage.value == datasource.count - 1 {
            self.goToNextVC?(true)
        } else {
            guard let oldPage = currentPage.value else { return }
            currentPage.value = oldPage + 1
            self.goToNextVC?(false)
        }
    }

}
