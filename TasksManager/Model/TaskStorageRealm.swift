//
//  TaskStorageRealm.swift
//  TasksManager
//
//  Created by Aleksey on 06.10.2021.
//  Copyright © 2021 Aleksey. All rights reserved.
//

import Foundation
import RealmSwift

class TasksNowStorage: Object {
    @objc dynamic var taskNowTitle: String = ""
    @objc dynamic var taskNowContent: String = ""
}

class TasksCompleteStorage: Object {
    @objc dynamic var taskCompleteTitle: String = ""
    @objc dynamic var taskCompleteContent: String = ""
}
