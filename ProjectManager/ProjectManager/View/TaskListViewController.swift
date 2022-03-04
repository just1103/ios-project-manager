import UIKit

class TaskListViewController: UIViewController {
//    let taskManager = TaskManager() // MVVM에서는 View가 ViewModel을 가짐
    let listViewModel = TaskListViewModel()
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViews()
    }
    
    func setupTableViews() {
        todoTableView.dataSource = self
//        todoTableView.delegate = self
        let nib = UINib(nibName: TaskTableViewCell.reuseIdentifier, bundle: nil)
        todoTableView.register(nib, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
    }
}

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: TaskTableViewCell.self, for: indexPath)
        
        cell.titleLabel.text = "123"
        cell.bodyLabel.text = "123"
        cell.dateLabel.text = "123123"
        
        return cell
    }
}

//extension TaskListViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//}
