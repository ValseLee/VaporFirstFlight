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
		TabView {
			MainHomeView()
				.tabItem {
					Image(systemName: "house")
					Text("Home")
				}
			
			UserRegisterView()
				.tabItem {
					Image(systemName: "gear")
					Text("Register")
				}
			
		}
		.environmentObject(vaporManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
