import SwiftUI
import Combine

@MainActor
class ConvertViewModel: ObservableObject {
    @Published var dataSource: ConvertAlertViewModel?
    var to: String
    private let convertComponents: ConvertComponents
    @Published private(set) var state: State = .na
    @Published var hasError: Bool = false
    
    enum State {
        case na
        case loading
        case succes
        case failed(error: Error)
    }
    
    init(to: String, convertComponents: ConvertComponents) {
        self.convertComponents = convertComponents
        self.to = to
    }
  
    func getConvert() async{
        self.state = .loading
        self.hasError = false
        
        do {
            let convert = try await convertComponents.fetchConvert(to: to)
            self.dataSource = ConvertAlertViewModel.init(item: convert)
            self.state = .succes
        } catch {
            self.state = .failed(error: error)
            self.hasError = true
        }
    }
}
