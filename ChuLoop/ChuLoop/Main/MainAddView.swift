//
//  MainAddView.swift
//  ChuLoop
//
//  Created by Anna Kim on 2023/04/29.
//

import SwiftUI

struct MainAddView: View {
    
    
    // to go back on the home screen when the user is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var category: String = ""
    @State private var image = UIImage()
    @State private var imageName: String = ""
    @State private var content: String = ""
    
    @State private var showSheet = false
    
    var body: some View{
        VStack {
            TextField("맛집 이름을 작성하세요.", text: $name)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
            
            TextField("주소", text: $address)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
            
            TextField("카테고리", text: $category)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
            
            TextField("이미지 이름", text: $imageName)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
//            TextField("content", text: $content)
            TextEditor(text: $content)
                .frame(minHeight: 40, maxHeight: 200)
                .border(Color.gray, width: 0.8)
            
            Text("pick photo!")
                .font(.headline)
                .frame(height: 50)
                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(16)
                .foregroundColor(.white)
                .onTapGesture {
                    showSheet = true
                }
            
            Image(uiImage: self.image)
                .resizable()
                .cornerRadius(50)
                .padding(.all, 4)
                .frame(width: 100, height: 100)
                .background(Color.black.opacity(0.2))
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .padding(8)
                .sheet(isPresented: $showSheet) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                }
            
            Button(action: {
                DBStore().addWish(nameValue: name, addressValue: address, imageValue: image, imageNameValue: imageName, contentValue: content, categoryValue: category)
            }) {
                Text("Insert!")
            }
            
        }
    }
}





struct MainAddView_Previews: PreviewProvider {
    static var previews: some View {
        MainAddView()
    }
}


class MainViewModel: ObservableObject {
    func itemdownloaded(items: [Store]) {
        // Handle downloaded items here
    }
   
}
