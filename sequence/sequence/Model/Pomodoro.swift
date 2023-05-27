//
//  PomodoroData.swift
//  sequence
//
//  Created by 윤소희 on 2022/05/31.
//

import Foundation

struct PomodoroStartData: Codable {
    var _id : String?
    var startDate : String?
}

struct PomodoroResponse: Codable {
    var success: Bool?
    var status: Int?
    var message: String?
    var data: PomodoroStartData
    
}





