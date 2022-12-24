//
//  File.swift
//  
//
//  Created by 이승준 on 2022/12/15.
//

import Fluent
import Vapor

struct TestTableController: RouteCollection {
	func boot(routes: Vapor.RoutesBuilder) throws {
		/// test_table 엔드포인트를 갖는 route를 묶고 각 요청에 대해 아래의 메소드로 대체합니다.
		let testTables = routes.grouped("api")
		
		testTables.get(use: index)
		testTables.post(use: create)
		
		/// 상단의 엔드포인트에 아이디가 포함되어 있고 delete 요청의 경우엔 delete 메소드로 대체합니다.
		testTables.group(":id") { eachInfo in
			eachInfo.delete(use: delete)
		}
	}
	
	// MARK: Get Every items in db
	func index(req: Request) async throws -> [TestTable] {
		print(#function, "+++++ GET +++++")
		return try await TestTable.query(on: req.db).all()
	}
	
	// MARK: Create New item in db(?)
	/// testable이 post 될 때, create를 사용합니다.
	/// db에 저장하고 리턴까지 해줍니다.
	func create(req: Request) async throws -> TestTable {
		print(#function, "+++++ CREATE +++++")
		let testTable = try req.content.decode(TestTable.self)
		try await testTable.save(on: req.db)
		return testTable
	}
	
	func delete(req: Request) async throws -> HTTPStatus {
		guard let testTable = try await TestTable.find(req.parameters.get("id"), on: req.db) else { throw Abort(.notFound) }
		try await testTable.delete(on: req.db)
		return .noContent
	}
	
	
}
