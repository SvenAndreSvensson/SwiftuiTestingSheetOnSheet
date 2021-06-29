//
//  SecurityCard.swift
//  SwiftuiTestingSheetOnSheet
//
//  Created by Sven Svensson on 28/06/2021.
//

import SwiftUI

struct SecurityCard: View {
    let security: Security
    var body: some View {
        HStack {
            Text(security.description)
            Spacer()
            Text(security.ticker)
        }
      
    }
}

struct SecurityCard_Previews: PreviewProvider {
    static var security = Security.data[0]
    static var previews: some View {
        SecurityCard(security: security)
    }
}
