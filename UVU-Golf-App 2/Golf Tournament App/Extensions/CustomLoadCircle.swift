//
//  CustomLoadCircle.swift
//  Golf Tournament App
//
//  Created by Michael Whiting on 5/1/23.
//

import SwiftUI

struct CustomLoadCircle: View {
    @State var isRotating: Bool = false
    @State var isRotatingFast: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.08, to: 0.18)
                .stroke(Color.secondaryColor.opacity(0.95), style: StrokeStyle(lineWidth: 5))
                .frame(width: 30, height: 30)
                .rotationEffect(Angle.degrees(isRotatingFast ? 360 : 0))
            Circle()
                .trim(from: 0.23, to: 0.33)
                .stroke(Color.secondaryColor.opacity(0.95), style: StrokeStyle(lineWidth: 5))
                .frame(width: 30, height: 30)
                .rotationEffect(Angle.degrees(isRotatingFast ? 360 : 0))
            Circle()
                .trim(from: 0.38, to: 0.48)
                .stroke(Color.secondaryColor.opacity(0.95), style: StrokeStyle(lineWidth: 5))
                .frame(width: 30, height: 30)
                .rotationEffect(Angle.degrees(isRotatingFast ? 360 : 0))
            Circle()
                .trim(from: 0.60, to: 1)
                .stroke(Color.secondaryColor.opacity(0.95), style: StrokeStyle(lineWidth: 5))
                .frame(width: 30, height: 30)
                .rotationEffect(Angle.degrees(isRotating ? 360 : 0))
        }
        .onAppear {
            withAnimation(Animation.rotateAnimation) {
                isRotating = true
            }
            withAnimation(Animation.rotateAnimationFast) {
                isRotatingFast = true
            }
        }
    }
}
