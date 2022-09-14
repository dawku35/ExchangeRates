//
//  ConvertRowView.swift
//  ExchangeRates
//
//  Created by Dawid Kunz on 08/09/2022.
//

import SwiftUI

struct ConvertAlertView: View {
    @ObservedObject var viewModel: ConvertViewModel
    var body: some View {
        VStack(spacing: 80){
            HStack(spacing: 150){
                Text("from \(viewModel.dataSource?.from ?? "___")")
                    .accessibilityIdentifier("from")
                Text("To \(viewModel.dataSource?.to ?? "___")")
                    .accessibilityIdentifier("to")
            }
            HStack(spacing: 150){
                Text("Date\n\(viewModel.dataSource?.date ?? "____-__-__")")
                    .accessibilityIdentifier("date")
                Text("Rate\n\(viewModel.dataSource?.rate ?? "__")")
                    .accessibilityIdentifier("rate")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 300.0)
        .background(Color.gray)
        .cornerRadius(15.0)
        .padding()
        .accessibilityIdentifier("ConvertAlertView")
    }
}

struct ConvertRowView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertAlertView(viewModel: ConvertViewModel.init(to: "USD", convertComponents: ConvertComponentsImpl.init()))
    }
}
