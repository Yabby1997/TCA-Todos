//
//  TodoViewReducer.swift
//  TCA-Todos
//
//  Created by USER on 2022/11/27.
//

import Foundation
import ComposableArchitecture

struct TodoViewReducer: ReducerProtocol {
    typealias State = Todo

    enum Action: Equatable {
        case priorityToggled
        case doneToggled
        case descriptionChanged(String)
        case deadlineChanged(Date)
    }

    func reduce(into state: inout Todo, action: Action) -> EffectTask<Action> {
        switch action {
        case .priorityToggled:
            state.priority = state.priority.nextPriority()
            return .none
        case .doneToggled:
            state.isDone.toggle()
            return .none
        case let .descriptionChanged(description):
            state.description = description
            return .none
        case let .deadlineChanged(deadline):
            state.deadline = deadline
            return .none
        }
    }
}
