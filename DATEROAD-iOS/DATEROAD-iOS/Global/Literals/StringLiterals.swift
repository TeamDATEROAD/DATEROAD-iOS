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
        static let next = "다음"
        static let createProfile = "프로필 생성하기"
        static let firstMainInfoLabel = "데이트로드는 포인트로\n데이트 코스를 열람할 수 있어요."
        static let firstSubInfoLabel = "최초 3회 찬스로 다른 사람의 데이트 코스를\n구경해보세요"
        static let secondMainInfoLabel = "데이트 코스를 등록하면\n100 포인트를 얻을 수 있어요"
        static let secondSubInfoLabel = "내 연인과 함께한 데이트 코스를 자랑하고\n포인트를 받아보세요"
        static let thirdMainInfoLabel = "쌓인 포인트로\n다양한 데이트 코스를 둘러보세요"
        static let thirdSubInfoLabel = "모인 포인트는 데이트 장소를 예약할 때\n현금처럼 사용 가능해요"
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
    }
   
   enum AddCourseOrSchedul {
      static let addCourseTitle = "코스 등록하기"
      static let addScheduleTitle = "일정 등록하기"
      
      enum AddFirstView {
         static let emptyImage = "이미지를 삽입해주세요\n(최소 1장, 최대 10장)"
         static let dateNmaePlaceHolder = "데이트 이름을 입력해 주세요 (필수)"
         static let visitDateLabel = "방문일자를 선택해 주세요 (필수)"
         static let dateStartTimeLabel = "데이트 시작 시간을 선택해 주세요 (필수)"
         static let tagTitle = "데이트코스와 어울리는 태그를 선택해 주세요 (0/3)"
         static let datePlaceLabel = "데이트 지역을 선택해 주세요 (필수)"
         static let dateNameErrorLabel = "최소 5글자 이상 입력해주세요"
         static let visitDateErrorLabel = "미래 날짜를 선택하셨어요"
         static let addFirstNextBtnOfCourse = "다음 (1/3)"
         static let addFirstNextBtnOfSchedul = "다음"
      }
      
      enum AddSecondView {
         static let contentTitleLabelOfCourse = "어떤 코스로 이동하셨나요?"
         static let contentTitleLabelOfSchedul = "어떤 코스로 이동하시나요?"
         static let subTitleLabel = "장소와 소요시간을 입력하여 코스를 추가해 주세요"
         static let datePlacePlaceHolder = "장소명을 입력해주세요"
         static let timeRequiredPlaceHolder = "소요시간"
         static let guideLabel = "최소 2개의 장소를 추가해 주세요"
         static let edit = "편집"
         static let addSecondNextBtnOfCourse = "다음 (2/3)"
         static let addSecondDoneBtnOfSchedul = "완료"
      }
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
    
    enum PointSystem {
        static let pointSystem = "포인트 제도 소개"
        static let subTitle = "포인트는 데이트 코스를 등록하면 얻을 수 있어요."
        static let firstMainSystem = "데이트 코스를 등록하면\n포인트를 얻을 수 있어요"
        static let firstSubSystem = "데이트 코스를 자랑하고 포인트를 받아보세요."
        static let secondMainSystem = "처음 3번은 무료로\n데이트 코스를 열람할 수 있어요"
        static let secondSubSystem = "무료 찬스를 사용해 다른 데이트를 열람하세요."
        static let thirdMainSystem = "쌓인 포인트로\n다양한 데이트 코스를 둘러보세요"
        static let thirdSubSystem = "다른 커플들의 데이트, 궁금하지 않으신가요?"
        static let fourthMainSystem = "모인 포인트는 데이트 장소를\n예약할 때 현금처럼 사용 가능해요"
        static let fourthSubSystem = "추후 만들어질 기능을 기대해주세요!"
    }
    
    enum DateSchedule {
        static let kakaoShare = "카카오톡으로 공유하기"
        static let courseShare = "데이트 코스 올리고 50P 받기"
        static let upcomingDate = "데이트 일정"
        static let pastDate = "지난 데이트"
        static let seePastDate = "지난 데이트 보기"
        
    }
}
