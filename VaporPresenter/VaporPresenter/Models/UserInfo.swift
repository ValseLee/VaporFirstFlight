//
//  UserInfo.swift
//  VaporPresenter
//
//  Created by 이승준 on 2022/12/24.
//

import Foundation

struct UserInfo: Codable, Identifiable {
	var id: Int?
	var name: String
	var job: String
	var age: Int
}
