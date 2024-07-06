//
//  AddCourseViewModel.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/5/24.
//

import UIKit

final class AddCourseViewModel {
   var dataSource = getSampleImages()
   
   var visitDate: ObservablePattern<String> = ObservablePattern(nil)
}
