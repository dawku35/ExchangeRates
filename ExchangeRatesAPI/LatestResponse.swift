import Foundation

// MARK: - Latest
struct Latest: Codable, Identifiable {
    let success: Bool
    let date, base: String
    let timestamp: Int
    let rates: [String: Double]
    
    init(){
        success = true
        date = "2021-03-17"
        base = "EUR"
        timestamp = 1519296206
        rates = ["EUR": 1.67, "PLN": 2.45, "JPY": 4.91, "USD": 2.23, "GBP": 3.12]
    }
}

