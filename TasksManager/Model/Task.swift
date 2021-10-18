//
//  Task.swift
//  TasksManager
//
//  Created by Aleksey on 06.10.2021.
//  Copyright © 2021 Aleksey. All rights reserved.
//

import Foundation

enum TaskProperty {
    case now
    case complete
}

protocol TaskProtocol {
    var title: String {get set}
    var content: String {get set}
    var property: TaskProperty {get set}
}

struct Task: TaskProtocol {
    var title: String = ""
    var content: String = ""
    var property: TaskProperty = .now
}

var tasksTestNow = [Task(title: "1", content: "one", property: .now), Task(title: "2", content: "two", property: .now)]

var tasksTestComplete = [Task(title: "3", content: "three", property: .complete), Task(title: "4", content: "four", property: .complete)]
