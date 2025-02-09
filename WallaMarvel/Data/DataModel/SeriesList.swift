//
//  SeriesList.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 07/02/2025.
//


struct SeriesList: Codable {
    let available: Int
    let items: [SeriesSummary]

    init(available: Int = 0, items: [SeriesSummary]) {
        self.available = available
        self.items = items
    }
}

struct SeriesSummary: Codable {
    let resourceURI: String
    let name: String

    init(resourceURI: String = "", name: String) {
        self.resourceURI = resourceURI
        self.name = name
    }
}
