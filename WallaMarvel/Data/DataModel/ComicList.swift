//
//  ComicList.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 07/02/2025.
//


struct ComicList: Codable {
    let available: Int
    let items: [ComicSummary]

    init(available: Int = 0, items: [ComicSummary]) {
        self.available = available
        self.items = items
    }
}

struct ComicSummary: Codable {
    let resourceURI: String
    let name: String

    init(resourceURI: String = "", name: String) {
        self.resourceURI = resourceURI
        self.name = name
    }
}
