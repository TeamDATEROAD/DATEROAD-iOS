//
//  Encodable+.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 4/3/25.
//

import Foundation

extension Encodable {
    
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return nil
        }
        return dictionary
    }
    
}
