//
//  NormalGoBackButtonView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 12/4/23.
//

import SwiftUI

struct NormalGoBackButtonView: View {
    @Binding var currGameScreen: Constants.CurrGameScreens
    var destination = Constants.CurrGameScreens.mainMenu
    var fontSize = 40.0

    var body: some View {
        HStack {
            Spacer()

            Button {
                withAnimation {
                    currGameScreen = destination
                }
            } label: {
                Text("Back")
                    .modifier(CustomButton(fontSize: fontSize))
            }

            Spacer()
        }
    }
}

struct NormalGoBackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NormalGoBackButtonView(currGameScreen: .constant(.mainMenu))
    }
}
