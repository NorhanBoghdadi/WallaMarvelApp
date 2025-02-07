//
//  EventList.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 07/02/2025.
//


struct EventList: Decodable {
    let available: Int
    let items: [EventSummary]
}

struct EventSummary: Decodable {
    let name: String
    let resourceURI: String
}
