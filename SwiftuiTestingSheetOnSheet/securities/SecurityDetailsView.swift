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

    @State private var showEditor = false
    @State private var editData: Security.Data = Security.Data()
    @State private var showAlert = false
    
    var marketDescription: String {
        
        guard let _market = marketsManager.market(marketId: security.marketId) else {
            return "No market"
        }
        return _market.description
    }
    
    var body: some View {
        List {
            Section(header: Text("Security Info")) {
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
                HStack {
                    Text("market")
                    Spacer()
                    Text(marketDescription)
                }
            }
        } // List
        //.listStyle(.insetGrouped)
        
        .navigationTitle(security.description)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Edit") {
                    editData = security.data
                    showEditor = true
                    
                }
            }
        }
        .fullScreenCover(isPresented: $showEditor) {
            NavigationView {
                SecurityEditView(securityData: $editData)
                    .id(UUID())
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
                                showEditor = false
                            }.disabled(editData.name.isEmpty || editData.nickname.isEmpty)
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
