import SwiftUI
import Combine

@MainActor
class ConvertViewModel: ObservableObject, Identifiable {
    @Published var dataSource: ConvertAlertViewModel?
    var base: String
    private let convertComponents: ConvertComponents
    @Published private(set) var state: State = .na
    @Published var hasError: Bool = false
    
    enum State {
        case na
        case loading
        case succes
        case failed(error: Error)
    }
    
    init(base: String, convertComponents: ConvertComponents) {
        self.convertComponents = convertComponents
        self.base = base
    }
  
    func getConvert() async{
        self.state = .loading
        self.hasError = false
        
        do {
            let latest = try await convertComponents.fetchLatest(base: base)
            self.dataSource = ConvertAlertViewModel.init(item: latest)
            self.state = .succes
        } catch {
            self.state = .failed(error: error)
            self.hasError = true
        }
    }
}
