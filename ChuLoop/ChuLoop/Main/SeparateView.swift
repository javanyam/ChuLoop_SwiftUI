//
//  SeparateView.swift
//  ChuLoop
//
//  Created by Anna Kim on 2023/04/29.
//

import SwiftUI

struct SeparateView: View {
    
    var category: String
    var store: String
    var address: String
    var image: Data
    
//    var store: Article
    
    
    var body: some View {
        GeometryReader { geometry in
                VStack(alignment: .leading) {
                    Image(uiImage: UIImage(data: image)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: geometry.size.height / 1.25)
                        .clipped()
                    Rectangle()
                        .overlay(
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack{
                                        Text(store)
                                            .foregroundColor(.primary)
                                            .fontWeight(.bold)
                                            .font(.system(size: 20))
                                        Spacer()
                                        Text(category)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Text(address)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.horizontal, 20)
                            }
                        )
                    }
                .foregroundColor(.white)
                }
        }
    }
