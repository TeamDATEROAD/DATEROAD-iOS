//
//  GoogleAdsPresentable.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 4/8/25.
//

import UIKit

protocol GoogleAdsPresentable: AnyObject {
    
    var pointViewModel: PointViewModel { get }
    
}


// MARK: - 프로토콜 기본 구현

extension GoogleAdsPresentable where Self: UIViewController {
    
    /// 광고 에러 알럿 표시
    func presentAdvertisementErrorAlert(error: GoogleAdsErrorType, delegate: DRCustomAlertDelegate? = nil) {
        switch error {
        case .noFill:
            let customAlertVC = DRCustomAlertViewController(
                rightActionType: RightButtonType.none,
                alertTextType: .hasDecription,
                titleText: error.alertTitle,
                descriptionText: error.alertMessage ?? "",
                longButton: DRTextButton(title: StringLiterals.Alert.iChecked, buttonName: .bold_purple_10)
            )
            customAlertVC.delegate = delegate
            customAlertVC.modalPresentationStyle = .overFullScreen
            self.present(customAlertVC, animated: false)
        case .networkErr:
            GoogleAdsManager.shared.resetAdState()
            GoogleAdsManager.shared.needsAdReloadOnNetworkRecovery = true
            self.presentAlertVC(title: error.alertTitle, message: error.alertMessage)
        default:
            self.presentAlertVC(title: error.alertTitle, message: error.alertMessage)
        }
    }

    /// 광고 시청 로직
    func showRewardedAd() {
        GoogleAdsManager.shared.showRewardedAd(from: self) { [weak self] success, error in
            guard let self = self else { return }
            if success {
                pointViewModel.postPoint()
            } else if let nsError = error as? NSError {
                print("🥐", nsError.code)
                let adError = GoogleAdsErrorType(from: nsError)
                self.presentAdvertisementErrorAlert(error: adError, delegate: self as? DRCustomAlertDelegate)
            } else {
                self.presentAlertVC(title: StringLiterals.Alert.adFailTitle)
            }
        }
    }
    
}
