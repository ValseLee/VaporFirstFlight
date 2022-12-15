import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("Connected") { req async -> String in
        "Yeah"
    }
	
	app.get("test_table") { req async -> String in
		var testTableName = ""
		
		do {
			let testTable = try req.content.decode(TestTable.self)
			print(testTable.name)
			testTableName = testTable.name
		} catch {
			dump(error.localizedDescription)
		}
		
		return testTableName
	}

    try app.register(collection: TestTableController())
}


/*
 API KEY는 서버에서 생성하고 유저에게 발급,
 이후 API 요청이 수신되면? 서버에서 KEY 비교 후 호출 진행
 header로 심거나 JWT, 등으로 유효 호출인지 이중 보안 진행 필요.
 */
