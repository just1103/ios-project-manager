import Foundation

class Task: Codable {
    let id: UUID
    var title: String
    var body: String
    var dueDate: TimeInterval
    var processStatus: ProcessStatus
    
    init(title: String, body: String, dueDate: TimeInterval) {
        self.id = UUID()
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.processStatus = .todo
    }
}
