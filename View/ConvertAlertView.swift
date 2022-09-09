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
                Text("To \(viewModel.dataSource?.to ?? "___")")
            }
            HStack(spacing: 150){
                Text("Date\n\(viewModel.dataSource?.date ?? "____-__-__")")
                Text("Rate\n\(viewModel.dataSource?.rate ?? "__")")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 300.0)
        .background(Color.gray)
        .cornerRadius(15.0)
        .padding()
    }
}

struct ConvertRowView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertAlertView(viewModel: ConvertViewModel.init(to: "USD", convertFetcher: ConvertFetcher.init()))
    }
}
