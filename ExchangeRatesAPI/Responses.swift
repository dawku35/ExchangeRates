//
//  ApiModels.swift
//  exchange_rates
//
//  Created by Dawid Kunz on 02/09/2022.
//

import Foundation

// MARK: - Convert
struct ConvertResponse: Codable {
    var success: Bool
    var query: Query
    var info: Info
    var date: String
    var result: Double
}

// MARK: - Info
struct Info: Codable {
    var timestamp: Int
    var rate: Double
}

// MARK: - Query
struct Query: Codable {
    var from, to: String
    var amount: Int
}
