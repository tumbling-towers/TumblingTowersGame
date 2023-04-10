//
//  SettingsView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var mainGameMgr: MainGameManager
    @StateObject var settingsMgr: SettingsManager

    @Binding var currGameScreen: Constants.CurrGameScreens

    // MARK: Retrieve from storage in future
    @State private var selectedInputType = Constants.GameInputTypes.GYRO

    var body: some View {
        ZStack {
            BackgroundView()

            VStack {
                Text("Volume")
                    .modifier(CategoryText())

                HStack {
                    Text("Overall")
                        .modifier(BodyText())

                    Slider(value: $settingsMgr.overallVolume, in: 0.0...1.0)
                        .frame(width: 400)
                        .padding(.all)
                }

                HStack {
                    Text("Background Music")
                        .modifier(BodyText())

                    Slider(value: $settingsMgr.backgroundMusicVolume, in: 0.0...1.0)
                        .frame(width: 400)
                        .padding(.all)
                }

                HStack {
                    Text("Other Sounds")
                        .modifier(BodyText())

                    Slider(value: $settingsMgr.otherSoundVolume, in: 0.0...1.0)
                        .frame(width: 400)
                        .padding(.all)
                }

                Text("Input Options")
                    .modifier(CategoryText())

                Picker(selection: $selectedInputType, label: Text("Input Type").modifier(BodyText())) {
                    ForEach(Constants.GameInputTypes.allCases, id: \.self) { value in
                        Text(value.rawValue)
                            .modifier(BodyText())

                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 400)
                .onChange(of: selectedInputType) { val in
                    mainGameMgr.changeInput(to: val)
                }
                
                Text(Constants.gameInputTypeToDescription[selectedInputType.rawValue] ?? "<input type description>")
                    .modifier(BodyText())

//                HStack {
//                    Text("Block Movement Speed")
//                        .modifier(BodyText())
//
//                    Slider(value: $settingsMgr.otherSoundVolume, in: 0.0...3.0)
//                        .frame(width: 400)
//                        .padding(.all)
//                }

                Button {
                    currGameScreen = .mainMenu
                } label: {
                    Text("Back")
                        .modifier(CustomButton(fontSize: 25))
                }
                .padding(.top, 35.0)
            }
        }
        .ignoresSafeArea(.all)
        .onAppear {
        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settingsMgr: SettingsManager(), currGameScreen: .constant(.gameModeSelection))
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager()))
            .environmentObject(MainGameManager())
            .environmentObject(SettingsManager())
    }
}
