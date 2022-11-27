//
//  TodoView.swift
//  TCA-Todos
//
//  Created by USER on 2022/11/27.
//

import SwiftUI
import ComposableArchitecture

extension TodoPriority {
    var color: Color {
        switch self {
        case .urgent: return .red
        case .normal: return .yellow
        case .notNecessary: return .green
        }
    }
}

struct TodoView: View {
    @ObservedObject var viewStore: ViewStore<TodoViewReducer.State, TodoViewReducer.Action>

    init(store: StoreOf<TodoViewReducer>) {
        self.viewStore = ViewStore(store)
    }

    var body: some View {
        HStack {
            Circle()
                .foregroundColor(
                    viewStore.isDone
                        ? .gray
                        : viewStore.priority.color
                )
                .onTapGesture {
                    viewStore.send(.priorityToggled)
                }
                .frame(width: 18, height: 18)
                .disabled(viewStore.isDone)
            Image(systemName: viewStore.isDone ? "checkmark.square" : "square")
                .onTapGesture {
                    viewStore.send(.doneToggled)
                }
                .disabled(viewStore.isInvalid)
            TextField(
                "Untitled",
                text: viewStore.binding(
                    get: { $0.description },
                    send: { TodoViewReducer.Action.descriptionChanged($0) }
                )
            )
            .disabled(viewStore.isDone)
            .strikethrough(viewStore.isDone)
            DatePicker(
                selection: viewStore.binding(
                    get: { $0.deadline },
                    send: { TodoViewReducer.Action.deadlineChanged($0) }
                ),
                displayedComponents: [.date],
                label: {}
            )
            .disabled(viewStore.isDone)
        }
        .foregroundColor(viewStore.isDone ? .gray : nil)
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView(store: Store(initialState: Todo(id: UUID()), reducer: TodoViewReducer()))
    }
}
