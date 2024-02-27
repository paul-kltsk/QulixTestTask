//
//  CityModel.swift
//  QulixTestTask
//
//  Created by Pavel Kylitsky on 27/02/2024.
//

import Foundation

protocol CityProtocol {
    var cityName: String { get }
    var longitude: String { get }
    var latitude: String { get }
}

struct MinskCity: CityProtocol {
    var cityName: String = "Minsk"
    var longitude: String = "27.6"
    var latitude: String = "53.9"
}
