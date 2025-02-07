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
}
