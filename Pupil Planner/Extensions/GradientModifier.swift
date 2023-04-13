//
//  GradientModifier.swift
//  Pupil Planner
//
//  Created by Pruett Fedorowicz on 4/11/23.
//

import Foundation
import SwiftUI

extension Rectangle {
    func gradientForeground(color: String) -> some View {
        self.fill(LinearGradient(gradient: Gradient(colors: [Color(color + "GradientTop"), Color(color + "GradientBottom")]), startPoint: .top, endPoint: .bottom))
    }
}

extension RoundedRectangle {
    func gradientForeground(color: String) -> some View {
        self.fill(LinearGradient(gradient: Gradient(colors: [Color(color + "GradientTop"), Color(color + "GradientBottom")]), startPoint: .top, endPoint: .bottom))
    }
}
