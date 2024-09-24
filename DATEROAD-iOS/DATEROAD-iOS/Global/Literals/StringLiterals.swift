//
//  StringLiterals.swift
//  DATEROAD-iOS
//
//  Created by 윤희슬 on 7/1/24.
//

import Foundation

enum StringLiterals {
    
    enum NavType {
        static let nav = "nav"
    }
    
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
        static let bringCourseLabel = "내 일정에 추가하기"
        static let viewCoursewithPoint = "포인트로 코스 열람하기"
        static let settingDateCourse = "데이트 코스 설정"
        static let deleteCourse = "글 삭제"
        static let delclareCourse = "신고하기"
        static let check = "확인"
        static let freeViewTitle = "무료 열람 기회를 사용해 보시겠어요?"
        static let freeViewDescription = "무료 열람 기회는 한번 사용하면 취소할 수 없어요"
        static let insufficientPointsTitle = "코스를 열람하기에 포인트가 부족해요"
        static let insufficientPointsDescription = "코스를 등록하고 포인트를 모아보세요"
        static let addCourse = "코스 등록하기"
        static let declareTitle = "데이트 코스를 신고하시겠어요?"
        static let declareDescription = "신고된 게시물은 확인 후 서비스의 운영원칙에\n따라 조치 예정이에요"
        static let deleteTitle = "데이트 코스를 삭제하시겠어요?"
        static let deleteDescription = "삭제된 코스는 복구하실 수 없어요"
        static let viewCourse = "코스 열람하기"
        
    }
    
    enum Profile {
        static let myProfile = "내 프로필"
        static let nickname = "닉네임"
        static let nicknameInfo = "(한글, 영문, 숫자만 가능)"
        static let nicknamePlaceholder = "닉네임을 입력하세요."
        static let doubleCheck = "중복확인"
        static let disabledNickname = "이미 사용 중인 닉네임이에요"
        static let enabledNickname = "사용 가능한 닉네임이에요"
        static let countPlaceholder = "0/5"
        static let dateTendency = "나의 데이트 성향 (0/3)"
        static let registerProfile = "프로필 등록하기"
        static let selectTag =  "최소 1개, 최대 3개를 선택해주세요."
        static let settingImage = "프로필 사진 설정"
        static let registerImage = "사진 등록"
        static let deleteImage = "사진 삭제"
        static let minimumNickname = "최소 2글자를 입력해야 해요"
        static let editProfile = "프로필 변경"
        static let saveProfile = "프로필 변경하기"
    }
   
   enum AddCourseOrSchedule {
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
         static let addFirstNextBtnOfSchedule = "다음"
         static let addScheduleRightBtn = "불러오기"
      }
      
      enum AddSecondView {
         static let contentTitleLabelOfCourse = "어떤 코스로 이동하셨나요?"
         static let contentTitleLabelOfSchedul = "어떤 코스로 이동하시나요?"
         static let subTitleLabel = "장소와 소요시간을 입력하여 코스를 추가해 주세요"
         static let datePlacePlaceHolder = "장소명을 입력해주세요"
         static let timeRequiredPlaceHolder = "소요시간"
         static let guideLabel = "최소 2개의 장소를 추가해 주세요"
         static let edit = "편집"
         static let done = "완료"
         static let addSecondNextBtnOfCourse = "다음 (2/3)"
         static let addSecondDoneBtnOfSchedule = "완료"
      }
      
      enum AddThirdView {
         static let contentTitleLabel = "코스에 대한 설명을 적어 주세요"
         static let contentTextFieldPlaceHolder = "데이트 내용을 입력해 주세요.\n예약 정보, 웨이팅 정보, 꿀팁 등을 작성해 주세요.\n(최소 200자)"
         static let contentTextCountLabel = "0자 / 200자 이상"
         static let priceTitleLabel = "총 비용을 입력해 주세요"
         static let priceTextFieldPlaceHolder = "데이트 예상 총 비용을 숫자로만 입력해 주세요"
         static let addThirdDoneBtn = "완료"
      }
      
      enum AddBottomSheetView {
         static let datePickerBtnTitle = "선택하기"
      }
      
      enum AddCourseAlert {
         static let alertTitleLabel = "코스 등록이 되었어요"
         static let alertScheduelTitleLabel = "데이트 일정이 등록되었어요!"
         static let alertSubTitleLabel = "100P가 적립되었어요!"
         static let doneButton = "확인했어요"
      }
   }
    
    enum MyPage {
        static let myPage = "마이페이지"
        static let goToPointHistory = "포인트 내역 보기"
        static let myCourse = "내가 등록한 코스"
        static let pointSystem = "포인트 제도 소개"
        static let inquiry = "문의하기"
        static let logout = "로그아웃"
        static let withdrawal = "탈퇴하기"
        static let alertWithdrawal = "탈퇴"
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
    
    enum Common {
        static let header = "header"
        static let footer = "footer"
        static let cancel = "취소"
        static let close = "닫기"
    }
    
    enum Main {
        static let hotDateTitle = "님, 오늘은\n이런 데이트 어떠세요?"
        static let hotDateSub = "후기 보장 HOT 데이트 코스 둘러보기"
        static let viewMore = "더보기"
        static let newDateTitle = "새로 올라왔어요"
        static let newDateSub = "가장 최근에 올라온 코스 보러가기"
        static let emptyDateTitle = "다가오는 데이트 일정이 없어요"
        static let emptyDateSub = "일정을 등록하러 가볼까요?"
        static let popular = "POPULAR"
        static let latest = "LATEST"
        static let hot = "HOT: "
        static let new = "NEW: "
    }
    
    enum DateSchedule {
        static let kakaoShare = "카카오톡으로 공유하기"
        static let courseShare = "데이트 코스 올리고 100P 받기"
        static let upcomingDate = "데이트 일정"
        static let seePastDate = "지난 데이트 보기"
        static let pastDate = "지난 데이트"
        static let startTime = "시작"
        static let dateSetting = "데이트 일정 설정"
        static let deleteDate = "글 삭제"
        static let quit = "취소"
        static let dDay = "D-Day"
    }
    
    enum Alert {
        static let kakaoAlert = "데이트로드에서 카카오톡을 열려고 해요"
        static let noMoreSchedule = "데이트를 더 이상 등록할 수 없어요!"
        static let noMoreThanFive = "데이트는 최대 5개까지만 등록 가능해요"
        static let iChecked = "확인했어요"
        static let realWithdrawal = "정말로 탈퇴하시겠어요?"
        static let lastWarning = "삭제된 계정은 복구하실 수 없어요"
        static let wouldYouLogOut = "로그아웃 하시겠어요?"
        static let buyCourse = "50P를 사용해서 코스를 확인해보시겠어요?"
        static let canNotRefund = "구매 후 포인트는 환불되지 않아요"
        static let deleteDateSchedule = "데이트 일정을 삭제하시겠어요?"
        static let deletePastDateSchedule = "지난 데이트를 삭제하시겠어요?"
        static let noMercy = "삭제된 일정은 복구하실 수 없어요"
        static let failToLogout = "로그아웃 실패"
        static let failToWithdrawal = "회원탈퇴 실패"
        static let failToLogin = "로그인 실패"
        static let confirm = "확인"
        static let failToEditProfile = "프로필 변경 실패"
    }
    
    enum Course {
        static let course = "코스 둘러보기"
        static let priceLabelUnder50K = "5만원 이하"
        static let priceLabelUnder30K = "3만원 이하"
        static let priceLabelUnder100K = "10만원 이하"
        static let priceLabelOver100K = "10만원 초과"
        static let isCourseEmpty = "아직 등록된 코스가 없어요!"
    }
    
    enum LocationFilter {
        static let title = "지역을 선택해주세요"
        static let apply = "적용하기"
    }
    
    enum ViewedCourse {
        static let title = "내가 열람한 코스"
        static let registerSchedule = "열람한 코스로 데이트를 짜보세요"
    }
    
    enum PointDetail {
        static let gainedDetail = "획득 내역"
        static let usedDetail = "사용 내역"
        static let title = "포인트 내역"
    }
    
    enum MyRegisterCourse {
        static let title = "내가 등록한 코스"
    }
    
    enum EmptyView {
        static let emptyDateSchedule = "아직 연인과의 데이트 일정을\n등록하지 않으셨나요?"
        static let emptyPastSchedule = "지난 데이트가 없어요!"
        static let emptyViewedCourse = "다른 커플들의 데이트 코스를\n열람해보세요!"
        static let emptyNavViewedCourse = "아직 열람한 코스가 없어요!"
        static let emptyMyRegisterCourse = "아직 등록한 코스가 없어요!"
        static let emptyGainedPoint = "아직 포인트 획득 내역이 없어요!"
        static let emptyUsedPoint = "아직 포인트 사용 내역이 없어요!"
    }
    
    enum Network {
        static let token = "Token"
        static let authCode = "authCode"
        static let socialType = "SocialType"
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let userID = "userID"
        static let userName = "userName"
        static let userPoint = "userPoint"
        static let loadingMessage = "잠시만 기다려주세요\n로딩 중이에요"
        static let mainErrorMessage = "서버 오류가 발생했어요"
        static let subErrorMessage = "마이페이지 문의하기를 통해 문의해 주시면\n빠르게 답변해 드릴게요"
    }
    
    enum WebView {
        static let inquiryLink = "https://dateroad.notion.site/1055d2f7bfe94b3fa6c03709448def21?pvs=4"
        static let privacyPolicyLink = "https://dateroad.notion.site/04da4aa279ca4b599193784091a52859?pvs=4"
    }
    
    enum Identifier {
        static let bannerFooter = "BannerIndexFooterView"
    }
    
    enum Elementkinds {
        static let bannerInfoHeaderView = "BannerInfoHeaderView"
    }
    
    enum Amplitude {
        enum EventName {
            static let viewMain = "view_main"
            static let viewDateSchedule = "view_date_schedule"
            static let countDateSchedule = "count_date_schedule"
        }
        
        enum Property {
            static let courseListId = "course_list_id"
            static let courseListTitle = "course_list_title"
            static let courseListLocation = "course_list_location"
            static let courseListCost = "course_list_cost"
            static let dateScheduleNum = "date_schedule_num"
        }
        
        enum UserProperty {
            static let userName = "user_name"
            static let userPoint = "user_point"
            static let userPurchaseCount = "user_purchase_count"
            static let userCourseCount = "user_course_count"
            static let dateScheduleNum = "date_schedule_num"
        }
    }
}
