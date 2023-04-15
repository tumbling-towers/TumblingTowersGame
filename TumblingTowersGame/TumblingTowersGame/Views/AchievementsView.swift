//
//  AchievementsView.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 10/4/23.
//

import SwiftUI

struct AchievementsView: View {
    @EnvironmentObject var viewAdapter: ViewAdapter

    @Binding var currGameScreen: Constants.CurrGameScreens

    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Text("Achievements")
                    .modifier(CategoryText())
                ForEach($viewAdapter.achievements) { achievment in
                    VStack {
                        HStack {
                            Text(achievment.wrappedValue.name)
                                .modifier(CategoryText(fontSize: 18))
                            Spacer()
                            let image = achievment.wrappedValue.achieved
                                        ? ViewImageManager.tickImage
                                        : ViewImageManager.crossImage
                            Image(image)
                                .resizable()
                                .frame(
                                    width: 20,
                                    height: 20,
                                    alignment: .center)
                        }.frame(width: 2/3 * viewAdapter.levelDimensions.width)
                        HStack {
                            Text(achievment.wrappedValue.description)
                                .modifier(BodyText())
                            Spacer()
                        }
                    }.frame(width: 2/3 * viewAdapter.levelDimensions.width)
                }
                
                NormalGoBackButtonView(currGameScreen: $currGameScreen)

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
            .environmentObject(ViewAdapter(levelDimensions: .infinite, gameEngineMgr: GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager(), inputType: TapInput.self, storageManager: StorageManager())))
    }
}
