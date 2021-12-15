//
//  AvatarView.swift
//  DubDubGrub
//
//  Created by Sean Allen on 5/21/21.
//

import SwiftUI

struct AvatarView: View {
    
    var image: Image
    var size: CGFloat
    
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}


