//
//  StoryList.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 07/02/2025.
//


struct StoryList: Decodable {
    let available: Int
    let items: [StorySummary]
}

struct StorySummary: Decodable {
    let name: String
    let resourceURI: String
    let type: String
}
