import SwiftUI

/**
 TODO: 🚧 WIP 🚧
 */

/**
 public struct Avatar<Fallback>: NeoBrutalismBase, View where Fallback: View {
     private let imgUrl: URL
     private let fallback: Fallback

     var size: CGFloat { 40.0 }

     public init(imgUrl: URL, @ViewBuilder fallback: () -> Fallback = { Color.black }) {
         self.imgUrl = imgUrl
         self.fallback = fallback()
     }

     public var body: some View {
         ZStack {
             AsyncImage(url: imgUrl) { image in
                 image
                     .resizable()
                     .aspectRatio(contentMode: .fill)
             } placeholder: {
                 ZStack {
                     Theme.standard.dark
                     fallback
                         .foregroundStyle(Theme.standard.textDark)
                 }
                     .frame(width: size, height: size)
             }
         }
         .overlay {
             Circle()
                 .stroke(Theme.standard.border, lineWidth: strokeWidth)
         }
         .cornerRadius(size)
         .frame(width: size, height: size)
     }
 }

 @available(iOS 17.0, *)
 #Preview {
     VStack(spacing: 18.0) {
         Avatar(imgUrl: URL(filePath: "https://avatar.iran.liara.run/public/19")!) {
             Text("LoL")
         }

         Avatar(imgUrl: URL(filePath: "https://via.placeholder.com/100")!)

         Spacer()
     }.padding()
 }
 */
