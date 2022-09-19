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
    
    init(){
        success = true
        query = Query.init()
        info = Info.init()
        date = "13-06-2022"
        result = 56.8
    }
}

// MARK: - Info
struct Info: Codable {
    var timestamp: Int
    var rate: Double
    
    init(){
        timestamp = 6438
        rate = 345.9
    }
}

// MARK: - Query
struct Query: Codable {
    var from, to: String
    var amount: Int
    
    init(){
        from = "PLN"
        to = "USD"
        amount = 1
    }
}
