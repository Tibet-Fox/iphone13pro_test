//
//  SpeechReturn.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/08/27.
//

import Foundation

struct SpeechReturn: Codable {
    var id: Int
    var question: String
    var answer: String
    var date: String
}
