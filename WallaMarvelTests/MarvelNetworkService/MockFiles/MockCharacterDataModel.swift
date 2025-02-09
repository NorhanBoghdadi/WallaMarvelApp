//
//  MockCharacterDataModel.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 09/02/2025.
//


@testable import WallaMarvel

extension CharacterDataModel {
    static func mock(id: Int = 1, name: String = "Spider-Man") -> CharacterDataModel {
        return CharacterDataModel(
            id: id,
            name: name,
            thumbnail: Thumbnail(path: "http://example.com", extension: "jpg"),
            description: "Your friendly neighborhood Spider-Man",
            comics: ComicList(available: 0, items: [ComicSummary(name: "Amazing Spider-Man #1")]),
            series: SeriesList(available: 0, items: [SeriesSummary(name: "Amazing Spider-Man")]),
            stories: StoryList(),
            events: EventList()
        )
    }
}
