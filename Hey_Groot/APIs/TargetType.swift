//
//  TargetType.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/08/20.
//

import Foundation
import Moya

enum Types {
    case postNewUser(email: String, password1: String, password2: String)
    case postLogin(email: String, password: String)
    case postLogout
    case deleteUser
    case postNickName(character_id:Int, name: String)
    case postSpeechToText(question: String)
    case getSpeechAnswer
}

extension Types: TargetType {
    var baseURL: URL {
        let baseUrl = "http://3.20.48.164:8000/"
        let url = URL(string: baseUrl)!
        return url
    }
    
    var path: String {
        switch self {
        case .postNewUser(_, _, _): return "user/auth/registration/"
        case .postLogin(_, _): return "user/auth/login/"
        case .postLogout: return "user/auth/logout"
        case .deleteUser: return "user/auth/delete/"
        case .postNickName(_, _): return "plant/partner/"
        case .postSpeechToText(_): return "plant/chat/"
        case .getSpeechAnswer: return "plant/chat/"
        
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postNickName, .postLogin, .postLogout, .postNewUser, .postSpeechToText: return .post
        case .deleteUser: return .delete
        case .getSpeechAnswer: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postNewUser(let email, let password1, let password2):
            return .requestParameters(parameters: ["email": email, "password1": password1, "password2": password2], encoding: JSONEncoding.default)
        case .postLogin(let email, let password): return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case .deleteUser: return .requestPlain
        case .postLogout: return .requestPlain
        case .postNickName(let character_id,let name): return .requestParameters(parameters: ["character_id":character_id, "name": name], encoding: JSONEncoding.default)
        case .postSpeechToText(let question):
            return .requestParameters(parameters: ["question": question], encoding: JSONEncoding.default)
        case .getSpeechAnswer:
            return .requestPlain
        }
    }
    
    
    var headers: [String: String]? {
        switch self {
        case .postLogout, .postNewUser(_, _, _), .deleteUser, .postLogin(_, _):
            return ["Content-type": "application/json"]
        case .postSpeechToText(_), .postNickName(_, _), .getSpeechAnswer:
            return ["Content-type": "application/json", "Authorization": "Bearer \(Auth.token.accessToken)"]
        }
    }

}



