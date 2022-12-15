//
//  File.swift
//  
//
//  Created by 이승준 on 2022/12/15.
//

import Vapor
import Fluent

final class TestTable: Model, Content {
	static let schema = "test_table"
	
	@ID(custom: "id")
	var id: Int?
	
	@Field(key: "name")
	var name: String
	
	@Field(key: "job")
	var job: String
	
	@Field(key: "age")
	var age: Int
	
	init() { }
	
	init(id: Int? = nil, name: String, job: String, age: Int) {
		self.name = name
		self.job = job
		self.age = age
	}
}
