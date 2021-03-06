//
//  SecurityEditView.swift
//  SwiftuiTestingSheetOnSheet
//
//  Created by Sven Svensson on 28/06/2021.
//

import SwiftUI

struct SecurityEditView: View {

    @Binding var securityData: Security.Data
   
    // find market with same id as security marketId
    @State private var market: Market?
    
    // for market selection
    @EnvironmentObject var marketsManager: MarketsManager
    @State private var showMarketSelectionView = false
    
    var body: some View {
        
            List {
                Section(header: Text("Security Info")) {
                    HStack{
                        Text("Name")
                        
                        TextField("Name", text: $securityData.name)
                            .multilineTextAlignment(.trailing)
                            .textCase(.uppercase)
                    }
                    HStack{
                        Text("NickName")
                        Spacer()
                        TextField("Nickname", text: $securityData.nickname)
                            .multilineTextAlignment(.trailing)
                            .textCase(.uppercase)
                    }
                    HStack{
                        Text("Ticker")
                        Spacer()
                        TextField("Ticker", text: $securityData.ticker)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.allCharacters)
                    }
                    
                    NavigationLink( destination: MarketsSelectionView(marketId: $securityData.marketId) ) {
                        HStack{
                            Text("Market")
                            Spacer()
                            Text(market?.description ?? "No market")
                        }
                    }.isDetailLink(false)
                    
                } // Section
            } // List
            .onAppear(perform: {
                market = marketsManager.market(marketId: securityData.marketId)
            })
    }
}

struct SecurityEditView_Previews: PreviewProvider {
    static var securityData = Security.data[0].data
    static var previews: some View {
        NavigationView{
            SecurityEditView(securityData: .constant(securityData))
                .environmentObject(MarketsManager())
        }
    }
}
