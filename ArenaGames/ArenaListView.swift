//
//  ContentView.swift
//  ArenaGames
//
//  Created by Anton Marchanka on 11/29/24.
//

import SwiftUI

struct ArenaListView: View {
    @StateObject var viewModel = ArenaViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                ForEach(viewModel.coins, id:\.name) { coin in
                    HStack {
                        Image(coin.image)
                            .resizable()
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading) {
                            Text(coin.name)
                                .fontWeight(.semibold)
                            Text(coin.blockchain)
                                .fontWeight(.regular)

                        }
                        Spacer()
                        Text("\(Int(coin.balance))")
                        Text(coin.currency.uppercased())
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ArenaListView(viewModel: ArenaViewModel())
}
