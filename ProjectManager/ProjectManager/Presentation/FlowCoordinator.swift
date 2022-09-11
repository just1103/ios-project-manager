import UIKit

protocol FlowCoordinatorProtocol {
    var navigationController: UINavigationController? { get set }
    
    func start()
    func showTaskDetailToAddTask()
    func showTaskDetailToEditTask(_ task: Task)
    func presentPopover(with alert: UIAlertController)
}

final class FlowCoordinator: FlowCoordinatorProtocol {
    weak var navigationController: UINavigationController?

    private var taskRepository: TaskRepository!
    private var taskViewModel: TaskViewModel!
    private var taskListViewModel: TaskListViewModel!
    private var taskDetailViewModel: TaskDetailViewModel!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        // Coordinator의 일부만 담겨서 ViewModel에 전달됨 (Coordinator 전체를 ViewModel에 넘기는 것보다 결합도는 낮아짐)
        let actions = TaskListViewModelActions(showTaskDetailToAddTask: showTaskDetailToAddTask,
                                               showTaskDetailToEditTask: showTaskDetailToEditTask,
                                               presentPopover: presentPopover)
        
        // 2개 ViewModel에 동일한 Repository를 할당
        taskRepository = TaskRepository()
        taskViewModel = TaskViewModel()
        taskListViewModel = TaskListViewModel(taskRepository: taskRepository, actions: actions)
        taskDetailViewModel = TaskDetailViewModel(taskRepository: taskRepository)
        
        guard let taskListViewController = ViewControllerFactory.create(of: .taskList(taskViewModel: taskViewModel, taskListViewModel: taskListViewModel))
                as? TaskListViewController
        else {
            print(ViewControllerError.invalidViewController.description)
            return
        }
        navigationController?.pushViewController(taskListViewController, animated: false)
    }
    
    // MARK: - TaskListView -> TaskDetailView 화면 이동
    func showTaskDetailToAddTask() {
        guard let taskDetailController = ViewControllerFactory.create(of: .addTaskDetail(taskDetailViewModel: taskDetailViewModel)) as? TaskDetailController else { return }
        navigationController?.present(UINavigationController(rootViewController: taskDetailController), animated: true, completion: nil)
    }
    
    func showTaskDetailToEditTask(_ task: Task) {
        guard let taskDetailController = ViewControllerFactory.create(of: .editTaskDetail(taskDetailViewModel: taskDetailViewModel, taskToEdit: task)) as? TaskDetailController else {
            print(ViewControllerError.invalidViewController.description)
            return
        }
        navigationController?.present(UINavigationController(rootViewController: taskDetailController), animated: true)
    }
    
    // MARK: - TaskListView -> Popover 띄우기
    func presentPopover(with alert: UIAlertController) {
        navigationController?.present(alert, animated: true)
    }
}
