//
//  MarketEditView.swift
//  SwiftuiTestingSheetOnSheet
//
//  Created by Sven Svensson on 28/06/2021.
//

import SwiftUI

struct MarketEditView: View {
    @Binding var marketData: Market.Data
    
    var body: some View {
        
        List {
            Section(header: Text("Market Info")) {
                HStack{
                    Text("Name")
                        
                    TextField("Name", text: $marketData.name)
                        .multilineTextAlignment(.trailing)
                        .textCase(.uppercase)
                }
                HStack{
                    Text("NickName")
                    Spacer()
                    TextField("Nickname", text: $marketData.nickname)
                        .multilineTextAlignment(.trailing)
                        .textCase(.uppercase)
                }
                HStack{
                    Text("mic")
                    Spacer()
                    TextField("mic", text: $marketData.mic)
                        .multilineTextAlignment(.trailing)
                        .autocapitalization(.allCharacters)
                }
                
            } // Section
        } // List
    }
}

struct MarketEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        MarketEditView(marketData:.constant(Market.data[0].data))
        }
    }
}


