//
//  VaporNetworkModel.swift
//  VaporPresenter
//
//  Created by 이승준 on 2022/12/24.
//

import SwiftUI

final class VaporNetworkModel: ObservableObject {
	@Published public var userInfoArray: [UserInfo]?
	private let session = URLSession(configuration: .default)
	private let url = URL(string: "http://127.0.0.1:8080")!
	private let encoder = JSONEncoder()
	private let decoder = JSONDecoder()
	
	@MainActor
	public func fetchUserInfo(query: String) async -> Void {
		let connectTo = URL(string: "\(url)/\(query)/")!
		
		do {
			let fetchedData = try await session.data(from: connectTo).0
			let fetchResult = try decoder.decode([UserInfo].self, from: fetchedData)
			self.userInfoArray = fetchResult
		} catch {
			dump("CANT FETCH : \(error.localizedDescription)")
		}
	}
	
	public func createUserInfo(with newUser: UserInfo) async -> Void {
		do {
			let encodedUserData = try encoder.encode(newUser)
			
			let postEndPoint = URL(string: "\(url)/create")!
			var request = URLRequest(url: postEndPoint)
			request.httpBody = encodedUserData
			request.httpMethod = "POST"
			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			
			await runCreateSession(withRequest: request, withNewUserData: encodedUserData)
			
		} catch {
			dump("\(newUser) - CANT BE ENCODED : \(error.localizedDescription)")
		}
	}
	
	private func runCreateSession(withRequest: URLRequest, withNewUserData: Data) async -> Void {
		do {
			let uploadData = try await session.upload(for: withRequest, from: withNewUserData)
			
			let answer = try JSONDecoder().decode(UserInfo.self, from: uploadData.0)
			dump("++++ SUCCESS, \(answer.name) \(answer.job)")
		} catch {
			dump("+++ \(error.localizedDescription), \(withNewUserData)")
		}
		
	}
}
