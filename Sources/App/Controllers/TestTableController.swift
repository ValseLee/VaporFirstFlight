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
		let testTables = routes.grouped("test_table")
		
		testTables.get(use: index)
		testTables.post(use: create)
		
		testTables.group(":id") { eachInfo in
			eachInfo.delete(use: delete)
		}
	}
	
	// MARK: Get Every items in db
	func index(req: Request) async throws -> [TestTable] {
		try await TestTable.query(on: req.db).all()
	}
	
	func create(req: Request) async throws -> TestTable {
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
