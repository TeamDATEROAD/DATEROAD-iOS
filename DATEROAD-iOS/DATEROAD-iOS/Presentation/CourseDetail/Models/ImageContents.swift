//
//  CourseDetailContents.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/3/24.
//

import UIKit

struct ImageContents {
    let image: UIImage?
    let likeSum: Int?

    // ImageCarousel에서 쓸 것
    init(image: UIImage) {
        self.image = image
        self.likeSum = nil
    }
    
    // BottomPageControlView에서 쓸 것
    init(likeSum: Int) {
        self.image = nil
        self.likeSum = likeSum
    }
}

extension ImageContents {
    static let imageContents: [UIImage] = [
        UIImage(resource: .image1),
        UIImage(resource: .image2),
        UIImage(resource: .image3),
        UIImage(resource: .image4),
        UIImage(resource: .image5)
    ]
    
    static let likeSum: Int = 2
}
