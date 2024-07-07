//
//  StringLiterals.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/1/24.
//

import Foundation

enum StringLiterals {
    
    enum Social {
        static let apple = "apple"
        static let kakao = "kakao"
    }
    
    enum Login {
        static let splash = "데이트 로드"
        static let kakaoLoginLabel = "카카오 로그인"
        static let appleLoginLabel = "Apple ID로 로그인"
        static let privacyPolicyLabel = "개인정보처리방침"
    }
    
    enum CourseDetail {
        static let timelineInfoLabel = "코스 타임라인"
        static let coastInfoLabel = "총 비용"
        static let tagInfoLabel = "태그"
    }
   
   enum AddCourseOrScheduleFirst {
      static let addCourseTitle = "코스 등록하기"
      static let addScheduleTitle = "일정 등록하기"
      static let emptyImage = "이미지를 삽입해주세요\n(최소 1장, 최대 10장)"
      static let dateNmaePlaceHolder = "데이트 이름을 입력해 주세요 (필수)"
      static let visitDateLabel = "방문일자를 선택해 주세요 (필수)"
      static let dateStartTimeLabel = "데이트 시작 시간을 선택해 주세요 (필수)"
      static let tagTitle = "데이트코스와 어울리는 태그를 선택해 주세요 (0/3)"
      static let datePlaceLabel = "데이트 지역을 선택해 주세요 (필수)"
      static let dateNmaeErrorLabel = "최소 5글자 이상 입력해주세요"
      static let visitDateErrorLabel = "미래 날짜를 선택하셨어요"
   }
}
