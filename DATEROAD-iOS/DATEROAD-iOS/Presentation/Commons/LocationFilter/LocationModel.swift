//
//  LocationModel.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 7/9/24.
//

import UIKit

enum LocationModel {
    enum Country: String, CaseIterable {
        case seoul = "서울"
        case gyeonggi = "경기"
        case incheon = "인천"
        
        var cities: [City] {
            switch self {
            case .seoul:
                return City.Seoul.allCases.map { City.seoul($0) }
            case .gyeonggi:
                return City.Gyeonggi.allCases.map { City.gyeonggi($0) }
            case .incheon:
                return City.Incheon.allCases.map { City.incheon($0) }
            }
        }
    }
    
    enum City {
        case seoul(Seoul)
        case gyeonggi(Gyeonggi)
        case incheon(Incheon)
        
        var rawValue: String {
            switch self {
            case .seoul(let city):
                return city.rawValue
            case .gyeonggi(let city):
                return city.rawValue
            case .incheon(let city):
                return city.rawValue
            }
        }
        
        enum Seoul: String, CaseIterable {
            case all = "서울 전체"
            case gangnamSeocho = "강남/서초"
            case jamsilSongpaGangdong = "잠실/송파/강동"
            case kondaeSeongsuWangsimni = "건대/성수/왕십리"
            case jongnoJunggu = "종로/중구"
            case hongdaeHapjeongMapo = "홍대/합정/마포"
            case yeongdeungpoYeouido = "영등포/여의도"
            case yongsanItaewonHannam = "용산/이태원/한남"
            case yangcheonGangseo = "양천/강서"
            case seongbukNowonYeouido = "성북/노원/여의도"
            case guroGwanakDongjak = "구로/관악/동작"
        }
        
        enum Gyeonggi: String, CaseIterable {
            case all = "경기 전체"
            case seongnam = "성남"
            case suwon = "수원"
            case goyangPaju = "고양/파주"
            case gimpo = "김포"
            case yonginHwaseong = "용인/화성"
            case anyangGwacheon = "안양/과천"
            case pocheonYangju = "포천/양주"
            case namyangjuUijeongbu = "남양주/의정부"
            case gwangjuIcheonYeoju = "과천/이천/여주"
            case gapyeongYangpyeong = "가평/양평"
            case gunpoUiwang = "군포/의왕"
            case hanamGuri = "하남/구리"
            case siheungGwangmyeong = "시흥/광명"
            case bucheonAnsan = "부천/안산"
            case dongducheonYeoncheon = "동두천/연천"
            case pyeongtaekOsanAnseong = "평택/오산/안성"
        }
        
        enum Incheon: String, CaseIterable {
            case all = "인천 전체"
        }
    }
    
    static func countryData() -> [Country] {
        return Country.allCases
    }
}


struct LocationModelCountryKorToEng {
    enum Country: String {
        case SEOUL
        case GYEONGGI
        case INCHEON
        case UNKNOWN

        init(rawValue: String) {
            switch rawValue {
            case "서울":
                self = .SEOUL
            case "경기":
                self = .GYEONGGI
            case "인천":
                self = .INCHEON
            default:
                self = .UNKNOWN
            }
        }
    }
}

struct LocationModelCityKorToEng {
    enum City: String {
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
        case INCHEON_ENTIRE
        case UNKNOWN

        init(rawValue: String) {
            switch rawValue {
            case "서울 전체":
                self = .SEOUL_ENTIRE
            case "강남/서초":
                self = .GANGNAM_SEOCHO
            case "잠실/송파/강동":
                self = .JAMSIL_SONGPA_GANGDONG
            case "건대/성수/왕십리":
                self = .KONDAE_SUNGSOO_WANGSIMNI
            case "종로/중구":
                self = .JONGNO_JUNGRO
            case "홍대/합정/마포":
                self = .HONGDAE_HAPJEONG_MAPO
            case "영등포/여의도":
                self = .YEONGDEUNGPO_YEOUIDO
            case "용산/이태원/한남":
                self = .YONGSAN_ITAEWON_HANNAM
            case "양천/강서":
                self = .YANGCHEON_GANGSEO
            case "성북/노원/여의도":
                self = .SEONGBUK_NOWON_JUNGBANG
            case "구로/관악/동작":
                self = .GURO_GWANAK_DONGJAK
            case "경기 전체":
                self = .GYEONGGI_ENTIRE
            case "성남":
                self = .SEONGNAM
            case "수원":
                self = .SUWON
            case "고양/파주":
                self = .GOYANG_PAJU
            case "김포":
                self = .GIMPO
            case "용인/화성":
                self = .YONGIN_HWASEONG
            case "안양/과천":
                self = .ANYANG_GWACHEON
            case "포천/양주":
                self = .POCHEON_YANGJU
            case "남양주/의정부":
                self = .NAMYANGJU_UIJEONGBU
            case "과천/이천/여주":
                self = .GWANGJU_ICHEON_YEOJU
            case "가평/양평":
                self = .GAPYEONG_YANGPYEONG
            case "군포/의왕":
                self = .GUNPO_UIWANG
            case "하남/구리":
                self = .HANAM_GURI
            case "시흥/광명":
                self = .SIHEUNG_GWANGMYEONG
            case "부천/안산":
                self = .BUCHEON_ANSHAN
            case "동두천/연천":
                self = .DONGDUCHEON_YEONCHEON
            case "평택/오산/안성":
                self = .PYEONGTAEK_OSAN_ANSEONG
            case "인천 전체":
                self = .INCHEON_ENTIRE
            default:
                self = .UNKNOWN
            }
        }
    }
}
