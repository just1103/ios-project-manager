import UIKit

final class TaskTableView: UITableView {
    private(set) var processStatus: ProcessStatus?
    
    func setup(processStatus: ProcessStatus) {
        self.processStatus = processStatus
        setupCellAndHeader()
    }
    
    private func setupCellAndHeader() {
        let nib = UINib(nibName: TaskTableViewCell.reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        register(TaskTableHeaderView.self, forHeaderFooterViewReuseIdentifier: TaskTableHeaderView.reuseIdentifier)
    }
}
