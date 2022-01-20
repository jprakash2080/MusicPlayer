//
//  Extension.swift
//  MusicPlayer
//
//  Created by Prakash on 19/01/22.
//

import Foundation
import SwiftUI
extension Color {
    static func rgb(r: Double, g: Double, b: Double) -> Color {
        return Color(red: r / 255, green: g / 255, blue: b / 255)
    }
    static let backgroundColor = Color.rgb(r: 21, g: 22, b: 33)
    static let buttonColor = Color.rgb(r: 190, g: 230, b: 100)
}
