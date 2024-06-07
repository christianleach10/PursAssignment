//
//  ContentView.swift
//  BeastroApp
//
//  Created by Christian Leach on 6/5/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HoursViewModel()
    @State private var isExpanded = false

    var body: some View {
        ZStack {
            Color(.systemCyan).opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(viewModel.locationName)
                    .font(.largeTitle)
                    .padding()
                
                Image("bistroimage.jpg") // Ensure this image exists in your assets
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()

                HStack {
                    Text(viewModel.currentStatus())
                        .foregroundColor(viewModel.statusColor())
                        .padding()
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }) {
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .padding()
                    }
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding()

                if isExpanded {
                    List(viewModel.formattedHours(), id: \.self) { hour in
                        Text(hour)
                    }
                    .frame(maxHeight: 300)
                }

                Spacer()
            }
        }
        .onAppear {
            viewModel.fetchHours()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




