import SwiftUI
import Combine

class ConvertViewModel: ObservableObject {
  @Published var dataSource: ConvertAlertViewModel?

  var to: String
  private let convertFetcher: ConvertFetchable
  private var disposables = Set<AnyCancellable>()

  init(to: String, convertFetcher: ConvertFetchable) {
    self.convertFetcher = convertFetcher
    self.to = to
  }

  func refresh() {
    convertFetcher
      .ConvertFromEurTo(forTo: to)
      .map(ConvertAlertViewModel.init)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] value in
        guard let self = self else { return }
        switch value {
        case .failure:
          self.dataSource = nil
        case .finished:
          break
        }
      }, receiveValue: { [weak self] rates in
          guard let self = self else { return }
          self.dataSource = rates
      })
      .store(in: &disposables)
  }
}
