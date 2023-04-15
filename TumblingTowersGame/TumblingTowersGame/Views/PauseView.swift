//
//  PauseView.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 4/4/23.
//

import Foundation
import SwiftUI

struct PauseView: View {
    var unpause: () -> Void
    var exit: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.1)
                .ignoresSafeArea()
            
            VStack {
                Button {
                    unpause()
                } label: {
                    Image(ViewImageManager.resumeButton)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                }
                .frame(height: 50)
                
                Spacer().frame(height: 50)
                
                Button {
                    exit()
                } label: {
                    Image(ViewImageManager.exitButton)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                }
                .frame(height: 50)
                
            }
        }
        .interactiveDismissDisabled()
    }
    
    struct PauseView_Previews: PreviewProvider {
        static var previews: some View {
            PauseView(unpause: {}, exit: {})
        }
    }
}
