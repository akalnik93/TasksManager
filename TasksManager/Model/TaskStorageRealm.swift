import UIKit
import RealmSwift

class TasksNowStorage: Object {
    @objc dynamic var taskNowTitle: String = ""
    @objc dynamic var taskNowContent: String = ""
}

class TasksCompleteStorage: Object {
    @objc dynamic var taskCompleteTitle: String = ""
    @objc dynamic var taskCompleteContent: String = ""
}
