

import Foundation

public enum ArchiveError: String, Error{
    case archiveFailed = "Save Failed"
    case archiveFileIssue = "File Not Found"
    case archiveFileReadIssue = "File Read Failed"
}

protocol ArchiveCacheService {
    var fileName:String{get set}
    func save<OBJ:Codable>(object:OBJ) throws
    func retrive<OBJ:Codable>(objectType:OBJ.Type) throws -> (OBJ)
}
