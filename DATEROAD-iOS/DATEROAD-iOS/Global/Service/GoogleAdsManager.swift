//
//  GoogleAdsManager.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 4/5/25.
//

import Foundation
import GoogleMobileAds
import Network

final class GoogleAdsManager: NSObject {
    
    static let shared = GoogleAdsManager()
    
    var rewardedAd: RewardedAd?
    
    private var adCompletion: ((Bool, Error?) -> Void)?
    
    private var loadError: Error? = nil
    
    private var isNetworkConnected = false
    
    var needsAdReloadOnNetworkRecovery = false
    
    private var periodicNetworkCheckTimer: Timer?
    
    private override init() {
        super.init()
    }
    
    func loadRewardedAd() {
        let adUnitID = Config.GADAdUnitID
        let request = Request()
        
        RewardedAd.load(with: adUnitID, request: request) { [weak self] ad, error in
            guard let self = self else { return }
            
            if let error = error as? NSError {
                self.loadError = error

                let adErrorType = GoogleAdsErrorType(from: error as NSError)
                if adErrorType == .networkErr {
                    print("🥐 네트워크 오류: 광고 로드 실패")
                    self.resetAdState()
                    self.needsAdReloadOnNetworkRecovery = true
                }
            } else {
                self.loadError = nil
            }
            
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
        }
    }
    
    func showRewardedAd(from viewController: UIViewController, completion: @escaping (Bool, Error?) -> Void) {
        /// 광고 호출 전 네트워크 확인
        if !isNetworkConnected {
            print("🥐 광고 표시 불가: 네트워크 연결 안 됨")
            let networkError = NSError(domain: NSURLErrorDomain, code: -1009,
                                    userInfo: [NSLocalizedDescriptionKey: "인터넷 연결이 오프라인 상태입니다."])
            needsAdReloadOnNetworkRecovery = true
            completion(false, networkError)
            return
        }
        
        if let error = loadError {
            completion(false, error)
            return
        }
        
        guard let rewardedAd = rewardedAd else {
            /// 광고 객체 없음 -> 새로 로드
            loadRewardedAd()
            completion(false, nil)
            return
        }
        
        loadError = nil
        self.adCompletion = completion
        
        self.rewardedAd = nil
        loadRewardedAd()
        
        rewardedAd.present(from: viewController) {
            completion(true, nil)
            self.adCompletion = nil
        }
    }
    
    func initialize() {
        MobileAds.shared.start(completionHandler: nil)
        
        periodicNetworkCheck()
        loadRewardedAd()
    }
    
}


// MARK: - FullScreenContentDelegate

extension GoogleAdsManager: FullScreenContentDelegate {
    
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        loadRewardedAd()
    }
    
    func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        let completion = adCompletion
        adCompletion = nil
        
        DispatchQueue.main.async {
            completion?(false, error)
        }
    }
    
}


// MARK: - 네트워크 연결 관련 메서드

extension GoogleAdsManager {
    
    /// 광고 객체 초기화
    func resetAdState() {
        rewardedAd?.fullScreenContentDelegate = nil
        rewardedAd = nil
        loadError = nil
    }
    
    /// 3초마다 네트워크 확인
    func periodicNetworkCheck() {
        periodicNetworkCheckTimer?.invalidate()
        periodicNetworkCheckTimer = nil
        
        periodicNetworkCheckTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            let monitor = NWPathMonitor()
            let checkQueue = DispatchQueue(label: "PeriodicNetworkCheck")
            
            monitor.pathUpdateHandler = { path in
                let isConnected = path.status == .satisfied
                let previousState = self.isNetworkConnected
                self.isNetworkConnected = isConnected
                
                if isConnected && !previousState && self.needsAdReloadOnNetworkRecovery {
                    print("🥐 periodicNetworkCheck - 네트워크 복구 감지")
                    
                    DispatchQueue.main.async {
                        self.needsAdReloadOnNetworkRecovery = false
                        
                        self.resetAdState()
                        self.loadRewardedAd()
                    }
                } else if !isConnected && previousState {
                    print("🥐 periodicNetworkCheck - 네트워크 끊김 감지")
                    self.needsAdReloadOnNetworkRecovery = true
                }
                monitor.cancel()
            }
            monitor.start(queue: checkQueue)
        }
        print("🥐 periodicNetworkCheck - 네트워크 확인 시작")
    }
    
}
