//
//  SeriesList.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 07/02/2025.
//


struct SeriesList: Decodable {
    let available: Int
    let items: [SeriesSummary]
}

struct SeriesSummary: Decodable {
    let name: String
    let resourceURI: String
}
