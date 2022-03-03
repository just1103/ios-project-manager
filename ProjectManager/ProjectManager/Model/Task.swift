import Foundation

struct Task {
    let id: UUID
    var title: String
    var body: String?
    var date: TimeInterval
    var processStatus: ProcessStatus
}

// JSON 파일
//[
//    {
//    "title": "title1",
//    "body": "body1",
//    "date": 1608651333,
//    "processStatus": "TODO",
//    },
//    {
//
//    },
//    {
//
//    }
//]
