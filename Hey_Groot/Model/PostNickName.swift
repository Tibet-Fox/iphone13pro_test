//
//  PostNickName.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/08/27.
//

import Foundation

//캐릭터 닉네임
struct PostNickName: Encodable {
    var character_id: Int
    var user_id: Int
    var name: String
    var is_alarm : Bool
    var pot_color : String
}
