//
//  LoadingProgressView.swift
//  GutenDex
//
//  Created by mridul-ziroh on 11/04/25.
//

import SwiftUI

struct LoadingProgressView: View {
    var body: some View {
        HStack{
            Spacer()
                ProgressView()
                    .foregroundStyle(Color.gray)
                    .scaleEffect(1.5)
                    .progressViewStyle(CircularProgressViewStyle())
            Spacer()
        }
    }
}

#Preview {
    LoadingProgressView()
}
