import Foundation

protocol StorageProtocol {
    associatedtype Item
    var storage: [Item] { get }
    func create()
    func fetch()
    func update()
    func delete()
}

class LocalStorage<Task>: StorageProtocol {
    typealias Item = Task
    
    var storage: [Task] = []
    
    init(storage: [Task]) {
        self.storage = storage
    }
    
    func create() {
        <#code#>
    }
    
    func fetch() {
        <#code#>
    }
    
    func update() {
        <#code#>
    }
    
    func delete() {
        <#code#>
    }
}

class RemoteStorage<Task>: StorageProtocol {
    typealias Item = Task
    
    var storage: [Task] = []
    
    init(storage: [Task]) {
        self.storage = storage
    }
    
    func create() {
        <#code#>
    }
    
    func fetch() {
        <#code#>
    }
    
    func update() {
        <#code#>
    }
    
    func delete() {
        <#code#>
    }
}
