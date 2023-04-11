//
//  AchievementsView.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 10/4/23.
//

import SwiftUI

struct AchievementsView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager

    @Binding var currGameScreen: Constants.CurrGameScreens

    var body: some View {
        ZStack {
            BackgroundView()

            VStack {
                ForEach($gameEngineMgr.achievements) { achievment in
                    VStack {
                        HStack {
                            Text(achievment.wrappedValue.name)
                                .modifier(CategoryText())
                            let image = achievment.wrappedValue.achieved
                                        ? ViewImageManager.tickImage
                                        : ViewImageManager.crossImage
                            Image(image)
                                .resizable()
                                .frame(
                                    width: 20,
                                    height: 20,
                                    alignment: .center)
                        }
                        Text(achievment.wrappedValue.description)
                            .modifier(BodyText())
                    }
                }
                
                
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

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView(currGameScreen: .constant(.achievements))
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager(), storageManager: StorageManager()))
    }
}
