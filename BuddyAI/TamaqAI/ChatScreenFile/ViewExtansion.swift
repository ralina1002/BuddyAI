//
//  ViewExtansion.swift
//  TamaqAI
//
//  Created by Ralina on 05.08.2023.
//


import SwiftUI

extension View {
    func endEditing(_ force: Bool) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let windows = windowScene.windows
            windows.forEach { $0.endEditing(force) }
        }
    }
}
