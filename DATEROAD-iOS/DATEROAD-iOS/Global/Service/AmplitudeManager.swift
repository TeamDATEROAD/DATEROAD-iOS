//
//  AmplitudeManager.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 9/11/24.
//
import UIKit

import AmplitudeSwift

final class AmplitudeManager {
    
    static let shared = AmplitudeManager()
    
    private var amplitude: Amplitude?
    
    private init() {}
    
    func initialize() {
        let amplitudeApiKey = Config.amplitudeAPIKey
        let config = Configuration(apiKey: amplitudeApiKey)
        config.logLevel = .DEBUG
        amplitude = Amplitude(configuration: config)
    }
    
    func setUserId(_ userId: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        print("id : \(formattedDate + userId)")
        amplitude?.setUserId(userId: formattedDate + userId)
    }
    
    func getUserId() -> String {
        guard let userId = amplitude?.getUserId() else { return "" }
        return userId
    }
    
    // 기존 사용자와 세션을 완전히 초기화
    func reset() {
        amplitude?.reset()
    }
    
    // 프로퍼티가 있는 이벤트 트래킹을 위한 메서드
    func trackEventWithProperties(_ event: String, properties: [String: Any]) {
        let event = BaseEvent(
            callback: { (event: BaseEvent, code: Int, message: String) -> Void in
                print("eventCallback: \(event.eventType), code: \(code), message: \(message)")
            },
            eventType: event,
            eventProperties: properties)
        self.amplitude?.track(event: event)
    }
    
    // 프로퍼티가 없는 이벤트 트래킹을 위한 메서드
    func trackEvent(_ event: String) {
        self.amplitude?.track(eventType: event)
    }
    
    func setUserProperty(userProperties: [String: Any]) {
        amplitude?.identify(userProperties: userProperties)
    }
    
}
