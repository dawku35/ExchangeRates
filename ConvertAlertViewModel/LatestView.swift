//
//  LatestViewModel.swift
//  ExchangeRates
//
//  Created by Dawid Kunz on 19/09/2022.
//

import SwiftUI

struct LatestView: View {
    @ObservedObject var viewModel: ConvertViewModel
    var body: some View {
        VStack{
            ForEach(Array((viewModel.dataSource?.rate.keys.enumerated())!), id: \.offset){ offset, symbol in
                RowView(date: viewModel.dataSource?.date, currency: symbol, rate: viewModel.dataSource?.rate[symbol])
            }
        }
    }
}

struct RowView: View{
    @Binding var date: String
    @Binding var currency: String
    @Binding var rate: String
    var body: some View{
        HStack{
            Text("Date: \(date)")
                .font(.title)
                .foregroundColor(.gray)
            Spacer()
            Text("Currency: \(currency)")
                .font(.title)
                .foregroundColor(.gray)
            Spacer()
            Text("Rate: \(rate)")
                .font(.title)
                .foregroundColor(.gray)
        }
        .frame(width: 20, height: 40)
        .foregroundColor(.indigo)
    }
}

struct LatestView_Previews: PreviewProvider {
    static var previews: some View {
        LatestView(viewModel: ConvertViewModel.init(base: "USD", convertComponents: ConvertComponentsImpl.init()))
    }
}
