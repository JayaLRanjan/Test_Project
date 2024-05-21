//
//  Model.swift
//  Australia_Cities
//
//  Created by Jaya Lakshmi on 21/05/24.
//

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let city, lat, lng: String
    let country: Country
    let iso2: Iso2
    let adminName: AdminName
    let capital: Capital
    let population, populationProper: String

    enum CodingKeys: String, CodingKey {
        case city, lat, lng, country, iso2
        case adminName = "admin_name"
        case capital, population
        case populationProper = "population_proper"
    }
}

enum AdminName: String, Codable {
    case australianCapitalTerritory = "Australian Capital Territory"
    case newSouthWales = "New South Wales"
    case northernTerritory = "Northern Territory"
    case queensland = "Queensland"
    case southAustralia = "South Australia"
    case tasmania = "Tasmania"
    case victoria = "Victoria"
    case westernAustralia = "Western Australia"
}

enum Capital: String, Codable {
    case admin = "admin"
    case empty = ""
    case primary = "primary"
}

enum Country: String, Codable {
    case australia = "Australia"
}

enum Iso2: String, Codable {
    case au = "AU"
}

typealias Welcome = [WelcomeElement]
