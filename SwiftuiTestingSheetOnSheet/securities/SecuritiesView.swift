//
//  SecuritiesView.swift
//  SwiftuiTestingSheetOnSheet
//
//  Created by Sven Svensson on 28/06/2021.
//

import SwiftUI

struct SecuritiesView: View {
    @EnvironmentObject var manager: SecuritiesManager
    
    @State private var showEditor = false
    @State private var newData = Security.Data()
    
    func onDismiss() -> Void {
        print("on dismiss, Create new Security from SecuritiesView")
    }
    
    var body: some View {
        
        NavigationView{
            
            List{
                Section{
                    ForEach($manager.securities) { $security in
                        NavigationLink(destination: SecurityDetailsView(security: $security)) {
                            SecurityCard(security: security)
                        }
                    }
                    .onDelete { indexSet in
                        manager.securities.remove(atOffsets: indexSet)
                    }
                }
            } // List
            .navigationTitle("Securities")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: { showEditor = true }) {
                        Image(systemName: "plus")
                    }
                }
            } // toolbar
            .sheet(isPresented: $showEditor, onDismiss: onDismiss, content: {
                NavigationView {
                    SecurityEditView(securityData: $newData)
                        .navigationTitle(newData.description)
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Dismiss") {
                                    showEditor = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Add") {
                                    
                                    let newSecurity = Security(
                                        id: UUID(),
                                        name: newData.name,
                                        nickname: newData.nickname,
                                        ticker: newData.ticker,
                                        marketId: newData.marketId)
                                    
                                    manager.securities.append(newSecurity)
                                    
                                    // clear it for new security
                                    newData = Security.Data()
                                    showEditor = false
                                }
                                .disabled(newData.name.isEmpty || newData.nickname.isEmpty)
                            }
                        } // toolbar
                }
            })
        }
        .navigationViewStyle(.stack)
      
    } // body
}

struct SecuritiesView_Previews: PreviewProvider {
    static var previews: some View {
        SecuritiesView()
            .environmentObject(SecuritiesManager())
        
    }
}
