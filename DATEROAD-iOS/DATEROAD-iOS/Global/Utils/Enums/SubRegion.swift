//
//  SubRegion.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/17/24.
//

import Foundation

import Foundation

public enum MainRegion: String {
    case SEOUL = "서울"
    case GYEONGGI = "경기"
    case INCHEON = "인천"
}

public enum SubRegion {
    // 서울 소분류
    case SEOUL_ENTIRE
    case GANGNAM_SEOCHO
    case JAMSIL_SONGPA_GANGDONG
    case KONDAE_SUNGSOO_WANGSIMNI
    case JONGNO_JUNGRO
    case HONGDAE_HAPJEONG_MAPO
    case YEONGDEUNGPO_YEOUIDO
    case YONGSAN_ITAEWON_HANNAM
    case YANGCHEON_GANGSEO
    case SEONGBUK_NOWON_JUNGBANG
    case GURO_GWANAK_DONGJAK

    // 경기 소분류
    case GYEONGGI_ENTIRE
    case SEONGNAM
    case SUWON
    case GOYANG_PAJU
    case GIMPO
    case YONGIN_HWASEONG
    case ANYANG_GWACHEON
    case POCHEON_YANGJU
    case NAMYANGJU_UIJEONGBU
    case GWANGJU_ICHEON_YEOJU
    case GAPYEONG_YANGPYEONG
    case GUNPO_UIWANG
    case HANAM_GURI
    case SIHEUNG_GWANGMYEONG
    case BUCHEON_ANSHAN
    case DONGDUCHEON_YEONCHEON
    case PYEONGTAEK_OSAN_ANSEONG

    // 인천 소분류
    case INCHEON_ENTIRE

    // Initialization with raw string values and main region association
    init?(rawValue: String) {
        switch rawValue {
        // 서울 소분류
        case "서울 전체": self = .SEOUL_ENTIRE
        case "강남/서초": self = .GANGNAM_SEOCHO
        case "잠실/송파/강동": self = .JAMSIL_SONGPA_GANGDONG
        case "건대/성수/왕십리": self = .KONDAE_SUNGSOO_WANGSIMNI
        case "종로/중구": self = .JONGNO_JUNGRO
        case "홍대/합정/마포": self = .HONGDAE_HAPJEONG_MAPO
        case "영등포/여의도": self = .YEONGDEUNGPO_YEOUIDO
        case "용산/이태원/한남": self = .YONGSAN_ITAEWON_HANNAM
        case "양천/강서": self = .YANGCHEON_GANGSEO
        case "성북/노원/중랑": self = .SEONGBUK_NOWON_JUNGBANG
        case "구로/관악/동작": self = .GURO_GWANAK_DONGJAK

        // 경기 소분류
        case "경기 전체": self = .GYEONGGI_ENTIRE
        case "성남": self = .SEONGNAM
        case "수원": self = .SUWON
        case "고양/파주": self = .GOYANG_PAJU
        case "김포": self = .GIMPO
        case "용인/화성": self = .YONGIN_HWASEONG
        case "안양/과천": self = .ANYANG_GWACHEON
        case "포천/양주": self = .POCHEON_YANGJU
        case "남양주/의정부": self = .NAMYANGJU_UIJEONGBU
        case "광주/이천/여주": self = .GWANGJU_ICHEON_YEOJU
        case "가평/양평": self = .GAPYEONG_YANGPYEONG
        case "군포/의왕": self = .GUNPO_UIWANG
        case "하남/구리": self = .HANAM_GURI
        case "시흥/광명": self = .SIHEUNG_GWANGMYEONG
        case "부천/안산": self = .BUCHEON_ANSHAN
        case "동두천/연천": self = .DONGDUCHEON_YEONCHEON
        case "평택/오산/안성": self = .PYEONGTAEK_OSAN_ANSEONG

        // 인천 소분류
        case "인천 전체": self = .INCHEON_ENTIRE

        default:
            return nil
        }
    }


    var mainRegion: MainRegion {
        switch self {
        case .SEOUL_ENTIRE, .GANGNAM_SEOCHO, .JAMSIL_SONGPA_GANGDONG, .KONDAE_SUNGSOO_WANGSIMNI, .JONGNO_JUNGRO,
             .HONGDAE_HAPJEONG_MAPO, .YEONGDEUNGPO_YEOUIDO, .YONGSAN_ITAEWON_HANNAM, .YANGCHEON_GANGSEO, .SEONGBUK_NOWON_JUNGBANG,
             .GURO_GWANAK_DONGJAK:
            return .SEOUL
        case .GYEONGGI_ENTIRE, .SEONGNAM, .SUWON, .GOYANG_PAJU, .GIMPO, .YONGIN_HWASEONG, .ANYANG_GWACHEON, .POCHEON_YANGJU,
             .NAMYANGJU_UIJEONGBU, .GWANGJU_ICHEON_YEOJU, .GAPYEONG_YANGPYEONG, .GUNPO_UIWANG, .HANAM_GURI, .SIHEUNG_GWANGMYEONG,
             .BUCHEON_ANSHAN, .DONGDUCHEON_YEONCHEON, .PYEONGTAEK_OSAN_ANSEONG:
            return .GYEONGGI
        case .INCHEON_ENTIRE:
            return .INCHEON
        }
    }
}
