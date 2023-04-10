//
//  TutorialView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 10/4/23.
//

import SwiftUI

struct TutorialView: View {
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
                    .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager(), inputType: TapInput.self))

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
                    .frame(width: geo.size.width - 100)
                    .frame(minHeight: geo.size.height)
                }
                .padding([.leading, .trailing], 50)
            }
        )
    }

    private func drawInstructionsBody() -> AnyView {
        AnyView(
            VStack {
                Text(Constants.instructionsPressStart)
                    .modifier(GameplayGuiText(fontSize: 20))

                Text(Constants.instructionsGameModes)
                    .modifier(GameplayBodyText(fontSize: 20))

                Divider().modifier(MenuDividerLine())

                drawGameModeDescriptions()

                Divider().modifier(MenuDividerLine())
                
                Text(Constants.instructionsAfterSelectGameMode)
                    .modifier(GameplayBodyText(fontSize: 25))
                    .padding(.all, 3)

                drawGameplayHelp()

                Text(Constants.instructionsStackBlocks)
                    .modifier(GameplayBodyText(fontSize: 20))

                Text(Constants.instructionsHaveFun)
                    .modifier(GameplayGuiText(fontSize: 40))
            }

        )
    }

    private func drawGameModeDescriptions() -> AnyView {
        AnyView(
            VStack(alignment: .leading) {

                ForEach(Constants.GameModeTypes.allCases, id: \.self) { value in

                    HStack {
                        Text(value.rawValue + ": ")
                            .modifier(CategoryText())

                        Text(Constants.getGameModeType(from: value)?.description ?? Constants.instructionsDefaultGamemodeText)
                            .modifier(GameplayBodyText(fontSize: 30))
                    }
                    .padding(.all, 10)
                }

            }
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.init(red: 0.969, green: 0.933, blue: 0.855)))
        )
    }

    private func drawGameplayHelp() -> AnyView {
        AnyView(
            VStack {
                Text(Constants.instructionsInputControl)
                    .modifier(GameplayBodyText(fontSize: 20))

                Divider().modifier(MenuDividerLine())

                drawInputDescriptions()

                Divider().modifier(MenuDividerLine())

                Text(Constants.instructionsBlockContact)
                    .modifier(GameplayBodyText(fontSize: 20))

                VStack {
                    Text(Constants.instructionsOtherGuiButtons)
                        .modifier(GameplayBodyText(fontSize: 20))

                    Text(Constants.generalInputDescription)
                        .modifier(BodyText(fontSize: 20))
                }
                .padding(.all, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.init(red: 0.969, green: 0.933, blue: 0.855)))

                Text("\n").hidden()

            }

        )
    }

    private func drawInputDescriptions() -> AnyView {
        AnyView(
            VStack(alignment: .leading) {

                ForEach(Constants.GameInputTypes.allCases, id: \.self) { value in

                    HStack {
                        Text(value.rawValue + ": ")
                            .modifier(CategoryText())

                        Text(Constants.getGameInputType(fromGameInputType: value)?.description ?? Constants.instructionsDefaultInputText)
                            .modifier(BodyText(fontSize: 20))
                    }
                    .padding(.all, 10)
                }

            }
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.init(red: 0.969, green: 0.933, blue: 0.855)))

        )
    }


}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(currGameScreen: .constant(.tutorial))
    }
}
