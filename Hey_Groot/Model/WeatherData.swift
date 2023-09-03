//
//  WeatherData.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/08/27.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
