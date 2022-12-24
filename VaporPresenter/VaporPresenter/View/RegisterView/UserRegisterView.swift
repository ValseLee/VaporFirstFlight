//
//  UserRegisterView.swift
//  VaporPresenter
//
//  Created by 이승준 on 2022/12/24.
//

import SwiftUI

struct UserRegisterView: View {
	@EnvironmentObject private var vaporManager: VaporNetworkModel
	@State private var userName: String = ""
	@State private var userJob: String = ""
	@State private var userAge: String = ""
	
    var body: some View {
		VStack {
			TextField("Name", text: $userName)
			
			TextField("Age", text: $userAge)
			
			TextField("Job", text: $userJob)
			
			Button {
				Task {
					await vaporManager.createUserInfo(with: UserInfo(name: "국영", job: "영화배우", age: 22))
				}
			} label: {
				Text("Submit")
			}
		}
    }
}

struct UserRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        UserRegisterView()
    }
}
