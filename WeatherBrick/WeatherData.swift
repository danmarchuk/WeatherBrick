//
//  WeatherData.swift
//  WeatherBrick
//
//  Created by Данік on 22/03/2023.
//  Copyright © 2023 VAndrJ. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let sys: Sys
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable{
    let main: String
    let id: Int
}

struct Sys: Decodable {
    let country: String
}
