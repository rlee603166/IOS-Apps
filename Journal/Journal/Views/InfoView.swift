//
//  InfoView.swift
//  Journal
//
//  Created by Ryan Lee on 8/6/24.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("AppIconImg")
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
            Text(Bundle.main.displayName ?? "")
                .font(.largeTitle)
                .fontWeight(.medium)
            Text(Bundle.main.version ?? "")
                .font(.title)
                .fontWeight(.medium)
            Text(Bundle.main.build ?? "")
                .font(.caption)
            Spacer()

            Text(Bundle.main.copyright ?? "")
                .font(.caption2)
        }
        .padding()
    }
}

#Preview {
    InfoView()
}
