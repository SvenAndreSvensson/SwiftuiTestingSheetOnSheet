//
//  MaketCard.swift
//  SwiftuiTestingSheetOnSheet
//
//  Created by Sven Svensson on 29/06/2021.
//

import SwiftUI

struct MarketCard: View {
    let market: Market
    var body: some View {
        HStack{
            Text(market.description)
            Spacer()
            Text(market.mic)
        }
        
    }
}

struct MarketCard_Previews: PreviewProvider {
    static var market = Market.data[0]
    static var previews: some View {
        MarketCard(market: market)
    }
}

