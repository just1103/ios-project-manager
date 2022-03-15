import UIKit
import RxSwift
import RxCocoa

final class TaskListViewController: UIViewController {
    // MARK: - Properties
    private var taskListViewModel: TaskListViewModelProtocol!
    private lazy var tableViews = [todoTableView, doingTableView, doneTableView]
    private var disposeBag = DisposeBag()
    
    @IBOutlet private weak var todoTableView: TaskTableView!
    @IBOutlet private weak var doingTableView: TaskTableView!
    @IBOutlet private weak var doneTableView: TaskTableView!
    
    // MARK: - Initializers
    convenience init?(coder: NSCoder, taskListViewModel: TaskListViewModelProtocol = TaskListViewModel()) {
        self.init(coder: coder)
        self.taskListViewModel = taskListViewModel
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViews()
        setupHeaderViews()
        setupBindings()
    }
        
    private func setupTableViews() {
        tableViews.forEach { tableView in
            tableView?.setupTableViewCell()
            tableView?.delegate = self
        }
        
        todoTableView.processStatus = .todo
        doingTableView.processStatus = .doing
        doneTableView.processStatus = .done
    }
    
    private func setupHeaderViews() {
        // 이런 형태의 의존성 주입 괜찮나?
        let todoTaskHeaderView = TaskTableHeaderView(reuseIdentifier: TaskTableHeaderView.reuseIdentifier,
                                                     taskCountObservable: taskListViewModel.todoTasksCount,
                                                     processStatus: .todo)
        let doingTaskHeaderView = TaskTableHeaderView(reuseIdentifier: TaskTableHeaderView.reuseIdentifier,
                                                      taskCountObservable: taskListViewModel.doingTasksCount,
                                                      processStatus: .doing)
        let doneTaskHeaderView = TaskTableHeaderView(reuseIdentifier: TaskTableHeaderView.reuseIdentifier,
                                                     taskCountObservable: taskListViewModel.doneTasksCount,
                                                     processStatus: .done)

        todoTableView.tableHeaderView = todoTaskHeaderView
        doingTableView.tableHeaderView = doingTaskHeaderView
        doneTableView.tableHeaderView = doneTaskHeaderView
    }
    
    private func setupBindings() {
        setupTableViewsBinding()
        
        // TODO: todoTableView.rx.didSelectItem 활용해보기
        // TODO: todoTableView.rx.tableHeaderView 활용해보기 - 모르겠음
    }
    
    private func setupTableViewsBinding() {
        taskListViewModel.todoTasksObservable?
            .asDriver(onErrorJustReturn: [])
            .drive(todoTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                          cellType: TaskTableViewCell.self)) { _, task, cell in
                cell.setup()
                cell.applyDate(with: task)
             }
             .disposed(by: disposeBag)
        
        taskListViewModel.doingTasksObservable?
            .asDriver(onErrorJustReturn: [])
            .drive(doingTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                          cellType: TaskTableViewCell.self)) { _, task, cell in
                cell.setup()
                cell.applyDate(with: task)
             }
             .disposed(by: disposeBag)

        taskListViewModel.doneTasksObservable?
            .asDriver(onErrorJustReturn: [])
            .drive(doneTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                          cellType: TaskTableViewCell.self)) { _, task, cell in
                cell.setup()
                cell.applyDate(with: task)
             }
             .disposed(by: disposeBag)
    }
}

// MARK: - IBAction
extension TaskListViewController {
    @IBAction private func touchUpAddButton(_ sender: UIBarButtonItem) {
        let taskDetailController = ViewControllerFactory.createViewController(of: .newTaskDetail(viewModel: self.taskListViewModel))
        taskDetailController.modalPresentationStyle = .popover
        
        self.present(UINavigationController(rootViewController: taskDetailController), animated: true)
    }
}

// MARK: - TableView Delegate
//extension TaskListViewController: UITableViewDelegate { // 쓸 수 있는건가?
////     TODO: Cell을 탭하면 Popover 표시
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // editTaskDetail 띄우기
//        self.tableView.rx.modelSelected(Task.self)
//        .subscribe(onNext: { item in
//           Observable.just(Reactor.Action.moveToDetail(item))
//                     .bind(to: self.reactor!.action)
//                     .disposed(by: self.disposeBag)
//        }).disposed(by: self.disposeBag)
//        
//        
//        
//        guard let tableView = tableView as? TaskTableView else {
//            print(TableViewError.invalidTableView.description)
//            return
//        }
//        
//        
//        tableView.rx.itemSelected
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: presentEditView(with: $0))
//            .disposed(by: disposeBag)
//    }
//    
//    func presentEditView(with indexPath: IndexPath) {
//        let taskDetailController = ViewControllerFactory.createViewController(of: .editTaskDetail(viewModel: self.taskListViewModel,
//                                                                                                  taskToEdit: tableView[indexPath]))
//        taskDetailController.modalPresentationStyle = UIModalPresentationStyle.popover
//        
//        self.present(UINavigationController(rootViewController: taskDetailController), animated: true)
//    }
//}
