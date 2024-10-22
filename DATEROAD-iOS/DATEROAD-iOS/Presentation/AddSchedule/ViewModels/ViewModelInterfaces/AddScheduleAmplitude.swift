//
//  AddScheduleAmplitude.swift
//  DATEROAD-iOS
//
//  Created by 박신영 on 10/22/24.
//

import UIKit

// MARK: - AddSchedule Amplitude

class AddScheduleAmplitude {
    
    var dateTitle: Bool = false
    
    var dateDate: Bool = false
    
    var dateTime: Bool = false
    
    var dateTagNum: Int = 0
    
    var dateArea: Bool = false
    
    var dateDetailLocation: Bool = false
    
    var dateDetailTime: Bool = false
    
    var dateCourseNum: Int = 0
    
    /// Amplitude 변수 init
    func initAmplitudeVar() {
        dateTitle = false
        dateDate = false
        dateTime = false
        dateTagNum = 0
        dateArea = false
        dateDetailLocation = false
        dateDetailTime = false
        dateCourseNum = 0
    }
    
    /// Amplitude 변수 초기화
    func resetAddFirstScheduleAmplitude() {
        dateTitle = false
        dateDate = false
        dateTime = false
        dateTagNum = 0
        dateArea = false
    }
    
    /// 일정등록 화면1 뒤로가기 버튼 클릭
    func schedule1BackAmplitude() {
        AmplitudeManager.shared.trackEventWithProperties(
            StringLiterals.Amplitude.EventName.clickSchedule1Back,
            properties: [
                StringLiterals.Amplitude.Property.dateTitle: self.dateTitle,
                StringLiterals.Amplitude.Property.dateDate: self.dateDate,
                StringLiterals.Amplitude.Property.dateTime: self.dateTime,
                StringLiterals.Amplitude.Property.dateTagNum: self.dateTagNum,
                StringLiterals.Amplitude.Property.dateArea: self.dateArea
            ]
        )
        self.resetAddFirstScheduleAmplitude()
    }
    
    /// 일정등록 화면2 뒤로가기 버튼 클릭
    func schedule2BackAmplitude() {
        AmplitudeManager.shared.trackEventWithProperties(
            StringLiterals.Amplitude.EventName.clickSchedule2Back,
            properties: [
                StringLiterals.Amplitude.Property.dateDetailLocation: self.dateDetailLocation,
                StringLiterals.Amplitude.Property.dateDetailTime: self.dateDetailTime,
                StringLiterals.Amplitude.Property.dateCourseNum: self.dateCourseNum
            ]
        )
    }
    
}
