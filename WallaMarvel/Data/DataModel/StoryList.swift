//
//  StoryList.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 07/02/2025.
//


struct StoryList: Codable {
    let available: Int
    let items: [StorySummary]

    init(available: Int = 0, items: [StorySummary] = []) {
        self.available = available
        self.items = items
    }
}

struct StorySummary: Codable {
    let resourceURI: String
    let name: String
    let type: String

    init(resourceURI: String = "", name: String = "", type: String = "") {
        self.resourceURI = resourceURI
        self.name = name
        self.type = type
    }
}
