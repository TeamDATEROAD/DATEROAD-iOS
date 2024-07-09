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
    
    enum Onboarding {
        static let blank = ""
        static let next = "다음"
        static let createProfile = "프로필 생성하기"
        static let firstMainInfoLabel = "데이트로드는 포인트로\n데이트 코스를 열람할 수 있어요."
        static let firstSubInfoLabel = "최초 3회 무료 찬스로\n다른 사람의 데이트 코스를 구경하세요!"
        static let firstHintInfoLabel = "(이후에는 50포인트로 코스를 열람할 수 있어요)"
        static let secondMainInfoLabel = "데이트 코스를 등록하면\n100 포인트를 얻을 수 있어요"
        static let secondSubInfoLabel = "내 연인과 함께한 데이트 코스를 자랑하고\n포인트를 받아보세요"
        static let thirdMainInfoLabel = "쌓인 포인트로\n다양한 데이트 코스를 둘러보세요"
        static let thirdSubInfoLabel = "모인 포인트는 데이트 장소를 예약할 때\n현금처럼 사용 가능해요"
        static let thirdHintInfoLabel = "(추후 제공될 기능이에요)"
        static let dateCourse = "데이트 코스"
        static let firstMainPoint = "포인트"
        static let secondMainPoint = "100 포인트"
        static let thirdMainPoint = "다양한 데이트 코스"
	}
    
    enum TabBar {
        static let home = "홈"
        static let course = "코스 둘러보기"
        static let date = "데이트 일정"
        static let viewedCourse = "열람한 코스"
        static let myPage = "마이페이지"
    }
    
	enum CourseDetail {
        static let timelineInfoLabel = "코스 타임라인"
        static let coastInfoLabel = "총 비용"
        static let tagInfoLabel = "태그"
        static let bringCourseLabel = "코스 가져오기"
        static let viewCoursewithPoint = "포인트로 코스 열람하기"
    }
    
    enum Profile {
        static let myProfile = "내 프로필"
        static let nickname = "닉네임"
        static let nicknamePlaceholder = "닉네임을 입력하세요."
        static let doubleCheck = "중복확인"
        static let disabledNickname = "이미 사용중인 닉네임이에요"
        static let enabledNickname = "사용가능한 닉네임이에요"
        static let countPlaceholder = "0/5"
        static let dateTendency = "나의 데이트 성향 (0/3)"
        static let registerProfile = "프로필 등록하기"
        static let selectTag =  "최소 1개, 최대 3개를 선택해주세요."
        static let settingImage = "프로필 사진 설정"
        static let registerImage = "사진 등록"
        static let deleteImage = "사진 삭제"
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
      static let dateNameErrorLabel = "최소 5글자 이상 입력해주세요"
      static let visitDateErrorLabel = "미래 날짜를 선택하셨어요"
   }
    
    enum MyPage {
        static let myPage = "마이페이지"
        static let goToPointHistory = "포인트 내역 보기"
        static let myCourse = "내가 등록한 코스"
        static let pointSystem = "포인트 시스템 소개"
        static let inquiry = "문의하기"
        static let logout = "로그아웃"
        static let withdrawal = "탈퇴하기"
    }
    
    enum Common {
        static let cancel = "취소"
    }
    
}
