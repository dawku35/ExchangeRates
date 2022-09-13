//
//  ExchangeRatesApp.swift
//  ExchangeRates
//
//  Created by Dawid Kunz on 06/09/2022.
//

import SwiftUI

@main
struct ExchangeRatesApp: App {
    var body: some Scene {
        let viewModel = ConvertViewModel.init(to: "USD", convertComponents: ConvertComponentsImpl.init())
        WindowGroup {
            ConvertView(viewModel: viewModel)
        }
    }
}
