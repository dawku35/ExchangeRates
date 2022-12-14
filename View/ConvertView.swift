//
//  ConvertViewModel.swift
//  ExchangeRates
//
//  Created by Dawid Kunz on 06/09/2022.
//

import SwiftUI

struct ConvertView: View {
    @State var choose: String = "Choose"
    @ObservedObject var viewModel: ConvertViewModel
    @State var alertIsVisible: Bool = false
    
    init(viewModel: ConvertViewModel){
        self.viewModel = viewModel
    }
    var body: some View {
        ZStack{
            Color.yellow
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20){
                TitleText(text: "Exchange Rates")
                MenuList(choose: $choose, alertIsVisible: $alertIsVisible, viewModel: viewModel)
                if(alertIsVisible){
                    ConvertAlertView(viewModel: viewModel)
                }
                Spacer()
            }
        }
        
    }
}

struct TitleText: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .foregroundColor(.mint)
            .frame(maxWidth: .infinity, maxHeight: 180)
            .background(Color.orange)
            .cornerRadius(15.0)
            .edgesIgnoringSafeArea(.all)
    }
}

struct MenuList: View {
    @Binding var choose: String
    @Binding var alertIsVisible: Bool
    @ObservedObject var viewModel: ConvertViewModel
    var body: some View {
        Menu{
            Button {
                actionButton(to: "PLN")
            } label: {
                Text("PLN")
            }
            Button {
                actionButton(to: "GBP")
            } label: {
                Text("GBP")
            }
            Button {
                actionButton(to: "USD")
            } label: {
                Text("USD")
            }
            Button {
                actionButton(to: "JPY")
            } label: {
                Text("JPY")
            }
            Button {
                actionButton(to: "AED")
            } label: {
                Text("AED")
            }
        } label: {
            Text(choose)
        }.frame(width: 100, height: 50)
            .background(Color.green)
            .cornerRadius(15.0)
            .font(.title2)
        
    }
    
    func actionButton(to: String){
        withAnimation(){
            viewModel.to = to
            viewModel.refresh()
            choose = to
            alertIsVisible = true
        }
    }
}

struct ConvertViewModel_Previews: PreviewProvider {
    static private var viewModel = ConvertViewModel.init(to: "USD", convertFetcher: ConvertFetcher.init())
    static var previews: some View {
        ConvertView(viewModel: viewModel)
    }
}
