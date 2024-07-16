//
//  SubRegion.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/17/24.
//

import Foundation

public enum SubRegion: String {
    // 서울 소분류
    case SEOUL_ENTIRE = "서울 전체"
    case GANGNAM_SEOCHO = "강남/서초"
    case JAMSIL_SONGPA_GANGDONG = "잠실/송파/강동"
    case KONDAE_SUNGSOO_WANGSIMNI = "건대/성수/왕십리"
    case JONGNO_JUNGRO = "종로/중구"
    case HONGDAE_HAPJEONG_MAPO = "홍대/합정/마포"
    case YEONGDEUNGPO_YEOUIDO = "영등포/여의도"
    case YONGSAN_ITAEWON_HANNAM = "용산/이태원/한남"
    case YANGCHEON_GANGSEO = "양천/강서"
    case SEONGBUK_NOWON_JUNGBANG = "성북/노원/중랑"
    case GURO_GWANAK_DONGJAK = "구로/관악/동작"

    // 경기 소분류
    case GYEONGGI_ENTIRE = "경기 전체"
    case SEONGNAM = "성남"
    case SUWON = "수원"
    case GOYANG_PAJU = "고양/파주"
    case GIMPO = "김포"
    case YONGIN_HWASEONG = "용인/화성"
    case ANYANG_GWACHEON = "안양/과천"
    case POCHEON_YANGJU = "포천/양주"
    case NAMYANGJU_UIJEONGBU = "남양주/의정부"
    case GWANGJU_ICHEON_YEOJU = "광주/이천/여주"
    case GAPYEONG_YANGPYEONG = "가평/양평"
    case GUNPO_UIWANG = "군포/의왕"
    case HANAM_GURI = "하남/구리"
    case SIHEUNG_GWANGMYEONG = "시흥/광명"
    case BUCHEON_ANSHAN = "부천/안산"
    case DONGDUCHEON_YEONCHEON = "동두천/연천"
    case PYEONGTAEK_OSAN_ANSEONG = "평택/오산/안성"

    // 인천 소분류
    case INCHEON_ENTIRE = "인천 전체"
    
    // Enum 초기화 메서드 추가
    public init?(rawValue: String) {
        switch rawValue {
        case SubRegion.SEOUL_ENTIRE.rawValue: self = .SEOUL_ENTIRE
        case SubRegion.GANGNAM_SEOCHO.rawValue: self = .GANGNAM_SEOCHO
        case SubRegion.JAMSIL_SONGPA_GANGDONG.rawValue: self = .JAMSIL_SONGPA_GANGDONG
        case SubRegion.KONDAE_SUNGSOO_WANGSIMNI.rawValue: self = .KONDAE_SUNGSOO_WANGSIMNI
        case SubRegion.JONGNO_JUNGRO.rawValue: self = .JONGNO_JUNGRO
        case SubRegion.HONGDAE_HAPJEONG_MAPO.rawValue: self = .HONGDAE_HAPJEONG_MAPO
        case SubRegion.YEONGDEUNGPO_YEOUIDO.rawValue: self = .YEONGDEUNGPO_YEOUIDO
        case SubRegion.YONGSAN_ITAEWON_HANNAM.rawValue: self = .YONGSAN_ITAEWON_HANNAM
        case SubRegion.YANGCHEON_GANGSEO.rawValue: self = .YANGCHEON_GANGSEO
        case SubRegion.SEONGBUK_NOWON_JUNGBANG.rawValue: self = .SEONGBUK_NOWON_JUNGBANG
        case SubRegion.GURO_GWANAK_DONGJAK.rawValue: self = .GURO_GWANAK_DONGJAK
        case SubRegion.GYEONGGI_ENTIRE.rawValue: self = .GYEONGGI_ENTIRE
        case SubRegion.SEONGNAM.rawValue: self = .SEONGNAM
        case SubRegion.SUWON.rawValue: self = .SUWON
        case SubRegion.GOYANG_PAJU.rawValue: self = .GOYANG_PAJU
        case SubRegion.GIMPO.rawValue: self = .GIMPO
        case SubRegion.YONGIN_HWASEONG.rawValue: self = .YONGIN_HWASEONG
        case SubRegion.ANYANG_GWACHEON.rawValue: self = .ANYANG_GWACHEON
        case SubRegion.POCHEON_YANGJU.rawValue: self = .POCHEON_YANGJU
        case SubRegion.NAMYANGJU_UIJEONGBU.rawValue: self = .NAMYANGJU_UIJEONGBU
        case SubRegion.GWANGJU_ICHEON_YEOJU.rawValue: self = .GWANGJU_ICHEON_YEOJU
        case SubRegion.GAPYEONG_YANGPYEONG.rawValue: self = .GAPYEONG_YANGPYEONG
        case SubRegion.GUNPO_UIWANG.rawValue: self = .GUNPO_UIWANG
        case SubRegion.HANAM_GURI.rawValue: self = .HANAM_GURI
        case SubRegion.SIHEUNG_GWANGMYEONG.rawValue: self = .SIHEUNG_GWANGMYEONG
        case SubRegion.BUCHEON_ANSHAN.rawValue: self = .BUCHEON_ANSHAN
        case SubRegion.DONGDUCHEON_YEONCHEON.rawValue: self = .DONGDUCHEON_YEONCHEON
        case SubRegion.PYEONGTAEK_OSAN_ANSEONG.rawValue: self = .PYEONGTAEK_OSAN_ANSEONG
        case SubRegion.INCHEON_ENTIRE.rawValue: self = .INCHEON_ENTIRE
        default: return nil
        }
    }
}
