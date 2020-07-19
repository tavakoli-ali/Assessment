
import Foundation
import CoreData


class ResultComic: Codable {
    let id, digitalID: Int
    let title: String?
    let issueNumber: Double?
    let variantDescription: String?
    let resultDescription: String?
    let modified, isbn, upc, diamondCode: String?
    let ean, issn: String?
    let format: String?
    let pageCount: Int?
    let textObjects: [TextObject]?
    let resourceURI: String?
    let urls: [URLElement]?
    let series: Series?
    let variants: [Series]?
    let collections, collectedIssues: [JSONAny]?
    let dates: [DateElement]?
    let prices: [Price]?
    let thumbnail: Thumbnail?
    let images: [Thumbnail]?
    let creators: Creators?
    let characters: Characters?
    let stories: Stories?
    let events: Characters?

    enum CodingKeys: String, CodingKey {
        case id
        case digitalID = "digitalId"
        case title, issueNumber, variantDescription
        case resultDescription = "description"
        case modified, isbn, upc, diamondCode, ean, issn, format, pageCount,textObjects,resourceURI,urls,series,variants,collections,collectedIssues,dates,prices,thumbnail,images,creators,characters,stories,events
    }

    init(id: Int, digitalID: Int, title: String, issueNumber: Double, variantDescription: String, resultDescription: String?, modified: String, isbn: String, upc: String, diamondCode: String, ean: String, issn: String, format: String, pageCount: Int, textObjects: [TextObject], resourceURI: String, urls: [URLElement], series: Series, variants: [Series], collections: [JSONAny], collectedIssues: [JSONAny], dates: [DateElement], prices: [Price], thumbnail: Thumbnail, images: [Thumbnail], creators: Creators, characters: Characters, stories: Stories, events: Characters) {
        self.id = id
        self.digitalID = digitalID
        self.title = title
        self.issueNumber = issueNumber
        self.variantDescription = variantDescription
        self.resultDescription = resultDescription
        self.modified = modified
        self.isbn = isbn
        self.upc = upc
        self.diamondCode = diamondCode
        self.ean = ean
        self.issn = issn
        self.format = format
        self.pageCount = pageCount
        self.textObjects = textObjects
        self.resourceURI = resourceURI
        self.urls = urls
        self.series = series
        self.variants = variants
        self.collections = collections
        self.collectedIssues = collectedIssues
        self.dates = dates
        self.prices = prices
        self.thumbnail = thumbnail
        self.images = images
        self.creators = creators
        self.characters = characters
        self.stories = stories
        self.events = events
    }
}


// MARK: - Characters
class Characters: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Series]?
    let returned: Int?

    init(available: Int, collectionURI: String, items: [Series], returned: Int) {
        self.available = available
        self.collectionURI = collectionURI
        self.items = items
        self.returned = returned
    }
}

// MARK: - Series
class Series: Codable {
    let resourceURI: String?
    let name: String?

    init(resourceURI: String, name: String) {
        self.resourceURI = resourceURI
        self.name = name
    }
}

// MARK: - Creators
class Creators: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [CreatorsItem]?
    let returned: Int?

    init(available: Int, collectionURI: String, items: [CreatorsItem], returned: Int) {
        self.available = available
        self.collectionURI = collectionURI
        self.items = items
        self.returned = returned
    }
}

// MARK: - CreatorsItem
class CreatorsItem: Codable {
    let resourceURI: String?
    let name: String?
    let role: String?

    init(resourceURI: String, name: String, role: String) {
        self.resourceURI = resourceURI
        self.name = name
        self.role = role
    }
}



// MARK: - DateElement
class DateElement: Codable {
    let type: String?
    let date: String?

    init(type: String, date: String) {
        self.type = type
        self.date = date
    }
}
// MARK: - Price
class Price: Codable {
    let type: String
    let price: Double

    init(type: String, price: Double) {
        self.type = type
        self.price = price
    }
}

// MARK: - TextObject
class TextObject:  Codable {
     var type: String
     var language: String
     var text: String

    init(type: String, language: String, text: String) {
        self.type = type
        self.language = language
        self.text = text
    }
}

