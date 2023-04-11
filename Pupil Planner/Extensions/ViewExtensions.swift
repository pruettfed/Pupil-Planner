//
//  ViewExtensions.swift
//  Pupil Planner
//
//  Created by Pruett Fedorowicz on 4/11/23.
//

import Foundation
import SwiftUI

extension Text {
    func scrollTextStyle() -> some View {
        self
            .font(.system(size: 14))
            .fontWeight(.medium)
            .foregroundColor(Color("Text Accent"))
    }
}

extension View {
    func addViewBarStyle() -> some View {
        self
            .padding()
            .background(Color("Background Color"))
            .cornerRadius(20)
            .padding(.horizontal, 18)
    }
}

extension View {
    func rowShadow() -> some View {
        self.shadow(color: Color.black.opacity(0.3), radius: 6, y: 4)
    }
}

extension View {
    func rowPadding() -> some View {
        self
            .padding(.top, 8)
            .padding([.bottom, .trailing, .leading], 18)
    }
}

