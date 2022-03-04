import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var task: Task = Task(title: "", body: "", dueDate: 0)
    
    var title: String {
        return task.title
    }
    
    var body: String {
        return task.body
    }

    var date: String {
        let timeInterval = task.dueDate
        return timeInterval.toDateString()
    }
    
//    init() {
//        applyData(<#T##task: Task##Task#>)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func applyData(_ task: Task) {
        self.task = task
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
            self.dateLabel.textColor = .black
    }
}
