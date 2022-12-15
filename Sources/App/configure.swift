import Fluent
import FluentPostgresDriver
import FluentMySQLDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
	
	/// test DBTable을 db로 사용, 당연히 테스트라서 이름과 패스워드는 valse, 1234로 설정하고 따로 보안조치 하지 않음
	app.databases.use(.mysql(hostname: "localhost", username: "valse", password: "1234", database: "test"), as: .mysql)

    app.migrations.add(CreateTodo())

    // register routes
    try routes(app)
}
