//
//  ContentView.swift
//  APIRequests
//
//  Created by Arturas Milius on 2021-01-16.
//

import SwiftUI

struct ContentView: View {
    @State var channels: [Programme] = []
    
    var body: some View {
        List(channels) { channel in
            if(channel.title.count > 0) {
                Text(channel.title)
            }
        }
        .onAppear {
            API().getChannels{ channels in
                self.channels = channels

            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
