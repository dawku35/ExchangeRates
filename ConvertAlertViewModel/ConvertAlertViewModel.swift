import Foundation
import SwiftUI
import MapKit

struct ConvertAlertViewModel {
  var item: ConvertResponse
  
  var rate: String {
      return String(format: "%.3f", item.info.rate)
  }
  
  var date: String {
      return String(item.date)
  }
  
  var from: String {
      return String(item.query.from)
  }
  
  var to: String {
      return String(item.query.to)
  }
  
  init(item: ConvertResponse) {
    self.item = item
  }
}
