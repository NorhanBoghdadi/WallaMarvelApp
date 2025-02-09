//
//  EventList.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 07/02/2025.
//


struct EventList: Codable {
    let available: Int
    let items: [EventSummary]

    init(available: Int = 0, items: [EventSummary] = []) {
        self.available = available
        self.items = items
    }
}

struct EventSummary: Codable {
    let resourceURI: String
    let name: String

    init(resourceURI: String = "", name: String = "") {
        self.resourceURI = resourceURI
        self.name = name
    }
}
