//
//  MainTabView.swift
//  OnyxTrading
//
//  Created by Michael Martinez on 11/24/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0 //

    var body: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            
            TabView(selection: $selectedTab) {
                HomeScreen()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)

                MarketScreen()
                    .tabItem {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("Market")
                    }
                    .tag(1)

                TradeScreen()
                    .tabItem {
                        Image(systemName: "arrow.swap")
                        Text("Trade")
                    }
                    .tag(2)

                WalletScreen()
                    .tabItem {
                        Image(systemName: "wallet.pass")
                        Text("Wallet")
                    }
                    .tag(3)

                ProfileScreen()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                    .tag(4)
            }
            .accentColor(.black)
            .background(
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.8), Color.clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea(edges: .bottom)
            )
        }
    }
}
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
