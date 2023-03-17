//
//  ContentView.swift
//  sticker
//
//  Created by Hassan Raza on 3/9/23.
//

import SwiftUI

struct Sticker: View {
    @State private var location: CGPoint = CGPoint(x: 50, y: 50)
    
    @GestureState private var startLocation: CGPoint? = nil // 1
    @GestureState private var startSize: CGSize? = nil // 1
    @State private var size: CGSize = CGSize(width: 100, height: 100)
    @State var isHidden = true
    @State var isSelected = false
    @State var text: String = ""
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                
                var newLocation = startLocation ?? location // 3
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.location = newLocation
            }
            .updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location // 2
            }
    }
    
    var borderDragGesture: some Gesture {
        DragGesture(coordinateSpace: .global)
            .onChanged { value in
                var newSize = startSize ?? size
                newSize.width = max(30, (value.translation.width + newSize.width))
                newSize.height = max(30, (value.translation.height + newSize.height))
                self.size = newSize
            }
            .updating($startSize) { (value, startSize, transaction) in
                startSize = startSize ?? size // 2
            }
    }
    
    
    var fontSizeRatio: CGFloat{
        size.width / size.height
    }
    
    func getFontSize(for size: CGSize) -> CGFloat {
        if size.width < size.height {
            return size.width
        }else{
            return size.height
        }
//        return fontSizeRatio
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Image("testImage")
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: .fill)
//                Rectangle()
//                TextField("", text: $text)
//                Text("WOW")
//                    .foregroundColor(.black)
//                    .frame(width: geometry.size.width, height: geometry.size.height)
//                    .font(.system(size: getFontSize(for: geometry.size)))
//                    .scaledToFill()
//                    .minimumScaleFactor(0.1)
                    
            }
            
            
        }
        .foregroundColor(.pink)
        .clipped()
        .padding(5)
        .overlay(
            ZStack(alignment: .bottomTrailing){
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.blue, lineWidth: 2)
                    .hidden(isHidden)
                    
                
                Circle()
                    .fill()
                    .foregroundColor(.blue)
                    .frame(width: 15.0, height: 15.0)
                    .position(x: size.width, y: size.height)
                    .gesture(borderDragGesture)
                    .hidden(!isSelected)
                
            }
                
                
            
        )
        .onTapGesture {
            isSelected = true
        }
        .onHover(perform: { value in
            if isSelected {
                isHidden = false
            }else{
                isHidden = !value
            }
        })
        
        .frame(width: size.width, height: size.height)
        .position(location)
        .gesture(simpleDrag)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Sticker()
    }
}

extension View {
  @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
    switch shouldHide {
      case true: self.hidden()
      case false: self
    }
  }
}
