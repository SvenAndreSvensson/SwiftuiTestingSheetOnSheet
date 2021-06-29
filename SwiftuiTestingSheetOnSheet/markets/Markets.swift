//
//  Markets.swift
//  SwiftuiTestingSheetOnSheet
//
//  Created by Sven Svensson on 28/06/2021.
//

import Foundation

class MarketsManager: ObservableObject {

    @Published var markets: [Market] = Market.data
     
    func market(marketId: UUID?) -> Market? {
        if marketId == nil { return nil }
        return markets.first { $0.id == marketId }
    }
}

struct Market: Identifiable, Codable, Equatable, Hashable {
    var id: UUID
    var description: String { return nickname.isEmpty ? (name.isEmpty ? "No name" : name) : nickname  }
    
    var name: String
    var nickname: String
    var mic: String
    
    static var data: [Market] {
        [
            Market(id: UUID(uuidString: "3C29966C-8233-4DC6-8DDA-A1C1826CB20A")!, name: "Oslo Børs ASA", nickname: "Oslo Børs", mic: "XOSL"),
            Market(id: UUID(uuidString: "970D6B04-6EA2-44C1-8AF9-73E19F3E6121")!, name: "New York Stock Exchange", nickname: "NYSE", mic: "XNYS")
        ]
    }
}

extension Market {
    struct Data {
        var description: String  { return nickname.isEmpty ? (name.isEmpty ? "No name" : name) : nickname  }
        
        var name: String = ""
        var nickname: String = ""
        var mic: String = ""
    }
    
    var data: Data {
        return Data(name: name, nickname: nickname, mic: mic)
    }

    mutating func update(from data: Data){
        self.name = data.name
        self.nickname = data.nickname
        self.mic = data.mic
    }
}
