//
//  ComicList.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 07/02/2025.
//


struct ComicList: Decodable {
    let available: Int
    let items: [ComicSummary]
}

struct ComicSummary: Decodable {
    let name: String
    let resourceURI: String
}
