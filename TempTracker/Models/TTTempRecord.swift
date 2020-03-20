//
//  TTTempRecord.swift
//  TempTracker
//
//  Created by Jacqueline Sloves on 3/20/20.
//  Copyright © 2020 Jacqueline Sloves. All rights reserved.
//

import Foundation

enum TTSymptomType: String, Codable, CustomStringConvertible {
    case none = "NONE"
    case cough = "COUGH"
    case fever = "FEVER"
    case throat = "THROAT"
    case headache = "HEADACHE"
    case nausea = "NAUSEA"
    case congestion = "CONGESTION"

    var description: String {
        switch self {
        case .none:
            return "None"
        case .cough:
            return "Cough"
        case .fever:
            return "Fever"
        case .throat:
            return "Sore Throat"
        case .headache:
            return "Headache"
        case .nausea:
            return "Nausea"
        case .congestion:
            return "Congestion"
        }
    }
}

struct TTTempRecordResult: Codable {

    let tempRecords: [TTTempRecord]

    enum CodingKeys: String, CodingKey {
        case tempRecords // this should be the
    }
}

class TTTempRecord: Codable {

    let uuid: String
    let temp: Float
    let isFarenheit: Bool // Farenheit or Celcius
    let canWork: Bool
    let symptoms: [TTSymptomType]
    let latCoord: Float
    let longCoord: Float
    let dayTimeLogged: Date // auto-generated on submit
    let dayTimeOfTempTaken: Date // user-reported time of temp taken
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case temp
        case isFarenheit
        case canWork
        case symptoms
        case latCoord
        case longCoord
        case dayTimeLogged
        case dayTimeOfTempTaken
    }
}

