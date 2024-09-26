//
//  PointSystemViewModel.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/9/24.
//

import Foundation

final class PointSystemViewModel {
    
    var pointSystemData: [PointSystemModel] = []
    
}

extension PointSystemViewModel {
    
    func fetchData() {
        self.pointSystemData = PointSystemModel.pointSystemData
    }
    
}
