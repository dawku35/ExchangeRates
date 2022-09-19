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
        
        print(viewModel.dataSource?.rate)
    }
}

struct LatestView_Previews: PreviewProvider {
    static var previews: some View {
        LatestView(viewModel: ConvertViewModel.init(base: "USD", convertComponents: ConvertComponentsImpl.init()))
    }
}
