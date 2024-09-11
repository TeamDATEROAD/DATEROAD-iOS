//
//  AmplitudeManager.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 9/11/24.
//

import AmplitudeSwift

class AmplitudeManager {
    
    static let shared = AmplitudeManager()
    
    private var amplitude: Amplitude?
    
    private init() {}
    
    func initialize() {
        let amplitudeApiKey = Config.amplitudeAPIKey
        let config = Configuration(apiKey: amplitudeApiKey, offline: false)
        amplitude = Amplitude(configuration: config)
    }
    
    func setUserId(_ userId: String) {
        amplitude?.setUserId(userId: userId)
    }
    
    func getUserId() -> String {
        guard let userId = amplitude?.getUserId() else { return "" }
        return userId
    }
    
    // 기존 사용자와 세션을 완전히 초기화
    func reset() {
        amplitude?.reset()
    }
    
    // 이벤트 트래킹을 위한 메서드 추가
    func logEvent(_ event: String, properties: [String: Any]? = nil) {
        amplitude?.track(eventType: event, eventProperties: properties)
    }
}
