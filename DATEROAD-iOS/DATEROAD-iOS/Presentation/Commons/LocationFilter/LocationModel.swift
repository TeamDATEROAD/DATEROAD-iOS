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


extension LocationModel.City: CaseIterable {
    static var allCases: [LocationModel.City] {
        return [
            // 서울 관련 도시
            .seoul(.all), .seoul(.gangnamSeocho), .seoul(.jamsilSongpaGangdong), .seoul(.kondaeSeongsuWangsimni),
            .seoul(.jongnoJunggu), .seoul(.hongdaeHapjeongMapo), .seoul(.yeongdeungpoYeouido), .seoul(.yongsanItaewonHannam),
            .seoul(.yangcheonGangseo), .seoul(.seongbukNowonYeouido), .seoul(.guroGwanakDongjak),

            // 경기 관련 도시
            .gyeonggi(.all), .gyeonggi(.seongnam), .gyeonggi(.suwon), .gyeonggi(.goyangPaju), .gyeonggi(.gimpo),
            .gyeonggi(.yonginHwaseong), .gyeonggi(.anyangGwacheon), .gyeonggi(.pocheonYangju), .gyeonggi(.namyangjuUijeongbu),
            .gyeonggi(.gwangjuIcheonYeoju), .gyeonggi(.gapyeongYangpyeong), .gyeonggi(.gunpoUiwang), .gyeonggi(.hanamGuri),
            .gyeonggi(.siheungGwangmyeong), .gyeonggi(.bucheonAnsan), .gyeonggi(.dongducheonYeoncheon), .gyeonggi(.pyeongtaekOsanAnseong),

            // 인천 관련 도시
            .incheon(.all)
        ]
    }
}


struct LocationMapper {
    
    // 도시 이름을 기반으로 해당 City와 Country를 반환
    static func getCountryAndCity(from cityName: String) -> (country: LocationModel.Country, city: LocationModel.City)? {
        
        // 도시 이름과 일치하는 LocationModel.City 찾기
        if let city = LocationModel.City.allCases.first(where: { $0.rawValue == cityName }) {
            switch city {
            case .seoul:
                return (country: .seoul, city: city)
            case .gyeonggi(_):
                return (country: .gyeonggi, city: city)
            case .incheon:
                return (country: .incheon, city: city)
            }
        }
       
        return nil
    }
   
}

struct LocationModelCityEngToKor {
    enum City: String {
        case SEOUL_ENTIRE = "SEOUL_ENTIRE"
        case GANGNAM_SEOCHO = "GANGNAM_SEOCHO"
        case JAMSIL_SONGPA_GANGDONG = "JAMSIL_SONGPA_GANGDONG"
        case KONDAE_SUNGSOO_WANGSIMNI = "KONDAE_SUNGSOO_WANGSIMNI"
        case JONGNO_JUNGRO = "JONGNO_JUNGRO"
        case HONGDAE_HAPJEONG_MAPO = "HONGDAE_HAPJEONG_MAPO"
        case YEONGDEUNGPO_YEOUIDO = "YEONGDEUNGPO_YEOUIDO"
        case YONGSAN_ITAEWON_HANNAM = "YONGSAN_ITAEWON_HANNAM"
        case YANGCHEON_GANGSEO = "YANGCHEON_GANGSEO"
        case SEONGBUK_NOWON_JUNGBANG = "SEONGBUK_NOWON_JUNGBANG"
        case GURO_GWANAK_DONGJAK = "GURO_GWANAK_DONGJAK"
        case GYEONGGI_ENTIRE = "GYEONGGI_ENTIRE"
        case SEONGNAM = "SEONGNAM"
        case SUWON = "SUWON"
        case GOYANG_PAJU = "GOYANG_PAJU"
        case GIMPO = "GIMPO"
        case YONGIN_HWASEONG = "YONGIN_HWASEONG"
        case ANYANG_GWACHEON = "ANYANG_GWACHEON"
        case POCHEON_YANGJU = "POCHEON_YANGJU"
        case NAMYANGJU_UIJEONGBU = "NAMYANGJU_UIJEONGBU"
        case GWANGJU_ICHEON_YEOJU = "GWANGJU_ICHEON_YEOJU"
        case GAPYEONG_YANGPYEONG = "GAPYEONG_YANGPYEONG"
        case GUNPO_UIWANG = "GUNPO_UIWANG"
        case HANAM_GURI = "HANAM_GURI"
        case SIHEUNG_GWANGMYEONG = "SIHEUNG_GWANGMYEONG"
        case BUCHEON_ANSHAN = "BUCHEON_ANSHAN"
        case DONGDUCHEON_YEONCHEON = "DONGDUCHEON_YEONCHEON"
        case PYEONGTAEK_OSAN_ANSEONG = "PYEONGTAEK_OSAN_ANSEONG"
        case INCHEON_ENTIRE = "INCHEON_ENTIRE"
        case UNKNOWN = "UNKNOWN"
        
        func toKorean() -> String {
            switch self {
            case .SEOUL_ENTIRE:
                return "서울 전체"
            case .GANGNAM_SEOCHO:
                return "강남/서초"
            case .JAMSIL_SONGPA_GANGDONG:
                return "잠실/송파/강동"
            case .KONDAE_SUNGSOO_WANGSIMNI:
                return "건대/성수/왕십리"
            case .JONGNO_JUNGRO:
                return "종로/중구"
            case .HONGDAE_HAPJEONG_MAPO:
                return "홍대/합정/마포"
            case .YEONGDEUNGPO_YEOUIDO:
                return "영등포/여의도"
            case .YONGSAN_ITAEWON_HANNAM:
                return "용산/이태원/한남"
            case .YANGCHEON_GANGSEO:
                return "양천/강서"
            case .SEONGBUK_NOWON_JUNGBANG:
                return "성북/노원/여의도"
            case .GURO_GWANAK_DONGJAK:
                return "구로/관악/동작"
            case .GYEONGGI_ENTIRE:
                return "경기 전체"
            case .SEONGNAM:
                return "성남"
            case .SUWON:
                return "수원"
            case .GOYANG_PAJU:
                return "고양/파주"
            case .GIMPO:
                return "김포"
            case .YONGIN_HWASEONG:
                return "용인/화성"
            case .ANYANG_GWACHEON:
                return "안양/과천"
            case .POCHEON_YANGJU:
                return "포천/양주"
            case .NAMYANGJU_UIJEONGBU:
                return "남양주/의정부"
            case .GWANGJU_ICHEON_YEOJU:
                return "과천/이천/여주"
            case .GAPYEONG_YANGPYEONG:
                return "가평/양평"
            case .GUNPO_UIWANG:
                return "군포/의왕"
            case .HANAM_GURI:
                return "하남/구리"
            case .SIHEUNG_GWANGMYEONG:
                return "시흥/광명"
            case .BUCHEON_ANSHAN:
                return "부천/안산"
            case .DONGDUCHEON_YEONCHEON:
                return "동두천/연천"
            case .PYEONGTAEK_OSAN_ANSEONG:
                return "평택/오산/안성"
            case .INCHEON_ENTIRE:
                return "인천 전체"
            case .UNKNOWN:
                return "알 수 없음"
            }
        }
    }
}
