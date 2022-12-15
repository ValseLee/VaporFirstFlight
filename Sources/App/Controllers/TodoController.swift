import Fluent
import Vapor

struct TodoController: RouteCollection {
	
	/// GET과 POST할 때 사용할 함수를 여기서 지정한다.
    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("todos")
        todos.get(use: index)
        todos.post(use: create)
        todos.group(":todoID") { todo in
            todo.delete(use: delete)
        }
    }

	// MARK: Get Query Builder
    func index(req: Request) async throws -> [Todo] {
        try await Todo.query(on: req.db).all()
    }

	// MARK: POST
    func create(req: Request) async throws -> Todo {
        let todo = try req.content.decode(Todo.self)
        try await todo.save(on: req.db)
        return todo
    }

	// MARK: DELETE
    func delete(req: Request) async throws -> HTTPStatus {
        guard let todo = try await Todo.find(req.parameters.get("todoID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await todo.delete(on: req.db)
        return .noContent
    }
}
