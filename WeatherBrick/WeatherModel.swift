//
//  WeatherModel.swift
//  WeatherBrick
//
//  Created by Данік on 24/03/2023.
//  Copyright © 2023 VAndrJ. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let country: String
    let temperature: Double
    
    let weatherName: String
    
    var tempInt: Int {
        return Int(temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...531:
            return "image_stone_wet"
        case 600...622:
            return "image_stone_snow"
        case 701...781:
            // make the stone swing
            return "image_stone_normal"
        case 800:
            // clear sky
            return "image_stone_normal"
        case 801...804:
            // cloudy
            return "image_stone_normal"
        default:
            return "image_stone_normal"
        }
    }
}
