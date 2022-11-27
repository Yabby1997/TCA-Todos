//
//  Todo.swift
//  TCA-Todos
//
//  Created by USER on 2022/11/27.
//

import Foundation

enum TodoPriority {
    case urgent
    case normal
    case notNecessary

    func nextPriority() -> Self {
        switch self {
        case .urgent: return .notNecessary
        case .normal: return .urgent
        case .notNecessary: return .normal
        }
    }
}

struct Todo: Equatable, Identifiable {
    let id: UUID
    var description: String = ""
    var priority: TodoPriority = .normal
    var deadline: Date = .init()
    var isDone: Bool = false

    var isInvalid: Bool { description.isEmpty }
}
