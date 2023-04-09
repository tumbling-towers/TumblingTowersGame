//
//  TutorialView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 10/4/23.
//

import SwiftUI

struct TutorialView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager
    @Binding var currGameScreen: Constants.CurrGameScreens

    var body: some View {
        ZStack {
            BackgroundView()

            VStack {
                Spacer()

                drawInstructions()

                Spacer()

                GameplayGoBackMenuView(currGameScreen: $currGameScreen)
                    .padding(.bottom, 1)

            }
        }
    }

    private func drawInstructions() -> AnyView {
        AnyView(
            GeometryReader { geo in
                ScrollView(.vertical) {
                    VStack(alignment: .center) {

                        Text(Constants.instructionsTitle)
                            .modifier(CategoryText(fontSize: 30))

                        drawInstructionsBody()
                    }
                    .frame(width: geo.size.width)
                    .frame(minHeight: geo.size.height)
                }
            }
        )
    }

    private func drawInstructionsBody() -> AnyView {
        AnyView(
            VStack {
                Text(Constants.instructionsPressStart)
                    .modifier(GameplayGuiText(fontSize: 20))

                Text(Constants.instructionsGameModes)
                    .modifier(BodyText(fontSize: 20))

                Text("\n").hidden()

                drawGameModeDescriptions()

                Text(Constants.instructionsAfterSelectGameMode)
                    .modifier(BodyText(fontSize: 25))
                    .padding(.all, 3)

                drawGameplayHelp()

            }

        )
    }

    private func drawGameModeDescriptions() -> AnyView {
        AnyView(
            VStack {

                ForEach(Constants.GameModeTypes.allCases, id: \.self) { value in

                    HStack {
                        Text(value.rawValue + ": ")
                            .modifier(CategoryText())

                        Text(Constants.getGameModeType(from: value)?.description ?? Constants.instructionsDefaultGamemodeText)
                            .modifier(BodyText(fontSize: 15))
                    }
                    .padding(.all, 3)
                }

            }

        )
    }

    private func drawGameplayHelp() -> AnyView {
        AnyView(
            VStack {
                Text(Constants.instructionsInputControl)
                    .modifier(BodyText(fontSize: 20))

                drawInputDescriptions()
            }

        )
    }

    private func drawInputDescriptions() -> AnyView {
        AnyView(
            VStack {

                ForEach(Constants.GameInputTypes.allCases, id: \.self) { value in

                    HStack {
                        Text(value.rawValue + ": ")
                            .modifier(CategoryText())

                        Text(Constants.getGameInputType(fromGameInputType: value)?.description ?? Constants.instructionsDefaultInputText)
                            .modifier(BodyText(fontSize: 15))
                    }
                    .padding(.all, 3)
                }

            }

        )
    }


}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(currGameScreen: .constant(.tutorial))
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager()))
    }
}
