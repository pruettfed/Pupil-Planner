//
//  EmptyItemsView.swift
//  Pupil Planner
//
//  Created by Pruett Fedorowicz on 4/11/23.
//

import SwiftUI

struct EmptyItemsView: View {
    var title: String = "No upcoming 🥳"
    var caption: String = "WOOOOOO!"
    
    var body: some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
            Text(caption)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color("Background Color"))
        .cornerRadius(18)
        .rowPadding()
        .rowShadow()
    }
}

struct EmptyItemsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyItemsView()
    }
}
