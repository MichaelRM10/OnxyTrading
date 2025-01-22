//
//  CryptoCard.swift
//  OnyxTrading
//
//  Created by Michael Martinez on 11/24/24.
//

import SwiftUI

struct CryptoCard: View {
    let name: String
    let symbol: String
    let price: Double
    let change: Double

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(symbol.uppercased())
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("$\(String(format: "%.2f", price))")
                    .font(.headline)
                Text("\(change > 0 ? "+" : "")\(String(format: "%.2f", change))%")
                    .font(.subheadline)
                    .foregroundColor(change > 0 ? .green : .red)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

struct CryptoCard_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCard(name: "Bitcoin", symbol: "BTC", price: 54000, change: 2.5)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
