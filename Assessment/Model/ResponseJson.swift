
import Foundation

// MARK: - Welcome

class ResponseJson<T: Decodable>: Decodable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data : DataClass<T>

    init(code: Int, status: String, copyright: String, attributionText: String, attributionHTML: String, etag: String, data: DataClass<T>) {
        self.code = code
        self.status = status
        self.copyright = copyright
        self.attributionText = attributionText
        self.attributionHTML = attributionHTML
        self.etag = etag
        self.data = data
    }
}

// MARK: - DataClass
class DataClass<T: Decodable>: Decodable {
    let offset, limit, total, count: Int
    let results: [T]

    init(offset: Int, limit: Int, total: Int, count: Int, results: [T]) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }

}
