//
//  MarketsSelectionView.swift
//  SwiftuiTestingSheetOnSheet
//
//  Created by Sven Svensson on 28/06/2021.
//

import SwiftUI

struct MarketsSelectionView: View {
    @Binding var selection: Market?
    @EnvironmentObject var manager: MarketsManager
    
    @State private var newData = Market.Data()
    @State private var showEditor: Bool = false
   
    func onDismiss() -> Void {
        print("on dismiss, Create new market from MarketSelectionView")
    }
    
    var body: some View {
        
        List(manager.markets, id: \.self, selection: $selection) { market in
            Text(market.description)
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showEditor = true }) {
                    Image(systemName: "plus")
                }
            }
        })
        .sheet(isPresented: $showEditor, onDismiss: onDismiss) {
       
            NavigationView{
                MarketEditView(marketData: $newData)
                    .navigationTitle(Text(newData.description))
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
                            
                                showEditor = false
                            }
                            .disabled(newData.name.isEmpty || newData.nickname.isEmpty)
                        }
                    } // toolbar
            }
        } // sheet
        .environment(\.editMode, .constant(EditMode.active))
    }
}

struct MarketsSelectionView_Previews: PreviewProvider {
    static var market = Market.data[0]
    static var previews: some View {
        NavigationView{
            MarketsSelectionView(selection: .constant(market ))
            .environmentObject(MarketsManager())
        }
    }
}
