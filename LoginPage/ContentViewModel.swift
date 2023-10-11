//
//  ContentViewModel.swift
//  LoginPage
//
//  Created by Алексей Колыченков on 11.10.2023.
//

import SwiftUI
import Combine

final class ContentViewModel: ObservableObject {
    @Published var selectedShoes = Shoes.one
}
