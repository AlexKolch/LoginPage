//
//  CustomModifier.swift
//  LoginPage
//
//  Created by Алексей Колыченков on 11.10.2023.
//

import SwiftUI

struct CustomModifierSpacer: ViewModifier {
    @Binding var showDetail: Bool

    func body(content: Content) -> some View {
        content
            .frame(width: 275.0, height: 368.0)
            .background(showDetail ? Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) : Color(#colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1))).animation(.easeInOut(duration: 0.1), value: showDetail)
            .cornerRadius(42)
    }
}

struct CustomModifierShoesSize: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote)
                .frame(width: 102, height: 41)
                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                .cornerRadius(5)
    }
}
