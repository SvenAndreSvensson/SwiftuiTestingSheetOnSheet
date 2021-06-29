//
//  SwiftuiTestingSheetOnSheetApp.swift
//  SwiftuiTestingSheetOnSheet
//
//  Created by Sven Svensson on 28/06/2021.
//

import SwiftUI

@main
struct SwiftuiTestingSheetOnSheetApp: App {
    
    @StateObject var marketManager = MarketsManager()
    @StateObject var securitiesManager = SecuritiesManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(marketManager)
                .environmentObject(securitiesManager)
        }
    }
}
