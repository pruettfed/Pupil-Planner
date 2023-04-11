//
//  GradientModifier.swift
//  Pupil Planner
//
//  Created by Pruett Fedorowicz on 4/11/23.
//

import Foundation
import SwiftUI

// TODO: Choose which option looks better

extension View {
    func gradientForeground(color: String) -> some View {
        self.background(LinearGradient(gradient: Gradient(colors: [Color(color + "GradientTop"), Color(color + "GradientBottom")]), startPoint: .top, endPoint: .bottom))
    }
}

//extension Rectangle {
//    func gradientFill(color: String) -> some View {
//        self.fill(Color(color + "GradientTop").gradient)
//    }
//}
