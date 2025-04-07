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
    
    private var loadError: Error? = nil
    
    func loadRewardedAd() {
        let adUnitID = Config.GADAdUnitID
        let request = Request()
        
        RewardedAd.load(with: adUnitID, request: request) { [weak self] ad, error in
            if let error = error as? NSError {
                self?.loadError = error
                // TODO: - 🥐 흠 noFillerror을 여기서 분기처리하고싶은데 ..
            }
            
            self?.rewardedAd = ad
            self?.rewardedAd?.fullScreenContentDelegate = self
        }
    }
    
    func showRewardedAd(from viewController: UIViewController, completion: @escaping (Bool, Error?) -> Void) {
        /// 광고 로드 : loadRewardedAd() 도중 에러
        if let error = loadError {
            completion(false, error)
            return
        }
        
        /// 광고 로드 요청은 됐으나, 로드 안 됨
        guard let rewardedAd = rewardedAd else {
            completion(false, nil)
            return
        }
        
        loadError = nil
        self.adCompletion = completion
        
        self.rewardedAd = nil
        loadRewardedAd()
        
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
        adCompletion?(false, error)
        adCompletion = nil
        loadRewardedAd()
    }
    
}
