//
//  Extension + Image.swift
//  LoginPage
//
//  Created by Алексей Колыченков on 11.10.2023.
//

import SwiftUI

extension Image: Hashable {
    var name: String {
        return ""
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
