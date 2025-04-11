//
//  BookListSkeleton.swift
//  GutenDex
//
//  Created by mridul-ziroh on 11/04/25.
//
import Foundation
import SwiftUI

struct BookListSkeleton: View {
    @State var isAnimating = true
    var body: some View {
        List{
            ForEach(0..<9) { _ in
                let color = Color.gray.opacity(0.4)
                HStack {
                    color
                        .frame(width: 60, height: 90)
                        .cornerRadius(4)
                        .background(.gray.opacity(0.4))
                    
                    VStack(alignment: .leading, spacing: 15){
                        color
                            .frame(width: 150, height: 15)
                            .clipShape(Capsule())
                        
                        color
                            .frame(width: 100, height: 15)
                            .clipShape(Capsule())
                        
                        color
                            .frame(width: 150, height: 15)
                            .clipShape(Capsule())
                        
                    }
                }
            }
            .opacity(isAnimating ? 0.5 : 1.0)
            .onAppear {
                withAnimation(Animation.linear(duration: 0.8).repeatForever(autoreverses: true)) {
                    isAnimating.toggle()
                }
            }
        }
        .navigationTitle("Books")
        .listStyle(.plain)
    }
}

#Preview {
    BookListSkeleton()
}
