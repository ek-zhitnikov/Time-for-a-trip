//
//  FlightModel.swift
//  Time for a trip
//
//  Created by Евгений Житников on 15.05.2023.
//

import Foundation

struct FlightResponse: Decodable {
    let flights: [Flight]
}

struct Flight: Decodable {
    let startDate: String
    let endDate: String
    let startLocationCode: String
    let endLocationCode: String
    let startCity: String
    let endCity: String
    let serviceClass: String
    let seats: [Seat]
    let price: Int
    let searchToken: String
}

struct Seat: Decodable {
    let passengerType: String
    let count: Int
}
