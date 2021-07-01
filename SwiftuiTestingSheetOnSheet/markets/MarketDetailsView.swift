//
//  MarketDetailsView.swift
//  SwiftuiTestingSheetOnSheet
//
//  Created by Sven Svensson on 29/06/2021.
//

import SwiftUI

struct MarketDetailsView: View {
    @Binding var market: Market
    
    @EnvironmentObject var manager: MarketsManager
    @State private var editData: Market.Data = Market.Data()
    @State private var showEditor = false
    @State private var showAlert = false
    
    var body: some View {
        List {
            Section(header: Text("Market Info")) {
                
                HStack{
                    Text("Name")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(market.name)
                }
                HStack {
                    Text("Nickname")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(market.nickname)
                }
                HStack {
                    Text("mic")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(market.mic)
                }
                
            }
        } // List
        .listStyle(.insetGrouped)
        .navigationTitle(market.description)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Edit") {
                    editData = market.data
                    showEditor = true
                }
            }
        }
        .fullScreenCover(isPresented: $showEditor) {
            NavigationView {
                MarketEditView(marketData: $editData)
                    .navigationTitle(editData.description)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                editData = market.data
                                showEditor = false
                            }
                        }
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button("Done") {
                                market.update(from: editData)
                                showEditor = false
                            }.disabled(editData.name.isEmpty)
                        }
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button("Delete \(market.nickname)") {
                                showAlert = true
                            }
                            .foregroundColor(.red)
                            .alert(isPresented: $showAlert, content: {
                                Alert(
                                    title: Text("Are you sure you want to delete \(market.description)"),
                                    message: Text("There is no undo"),
                                    primaryButton: .destructive(Text("Remove")) {
                                    
                                    manager.remove(market)
                                    showEditor = false
                                    },
                                    secondaryButton: .cancel()
                                )
                            })
                        }
                    }
            }
        }
    }
}

struct MarketDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        MarketDetailsView(market: .constant(Market.data[0]))
        }
    }
}
