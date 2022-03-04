import Foundation

extension TimeInterval {
    func toDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = .autoupdatingCurrent
        
        let date = Date(timeIntervalSince1970: self)
        let text = dateFormatter.string(from: date)
        return text
    }
}
