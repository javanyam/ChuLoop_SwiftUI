//
//  MainView.swift
//  ChuLoop
//
//  Created by Anna Kim on 2023/04/29.
//

import SwiftUI

struct MainView: View {
    
    @State var storeModels: [Article] = []
    
    var body: some View {
        
        NavigationView {
            
            GeometryReader { geometry in
                List {
                        ForEach(storeModels, id: \.pId) { storeModel in
                            VStack {
                                SeparateView(
                                    category: storeModel.pCategory,
                                    store: storeModel.pStore,
                                    address: storeModel.pAddress,
                                    image: storeModel.pImage!
                                )
                                    
                                .frame(height:geometry.size.height / 2.2, alignment: .center)
                            Rectangle()
                                .fill(.white)
                                .overlay(
                                    ExpandableTextView(storeModel.pContent, lineLimit: 3)
                                        .foregroundColor(.black)
                                )
                                .frame(height: geometry.size.height / 7, alignment: .center)
                                .padding(15)
                            }
                            
                        }
                    .listRowInsets(EdgeInsets.init())
                    
                }
                .listStyle(.plain)
                .background(.white)
                .scrollContentBackground(.hidden)
                    .navigationBarTitle("Main", displayMode: .inline)
                    .navigationBarItems(
                        trailing:
                            NavigationLink(
                                destination: MainAddView(),
                                label: {
                                    Image(systemName: "plus")
                                }
                            )
                )
            }
            }
        .onAppear(perform: {
            self.storeModels = DBStore().getWish()
        })
            
        }
    }

    



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}




struct ExpandableTextView: View {
    
  @State private var expanded: Bool = false
  @State private var truncated: Bool = false
  @State private var shrinkText: String
  @State private var isRendered: Bool = false

    
  public var text: String
  let lineLimit: Int
    
    
  public var moreLessText: String {
    if !truncated {
      return " "
    } else {
      return self.expanded ? "" : "더보기"
    }
  }

  let font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)

  init(_ text: String, lineLimit: Int) {
    self.text = text
    self.lineLimit = lineLimit
    _shrinkText = State(wrappedValue: text)
  }

  var body: some View {
      Group {
          // 텍스트를 자를 필요 없는 경우
        if !truncated {
          Text(text)
            
        } else {
            // 텍스트를 잘라야 하는 경우: '더보기'와 함께 보여줌
          Text(self.expanded ? text : (shrinkText + "... "))
              + Text(moreLessText)
              .underline()
        }
      }
          .font(Font(font))
          .multilineTextAlignment(.leading)
          .lineSpacing(4)
          .lineLimit(expanded ? nil : lineLimit)
          .onTapGesture {
            if truncated {
              expanded.toggle()
            }
          }
          .background(
              Text(text)
                  .lineSpacing(4)
                  .multilineTextAlignment(.leading)
                  .lineLimit(lineLimit)
                  .background(GeometryReader { visibleTextGeometry in
                    Color.clear
                        .onChange(of: isRendered) { _ in
                          guard isRendered else {
                            return
                          }
                          let size = CGSize(width: visibleTextGeometry.size.width, height: .greatestFiniteMagnitude)
                          let style = NSMutableParagraphStyle()
                          style.lineSpacing = 4
                            // 한글로 된 줄 수를 체크하기 위함
                          style.lineBreakStrategy = .hangulWordPriority
                          let attributes: [NSAttributedString.Key: Any] = [
                            NSAttributedString.Key.font: font,
                            NSAttributedString.Key.paragraphStyle: style
                          ]

                          /// Line Limit 내에서 문제 없이 보여질 경우 체크
                          let pureAttributedText = NSAttributedString(string: shrinkText, attributes: attributes)
                          let pureBoundingRect = pureAttributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                          if abs(pureBoundingRect.size.height - visibleTextGeometry.size.height) < 1 {
                            return
                          }

                          /// Binary Search 방식으로 '... 더보기'로 라인이 적절히 끊길 수 있는 index를 찾는다
                          var low = 0
                          var height = shrinkText.count
                          var mid = height
                          while ((height - low) > 1) {
                            let attributedText = NSAttributedString(string: shrinkText + "... " + moreLessText, attributes: attributes)
                            let boundingRect = attributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                            if boundingRect.size.height > visibleTextGeometry.size.height {
                              truncated = true
                              height = mid
                              mid = (height + low) / 2
                            } else {
                              if mid == text.count {
                                break
                              } else {
                                low = mid
                                mid = (low + height) / 2
                              }
                            }
                            shrinkText = String(text.prefix(mid))
                          }
                        }
                        .onAppear {
                          isRendered = true
                        }
                  })
                  .hidden() // Hide the background
          )
  }
}
