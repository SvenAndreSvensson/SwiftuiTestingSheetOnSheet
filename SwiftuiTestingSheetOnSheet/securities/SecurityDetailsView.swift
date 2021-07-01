//
//  SecurityDetailsView.swift
//  SwiftuiTestingSheetOnSheet
//
//  Created by Sven Svensson on 28/06/2021.
//

import SwiftUI

struct SecurityDetailsView: View {
    @Binding var security: Security
    
    @EnvironmentObject var manager: SecuritiesManager
    @EnvironmentObject var marketsManager: MarketsManager
    
    // current market
    @State var market: Market = Market.zero
    
    // changing security
    @State private var showEditor = false
    @State private var editData: Security.Data = Security.Data()
    
    // Alert when deleting security
    @State private var showAlert = false
    
    var marketDescription: String {
        
        guard let _market = marketsManager.market(marketId: security.marketId) else {
            return "No market"
        }
        return _market.description
    }
    
    var body: some View {
        List {
            Section(header: Text("Security Details")) {
                HStack{
                    Text("Name")
                    Spacer()
                    Text(security.name)
                }
                HStack {
                    Text("Nickname")
                    Spacer()
                    Text(security.nickname)
                }
                HStack {
                    Text("ticker")
                    Spacer()
                    Text(security.ticker)
                }
                NavigationLink(destination: MarketDetailsView(market: $market)) {
                    HStack {
                        Text("market")
                        Spacer()
                        Text(market.description)
                    }
                }
            }
        } // List
        //.listStyle(.insetGrouped)
        .navigationTitle(security.description)
        .onAppear(perform: {
            print("SecurityDetailsView, onAppear")
            market = marketsManager.market(marketId: security.marketId) ?? Market.zero
        })
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Edit") {
                    print("SecurityDetailsView, toolbar edit")
                    editData = security.data
                    showEditor = true
                }
            }
        }
        .fullScreenCover(isPresented: $showEditor) {
            NavigationView {
                SecurityEditView(securityData: $editData)
                    .navigationTitle(editData.description)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                showEditor = false
                            }
                        }
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button("Done") {
                                security.update(from: editData)
                                market = marketsManager.market(marketId: security.marketId) ?? Market.zero
                                showEditor = false
                            }.disabled(editData.name.isEmpty)
                        }
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button("Delete \(security.nickname)") {
                                showAlert = true
                            }
                            .foregroundColor(.red)
                            .alert(isPresented: $showAlert, content: {
                                Alert(
                                    title: Text("Are you sure you want to delete \(security.description)"),
                                    message: Text("There is no undo"),
                                    primaryButton: .destructive(Text("Remove")) {
                                    
                                    manager.remove(security)
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

struct SecurityDetailsView_Previews: PreviewProvider {
    static var security = Security.data[0]
    static var previews: some View {
        NavigationView{
            SecurityDetailsView(security: .constant(security))
                .environmentObject(SecuritiesManager())
                .environmentObject(MarketsManager())
        }
    }
}
