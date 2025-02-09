import Foundation

struct CharacterDataModel: Decodable {
    let id: Int
    let name: String
    let thumbnail: Thumbnail
    let description: String
    let comics: ComicList
    let series: SeriesList
    let stories: StoryList
    let events: EventList
    init(
        id: Int,
        name: String,
        thumbnail: Thumbnail,
        description: String,
        comics: ComicList,
        series: SeriesList,
        stories: StoryList,
        events: EventList
    ) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
    }
}
