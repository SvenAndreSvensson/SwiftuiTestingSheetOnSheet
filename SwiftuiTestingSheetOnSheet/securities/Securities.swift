//
//  Securities.swift
//  SwiftuiTestingSheetOnSheet
//
//  Created by Sven Svensson on 28/06/2021.
//

import Foundation
class SecuritiesManager: ObservableObject{

    @Published var securities: [Security] = Security.data
    
    func remove(_ security: Security){
        guard let index = securities.firstIndex(of: security) else {
            print("Can´t remove security. security not found!")
            return
        }
        securities.remove(at: index)
    }
}

struct Security: Identifiable, Codable, Equatable {
    
    var id: UUID
    var description: String { return nickname.isEmpty ? (name.isEmpty ? "No name" : name) : nickname  }
    
    var name: String
    var nickname: String
    var ticker: String
    var marketId: UUID?
    
    static var data:[Security] {
        [
            Security(id: UUID(uuidString: "84E3E80D-2A1F-41F6-8B30-0CACEDCD7956")!, name: "TESLA MOTORS INC", nickname: "TESLA", ticker: "TSLA", marketId: UUID(uuidString: "970D6B04-6EA2-44C1-8AF9-73E19F3E6121")!),
            Security(id: UUID(uuidString: "0102EFC6-9F96-41D2-9992-7D45AFBC3F59")!, name: "AMC Entertainment Holdings Inc", nickname: "AMC Entertainment", ticker: "AMC", marketId: UUID(uuidString: "970D6B04-6EA2-44C1-8AF9-73E19F3E6121")!)
        ]
    }
}

extension Security {
    struct Data {
        var description: String  { return nickname.isEmpty ? (name.isEmpty ? "No name" : name) : nickname  }
        
        var name: String = ""
        var nickname: String = ""
        var ticker: String = ""
        var marketId: UUID? = nil
    }

    var data: Data {
        return Data(name: name, nickname: nickname, ticker: ticker, marketId: marketId)
    }
    
    mutating func update(from data: Data){
        self.name = data.name
        self.nickname = data.nickname
        self.ticker = data.ticker
        self.marketId = data.marketId
    }
}
