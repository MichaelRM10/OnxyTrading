//
//  HomeScreen.swift
//  OnyxTrading
//
//  Created by Michael Martinez on 11/24/24.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selectedTimeframe: String = "1D"
    
    @State private var portfolioValue: Double = 125000.45
    
    @State private var holdings: [Holding] = [
        Holding(name: "Bitcoin", symbol: "BTC", percentage: 40, value: 50000, change: 3.5),
        Holding(name: "Ethereum", symbol: "ETH", percentage: 30, value: 37500, change: -1.2),
        Holding(name: "Solana", symbol: "SOL", percentage: 20, value: 25000, change: 5.0),
        Holding(name: "Cardano", symbol: "ADA", percentage: 10, value: 12500, change: 2.3)
    ]
    @State private var watchlist: [Crypto] = [
        Crypto(name: "Ripple", symbol: "XRP", price: 1.25, change: 2.1),
        Crypto(name: "Polkadot", symbol: "DOT", price: 34.55, change: -0.8)
    ]
    @State private var isAddingCrypto: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                // Futuristic Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Total Portfolio Value
                        PortfolioHeaderView(portfolioValue: portfolioValue)

                        // Performance Chart
                        PerformanceChart(selectedTimeframe: $selectedTimeframe)

                        // Breakdown by Asset
                        HoldingsSection(holdings: holdings)

                        // Watchlist Section with Add Button
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Watchlist")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                                Button(action: {
                                    isAddingCrypto.toggle()
                                }) {
                                    Image(systemName: "plus")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Circle().fill(Color.blue))
                                        .shadow(color: .blue.opacity(0.7), radius: 5, x: 0, y: 5)
                                }
                            }

                            ForEach(watchlist) { crypto in
                                WatchlistItem(crypto: crypto)
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(10)

                        
                        MarketTrendsSection()

                        
                        QuickActionsSection()

                        
                        MarketNewsSection()
                    }
                    .padding()
                }

                
                if isAddingCrypto {
                    AddCryptoModal(isAddingCrypto: $isAddingCrypto)
                }
            }
            .navigationTitle("OnyxTrading")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Profile tapped")
                    }) {
                        Image(systemName: "person.crop.circle")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

// MARK: Components

struct PortfolioHeaderView: View {
    let portfolioValue: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Total Portfolio Value")
                .font(.headline)
                .foregroundColor(.white)
            Text("$\(String(format: "%.2f", portfolioValue))")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.8))
        .cornerRadius(10)
        .shadow(color: .blue.opacity(0.6), radius: 10, x: 0, y: 10)
    }
}

struct PerformanceChart: View {
    @Binding var selectedTimeframe: String
    let timeframes = ["1D", "1W", "1M", "1Y"]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Portfolio Performance")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Picker("Timeframe", selection: $selectedTimeframe) {
                    ForEach(timeframes, id: \.self) { timeframe in
                        Text(timeframe).tag(timeframe)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .background(Color.black.opacity(0.8))
                .cornerRadius(8)
            }

            // Example Chart Placeholder
            Rectangle()
                .fill(Color.black.opacity(0.8))
                .frame(height: 150)
                .cornerRadius(10)
                .overlay(
                    Text("Interactive Chart Here")
                        .foregroundColor(.white)
                )
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(10)
    }
}

struct HoldingsSection: View {
    let holdings: [Holding]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Breakdown by Asset")
                .font(.headline)
                .foregroundColor(.white)

            ForEach(holdings) { holding in
                HStack {
                    VStack(alignment: .leading) {
                        Text(holding.name)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(holding.symbol.uppercased())
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("$\(String(format: "%.2f", holding.value))")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("\(holding.percentage)%")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                Divider()
                    .background(Color.white.opacity(0.3))
            }
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(10)
    }
}

struct WatchlistItem: View {
    let crypto: Crypto

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(crypto.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(crypto.symbol.uppercased())
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("$\(String(format: "%.2f", crypto.price))")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("\(crypto.change > 0 ? "+" : "")\(String(format: "%.2f", crypto.change))%")
                    .font(.subheadline)
                    .foregroundColor(crypto.change > 0 ? .green : .red)
            }
        }
        Divider()
            .background(Color.white.opacity(0.3))
    }
}

struct MarketTrendsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("AI Market Trends")
                .font(.headline)
                .foregroundColor(.white)

            Rectangle()
                .fill(Color.black.opacity(0.8))
                .frame(height: 100)
                .cornerRadius(10)
                .overlay(
                    Text("AI Predictions & Insights Here")
                        .foregroundColor(.white)
                )
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(10)
    }
}

struct QuickActionsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Quick Actions")
                .font(.headline)
                .foregroundColor(.white)

            HStack(spacing: 16) {
                ActionButton(label: "Buy", color: .green)
                ActionButton(label: "Sell", color: .red)
                ActionButton(label: "Deposit", color: .blue)
                ActionButton(label: "Withdraw", color: .orange)
            }
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(10)
    }
}

struct MarketNewsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Market News")
                .font(.headline)
                .foregroundColor(.white)
            
            ForEach(0..<3) { index in
                HStack {
                    Text("News Headline \(index + 1)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .lineLimit(2)
                    Spacer()
                    Image(systemName: "newspaper")
                        .font(.title3)
                        .foregroundColor(.blue)
                }
                Divider()
                    .background(Color.white.opacity(0.3))
            }
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(10)
    }
}

struct ActionButton: View {
    let label: String
    let color: Color

    var body: some View {
        Button(action: {
            
        }) {
            Text(label)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(color.opacity(0.3))
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: color, radius: 10, x: 0, y: 10)
        }
    }
}

struct AddCryptoModal: View {
    @Binding var isAddingCrypto: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Add Cryptocurrency")
                .font(.headline)
                .foregroundColor(.white)
            Button("Dismiss") {
                isAddingCrypto.toggle()
            }
            .font(.headline)
            .foregroundColor(.blue)
        }
        .padding()
        .background(Color.black.opacity(0.9))
        .cornerRadius(20)
        .shadow(color: .blue, radius: 20, x: 0, y: 10)
        .frame(maxWidth: 300)
    }
}


struct Holding: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let percentage: Int
    let value: Double
    let change: Double
}

struct Crypto: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let price: Double
    let change: Double
}


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
