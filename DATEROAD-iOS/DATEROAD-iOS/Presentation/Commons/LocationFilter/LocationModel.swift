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
