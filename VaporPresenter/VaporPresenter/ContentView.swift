//
//  ContentView.swift
//  VaporPresenter
//
//  Created by 이승준 on 2022/12/24.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject private var vaporManager = VaporNetworkModel()
	
    var body: some View {
        VStack {
			if let userInfoArray = vaporManager.userInfoArray {
				ForEach(userInfoArray) { array in
					Text("\(array.id)")
					Text("\(array.age)")
					Text(array.name)
				}
			} else {
				ProgressView()
			}
        }
		.task {
			await vaporManager.fetchUserInfo(query: "test_table")
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
