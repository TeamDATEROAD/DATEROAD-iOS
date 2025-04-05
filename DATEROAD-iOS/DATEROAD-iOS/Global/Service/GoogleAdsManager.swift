//
//  GoogleAdsManager.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 4/5/25.
//

import Foundation
import GoogleMobileAds

final class GoogleAdsManager: NSObject {
    
    static let shared = GoogleAdsManager()
    
    private var rewardedAd: RewardedAd?
    
    private var adCompletion: ((Bool, Error) -> Void)?
    
    func loadRewardedAd() {
        let adUnitID = "adUnitID" // TODO: config에 넣기
        let request = Request()
        
        RewardedAd.load(with: adUnitID, request: request) { [weak self] ad, error in
            if let error = error as? NSError {
                if error.code == 1 {
                    print("noFillError : 제한 5개 다 씀")
                } else {
                    print("광고 로드 실패: \(error.localizedDescription)")
                }
                // TODO: - 흠 noFillerror을 여기서 분기처리하고싶은데 ..
                self?.adCompletion?(false, error)
                self?.adCompletion = nil
            }
            
            self?.rewardedAd = ad
            self?.rewardedAd?.fullScreenContentDelegate = self
        }
    }
    
    func showRewardedAd(from viewController: UIViewController, completion: @escaping (Bool, Error?) -> Void) {
        guard let rewardedAd = rewardedAd else {
            /// 광고 준비 안 됨
            completion(false, nil)
            return
        }
        
        self.adCompletion = completion
        
        rewardedAd.present(from: viewController) {
            let reward = rewardedAd.adReward
            
            completion(true, nil)
            self.adCompletion = nil
        }
    }
    
}


// MARK: - FullScreenContentDelegate

extension GoogleAdsManager: FullScreenContentDelegate {

    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        /// 광고가 닫힘
        loadRewardedAd()
    }
    
    func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        /// 광고 처리 실패
        print("광고 표시 실패: \(error.localizedDescription)")
        adCompletion?(false, error)
        adCompletion = nil
        loadRewardedAd()
    }
    
}
