//
//  CustomViewModifiers.swift
//  Golf Tournament App
//
//  Created by Michael Whiting on 3/6/23.
//

import SwiftUI

// MARK: View Extensions

extension View {
    func roundDarkButton() -> some View {
        modifier(RoundedDarkButton())
    }
    
    func editDivideLine(width: Double) -> some View {
        modifier(DividerLine(width: width))
    }
    
    func clearTextField(show: Bool, text: String) -> some View {
        modifier(ClearTextField(showPlaceholder: show, placeholder: text))
    }
    
    func largeText() -> some View {
        modifier(LargeText())
    }
    
    func leftLeadingText() -> some View {
        modifier(LeftLeadingText())
    }
    
    func squareSecondaryTextField(width: CGFloat, height: CGFloat, show: Bool, text: String) -> some View {
        modifier(SquareSecondaryTextField(width: width, height: height, showPlaceholder: show, placeholder: text))
    }
}


// MARK: View Modifier Structs

struct RoundedDarkButton: ViewModifier {
    // Creates a rounded button using the secondary color
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.white)
            .buttonBorderShape(.roundedRectangle(radius: 25))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.secondaryColor)
            )
    }
}

struct ClearTextField: ViewModifier {
    var showPlaceholder: Bool // pass in bindingString.isEmpty
    var placeholder: String // text you want to be placeholder
    
    // Creates a clear background, with working placeholder text
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
                .textFieldStyle(.plain)
                .frame(maxWidth: 300)
                .background(.clear)
                .foregroundColor(.white)
            if showPlaceholder {
                Text(placeholder)
                    .foregroundColor(.white.opacity(0.3))
            }
        }
    }
}

struct DividerLine: ViewModifier {
    var width: Double

    func body(content: Content) -> some View {
        content
            .frame(width: width, height: 0.75)
            .padding(.horizontal, 30)
            .background(Color.white)
    }
}

struct LargeText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding()
            .font(.system(size: 22))
    }
}

struct LeftLeadingText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.white)
            .font(.title)
            .padding(.leading)
            .padding(.trailing)
    }
}

struct SquareSecondaryTextField: ViewModifier {
    var width: CGFloat
    var height: CGFloat
    var showPlaceholder: Bool
    var placeholder: String
    
    func body(content: Content) -> some View {
        ZStack {
            Text("")
                .frame(width: width, height: height)
                .background(Color.secondaryColor)
            content
                .frame(width: width - 30, height: height)
                .foregroundColor(.white)
            if showPlaceholder {
                Text(placeholder)
                    .frame(width: width, height: height, alignment: .leading)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.leading, 30)
            }
        }
    }
}

