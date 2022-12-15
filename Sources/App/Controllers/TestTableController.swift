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
	
	func index(req: Request) async throws -> [Test_TableModel]
	
	
}
