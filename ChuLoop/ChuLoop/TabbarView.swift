//
//  BasicTabBar.swift
//  Test_SwiftUIChuLoop
//
//  Created by Anna Kim on 2023/04/10.
//

import SwiftUI

struct TabbarView: View {
    
    // tab index 값 지정
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            MainView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("홈")
                }
                .tag(0)
            Text("Collection Tab")
                .tabItem {
                    Image(systemName: "photo.stack.fill")
                    Text("사진")
                }
                .tag(1)
            ContentView()
                .tabItem {
                    Image(systemName: "tag.fill")
                    Text("위시")
                }
                .tag(2)
        }
        .onAppear() {
            UITabBar.appearance().barTintColor = .white
        }
        .accentColor(.orange)

    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}

