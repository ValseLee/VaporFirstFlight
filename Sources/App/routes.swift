import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("Connected") { req async -> String in
        "Yeah"
    }

    try app.register(collection: TodoController())
}
