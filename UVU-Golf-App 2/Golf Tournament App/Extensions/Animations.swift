//
//  Animations.swift
//  Golf Tournament App
//
//  Created by Michael Whiting on 5/1/23.
//

import SwiftUI

extension Animation {
    public static var rotateAnimation: Animation {
        Animation.linear(duration: 1)
            .repeatForever(autoreverses: false)
    }
    
    public static var rotateAnimationFast: Animation {
        Animation.linear(duration: 0.75)
            .repeatForever(autoreverses: false)
    }
}
