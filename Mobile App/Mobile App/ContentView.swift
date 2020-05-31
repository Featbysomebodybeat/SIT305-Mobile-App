//
//  ContentView.swift
//  Mobile App
//
//  Created by Shuo Wang on 7/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("turlerock")
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
