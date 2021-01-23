//
//  MainPage.swift
//  APIRequests
//
//  Created by Arturas Milius on 2021-01-18.
//

import SwiftUI

struct MainPage: View {
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack(spacing: 20) {
                        NavigationLink(destination: Movies()) {
                            ChannelSquare(channelName: "TV", imageName: "rsz_tv3", imageColor: Color.green, spacing: -5)
                        }
                        ChannelSquare(channelName: "LNK", imageName: "lnk", imageColor: Color.red, spacing: 10)
                        ChannelSquare(channelName: "TV6", imageName: "rsz_tv6", imageColor: Color.blue, spacing: 10)
                        ChannelSquare(channelName: "lrt", imageName: "rsz_lrt", imageColor: Color.gray, spacing: 10)
                    }
                }
                .navigationBarTitle("Kanalai:")
                .padding()
            }
        }
    }
}

struct ChannelSquare: View {
    
    var channelName: String
    var imageName: String
    var imageColor: Color
    var spacing: CGFloat
    
    var body: some View {
        HStack(spacing: spacing) {
            Text(channelName)
                .font(.system(size: 40, weight: .semibold, design: .default))
                
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 100)
        }
        .padding()
        .frame(width: 200, height: 200)
        .background(imageColor)
        .cornerRadius(25.0)
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
