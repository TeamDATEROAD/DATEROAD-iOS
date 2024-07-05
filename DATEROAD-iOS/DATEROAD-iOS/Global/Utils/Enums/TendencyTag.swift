//
//  TendencyTag.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/5/24.
//

import Foundation

enum TendencyTag: Int, CaseIterable {
    case drive
    case shopping
    case inside
    case healing
    case alcohol
    case epicurism
    case atelier
    case nature
    case activity
    case show
    case popUp
    
    var tagTitle: String {
        switch self {
        case .drive:
            return "🚙 드라이브"
        case .shopping:
            return "🛍️ 쇼핑"
        case .inside:
            return "🚪 실내"
        case .healing:
            return "🍵 힐링"
        case .alcohol:
            return "🥂 알콜"
        case .epicurism:
            return"🍜 식도락"
        case .atelier:
            return "💍 공방"
        case .nature:
            return "🌊 자연"
        case .activity:
            return "🛼️ 액티비티"
        case .show:
            return "🎭 공연·음악"
        case .popUp:
            return "🎨 전시·팝업"
        }
    }
}
