

import Foundation

public class JSONArchiveCache:ArchiveCacheService {
    var fileName:String
    private var filePath:URL?
    init() {
        fileName = "temp"
        filePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName);
    }
    
    init(file:String) {
        fileName = file
        filePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName);
    }
    
    func save<OBJ:Codable>(object:OBJ) throws{
        guard let url = self.filePath?.path else{
            throw(ArchiveError.archiveFileIssue)
        }
        let jsonData = try JSONEncoder().encode(object)
        let archiveSuccess = NSKeyedArchiver.archiveRootObject(jsonData, toFile: url)
        if !archiveSuccess {
            throw(ArchiveError.archiveFailed)
        }
    }
    
    func retrive<OBJ:Codable>(objectType:OBJ.Type) throws -> OBJ{
        guard let url = self.filePath?.path else{
            throw(ArchiveError.archiveFileIssue)
        }
       let readData = NSKeyedUnarchiver.unarchiveObject(withFile: url) as? Data
        guard let data = readData else{
            throw(ArchiveError.archiveFileReadIssue)
        }
        let decodeObj = try JSONDecoder().decode(objectType, from: data) as OBJ
        return(decodeObj)
    }
}
