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
            switch viewModel.state {
                case .succes:
                        VStack(spacing: 20){
                            TitleText(text: "Exchange Rates")
                            MenuList(choose: $choose, alertIsVisible: $alertIsVisible, viewModel: viewModel)
                            if(alertIsVisible){
                                LatestView(viewmodel: viewModel)
                            }
                            
                            Spacer()
                        }
                case .loading:
                    ProgressView()
                default:
                    EmptyView()
            }
        }
        .task {
            await viewModel.getConvert()
        }
        .alert("Error", isPresented: $viewModel.hasError
               ,presenting: viewModel.state) { detail in
            
            Button("Retry") {
                Task {
                    await viewModel.getConvert()
                }
            }
        } message: { detail in
            if case let .failed(error) = detail {
                
                Text(error.localizedDescription)
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
                actionButton(base: "PLN")
            } label: {
                Text("PLN")
            }
            Button {
                actionButton(base: "GBP")
            } label: {
                Text("GBP")
            }
            Button {
                actionButton(base: "USD")
            } label: {
                Text("USD")
            }
            Button {
                actionButton(base: "JPY")
            } label: {
                Text("JPY")
            }
            Button {
                actionButton(base: "AED")
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
    
    func actionButton(base: String){
        withAnimation(){
            viewModel.base = base
            Task {
                await viewModel.getConvert()
            }
            choose = base
            alertIsVisible = true
        }
    }
}

struct ConvertViewModel_Previews: PreviewProvider {
    static private var viewModel = ConvertViewModel.init(base: "USD", convertComponents: ConvertComponentsImpl.init())
    static var previews: some View {
        ConvertView(viewModel: viewModel)
    }
}
