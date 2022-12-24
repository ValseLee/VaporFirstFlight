//
//  MainHomeView.swift
//  VaporPresenter
//
//  Created by 이승준 on 2022/12/24.
//

import SwiftUI

struct MainHomeView: View {
	@EnvironmentObject private var vaporManager: VaporNetworkModel
	
    var body: some View {
		VStack {
			if let userInfoArray = vaporManager.userInfoArray {
				ForEach(userInfoArray) { array in
					Text("\(array.id ?? 0)")
					Text("\(array.age)")
					Text(array.name)
				}
			} else {
				ProgressView()
			}
		}
		.task {
			await vaporManager.fetchUserInfo(query: "api")
		}
    }
}

struct MainHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomeView()
    }
}
