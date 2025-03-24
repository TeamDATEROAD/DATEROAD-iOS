//
//  DateCardType.swift
//  DATEROAD-iOS
//
//  Created by 이수민 on 3/24/25.
//

import UIKit

enum DateCardType: Int, CaseIterable {
    
    case pink = 0
    
    case purple = 1
    
    case lime = 2
    
    var bgColor: UIColor {
        switch self {
        case .pink: return UIColor(resource: .pink200)
        case .purple: return UIColor(resource: .purple200)
        case .lime: return UIColor(resource: .lime200)
        }
    }
    
    var buttonColor: UIColor {
        switch self {
        case .pink: return UIColor(resource: .pink100)
        case .purple: return UIColor(resource: .purple100)
        case .lime: return UIColor(resource: .lime100)
        }
    }
    
    var topImage: UIImage {
        switch self {
        case .pink: return UIImage(resource: .lilacTop)
        case .purple: return UIImage(resource: .deepPurpleTop)
        case .lime: return UIImage(resource: .limeTop)
        }
    }
    
    var bottomImage: UIImage {
        switch self {
        case .pink: return UIImage(resource: .lilacBottom)
        case .purple: return UIImage(resource: .deepPurpleBottom)
        case .lime: return UIImage(resource: .limeBottom)
        }
    }
    
    var ribbonImage: UIImage {
        switch self {
        case .pink: return UIImage(resource: .lilacRibbon)
        case .purple: return UIImage(resource: .deepPurpleRibbon)
        case .lime: return UIImage(resource: .limeRibbon)
        }
    }
    
}
