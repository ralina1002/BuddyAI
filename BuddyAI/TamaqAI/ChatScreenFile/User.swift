//
//  User.swift
//  TamaqAI
//
//  Created by Ralina on 05.08.2023.
//


import Foundation

struct User: Hashable {
    var name: String
    var avatar: String
    var isCurrentUser: Bool = false
}
