//
//  AddTableViewModel.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/10/24.
//

import Foundation

struct AddCoursePlaceModel: Equatable {
    
    let placeTitle: String
    
    let address: String
    
    let timeRequire: String
    
    init(placeTitle: String, address: String, timeRequire: String) {
        self.placeTitle = placeTitle
        self.address = address
        self.timeRequire = timeRequire
    }
    
}

