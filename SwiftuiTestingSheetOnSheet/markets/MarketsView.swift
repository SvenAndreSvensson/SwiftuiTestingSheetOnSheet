//
//  MarketsView.swift
//  SwiftuiTestingSheetOnSheet
//
//  Created by Sven Svensson on 29/06/2021.
//

import SwiftUI

struct MarketsView: View {
    @EnvironmentObject var manager: MarketsManager
    @State private var showEditor = false
    @State private var newData = Market.Data()
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    ForEach ( $manager.markets){ $market in
                        NavigationLink(destination: MarketDetailsView(market: $market)) {
                            MarketCard(market: market)
                        }.isDetailLink(true)
                    }
                    .onDelete { indexSet in
                        manager.markets.remove(atOffsets: indexSet)
                    }
                }
                
            }
            .navigationTitle("Markets")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        newData = Market.Data()
                        showEditor = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            } // toolbar
            .sheet(isPresented: $showEditor, onDismiss: {}, content: {
                
                    MarketEditView(marketData: $newData)
                        .navigationTitle(newData.description)
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Dismiss") {
                                    showEditor = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Add") {
                                    
                                    let newMarket = Market(
                                        id: UUID(),
                                        name: newData.name,
                                        nickname: newData.nickname,
                                        mic: newData.mic)
                                    
                                    manager.markets.append(newMarket)
                                    
                                    // clear it for new Broker
                                    newData = Market.Data()
                                    showEditor = false
                                }
                                .disabled(newData.name.isEmpty)
                            }
                        } // toolbar
            }) // sheet
        }
        .navigationViewStyle(.stack)
    } // body
}

struct MarketsView_Previews: PreviewProvider {
    static var previews: some View {
        MarketsView()
    }
}
