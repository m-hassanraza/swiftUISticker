//
//  stickerApp.swift
//  sticker
//
//  Created by Hassan Raza on 3/9/23.
//

import SwiftUI

@main
struct stickerApp: App {
    var body: some Scene {
        WindowGroup {
            ScrollView{
                ZStack{
                    Sticker()
                    Sticker()
                    Sticker()
                    Sticker()
                    Sticker()
                }
                
            }
        }
    }
}
