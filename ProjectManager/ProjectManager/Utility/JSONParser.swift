import UIKit

enum JSONParserError: Error, LocalizedError {
    case fileNotFound
    case dataNotFound
    case decodingFail
    case encodingFail
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "존재하지 않는 파일입니다."
        case .dataNotFound:
            return "파일에 데이터가 존재하지 않습니다."
        case .decodingFail:
            return "디코딩에 실패했습니다."
        case .encodingFail:
            return "인코딩에 실패했습니다."
        }
    }
}

struct JSONParser<Item: Decodable> {
    func decode(bundleFileName: String, fileExtension: String) throws -> Item {
        guard let url = Bundle.main.url(forResource: bundleFileName, withExtension: fileExtension) else { // ex. forResource: "sample", withExtension: "json"
            throw JSONParserError.fileNotFound
        }
        
        guard let jsonData = try? Data(contentsOf: url) else {
            throw JSONParserError.dataNotFound
        }
        
        guard let decodedData = try? JSONDecoder().decode(Item.self, from: jsonData) else {
            throw JSONParserError.decodingFail
        }
        
        return decodedData
    }
}
