//
//  PostAddCourseResponse.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 7/17/24.
//

import Foundation

// MARK: - PostAddCourseResponse
struct PostAddCourseResponse: Codable {
    let courseID: Int

    enum CodingKeys: String, CodingKey {
        case courseID = "courseId"
    }
}
