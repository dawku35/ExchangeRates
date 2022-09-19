import Foundation
import SwiftUI
import MapKit

struct ConvertAlertViewModel {
  var item: Latest
  
    var rate: [String: Double] {
      return item.rates
  }
  
  var date: String {
      return String(item.date)
  }
  
  init(item: Latest) {
    self.item = item
  }
}
