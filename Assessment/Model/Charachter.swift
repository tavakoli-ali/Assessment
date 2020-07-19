
import Foundation


// MARK: - Result
class ResultCharachter: Codable {
    let id: Int
    let name, resultDescription: String
   // let modified: Date
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics, series: Comics
    let stories: Stories
    let events: Comics
    let urls: [URLElement]

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case  thumbnail, resourceURI, comics, series, stories, events, urls
    }

    init(id: Int, name: String, resultDescription: String, modified: Date, thumbnail: Thumbnail, resourceURI: String, comics: Comics, series: Comics, stories: Stories, events: Comics, urls: [URLElement]) {
        self.id = id
        self.name = name
        self.resultDescription = resultDescription
      //  self.modified = modified
        self.thumbnail = thumbnail
        self.resourceURI = resourceURI
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
        self.urls = urls
    }
  func convertDBObject() -> Data? {
    let dictionary: [[String: Any]] = [[
      "imageUrl": thumbnail.path + thumbnail.thumbnailExtension,
        "name": name,
        "id": id]]
 guard  let theJSONData = try? JSONSerialization.data(
        withJSONObject: dictionary,
        options: []) else {return nil}
    return theJSONData
    }
}

// MARK: - Comics
class Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int

    init(available: Int, collectionURI: String, items: [ComicsItem], returned: Int) {
        self.available = available
        self.collectionURI = collectionURI
        self.items = items
        self.returned = returned
    }
}

// MARK: - ComicsItem
class ComicsItem: Codable {
    let resourceURI: String
    let name: String

    init(resourceURI: String, name: String) {
        self.resourceURI = resourceURI
        self.name = name
    }
}

// MARK: - Stories
class Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int

    init(available: Int, collectionURI: String, items: [StoriesItem], returned: Int) {
        self.available = available
        self.collectionURI = collectionURI
        self.items = items
        self.returned = returned
    }
}

// MARK: - StoriesItem
class StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: String

    init(resourceURI: String, name: String, type: String) {
        self.resourceURI = resourceURI
        self.name = name
        self.type = type
    }
}



// MARK: - Thumbnail
class Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }

    init(path: String, thumbnailExtension: String) {
        self.path = path
        self.thumbnailExtension = thumbnailExtension
    }
}

// MARK: - URLElement
class URLElement: Codable {
    let type: String
    let url: String

    init(type: String, url: String) {
        self.type = type
        self.url = url
    }
}

