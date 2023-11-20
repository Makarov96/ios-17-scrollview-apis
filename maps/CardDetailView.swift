//
//  CardDetailView.swift
//  maps
//
//  Created by Guerin Steven Colocho Chacon on 16/11/23.
//

import SwiftUI
import MapKit

struct CardDetailView: View {
    @Environment(Helper.self) private var helper
    @Namespace var nameSpaceTwo
    var nameSpace:Namespace.ID
    var helper2 = HelperDetailView()
    @State private var position: MapCameraPosition = .automatic
    @State private var dragAmount = CGSize.zero
    @State private var dragReduce = CGSize.zero
    @State private var expandView:Bool = false

   @State private var originalFrame: CGSize = CGSize(width: 300, height:380)
   
    
    var frame: CGSize{
        
        if expandView {
            return CGSize(width: 450, height: 560)
           
        }else {
            if  helper.incrementSize  {
                return CGSize(width: 350, height: 430)
            }else {
                return CGSize(width: 0, height: 0)
            }
        }
       
    }
    
    
    
    var body: some View {
        ZStack{
            
            Color.black.opacity(0.9).ignoresSafeArea()
          
          
            if expandView {
                Map(position:$position)
                    .opacity(expandView ? 1 : 0)
                  
                    .mapStyle(.standard()).onAppear(perform: {
                        position = .region(MKCoordinateRegion(center: helper.city.direction, span: .begin))
                    })
                    .colorScheme(.dark)
                    .frame(width: 450, height: 500)
                    .padding(.top, 400)
                    .animation(.spring().delay(5), value: expandView)
                
            }else {
                ScrollView(showsIndicators: false){
                    LazyVStack{
                        ForEach(Array(helper.city.reviews.enumerated()), id: \.1.id) { index, review in
                          
                            HStack{
                                AsyncImage(url: URL(string: review.user)) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 55, height: 55)
                                } placeholder: {
                                    ProgressView().progressViewStyle(.circular)
                                        .frame(width: 55, height: 55)
                                        .redacted(reason: .placeholder)
                                        
                                }

                                Text(review.description).font(.caption).foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: 300, alignment:.leading)
                                    .padding(.bottom, 15)
                            }
                            
                          
                        }.frame(maxWidth: 300)
                        
                    }
                }
                .padding([.top,],expandView ? 130 : 280)
                .frame(width: frame.width, height: frame.height)
                .background(.white)
                .cornerRadius(expandView ? 20 : 10)
                .padding(.top,200)
                .animation(.spring().delay(5), value: expandView)
                .opacity(expandView ? 0 : 1)
             
                   
            }
        
            
            
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)) .animation(.interpolatingSpring(.smooth), value: expandView)
                //.opacity(expandView ? 0 : 1)
                .frame(width: 250, height: 380)
                .overlay(content: {
                    Image(helper.city.cityPhoto).resizable()
                    
                        .cornerRadius(10)
                        .frame(width: originalFrame.width, height:originalFrame.height)
                        
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: expandView)
          
                       
                   
                })
            
                .matchedGeometryEffect(id: helper.city.id                     , in: nameSpace)
                .foregroundColor(.clear)
                .transition(.scale)
                .padding(.bottom, helper.incrementSize ? 100 : 0)
                .offset(dragAmount)
                .offset(y: expandView ?  -200 : 0)
                .animation(.linear, value:dragReduce)
                .onTapGesture {
                  
                    withAnimation(.linear) {
                        
                     
                        
                        if expandView {
                            dragAmount = .zero
                            expandView = false
                        originalFrame  = CGSize(width: 300, height:380)
                        
                        }else {
                             helper.incrementSize = false
                             //helper.incrementSize.toggle()
                             helper.isSelected = false
                        }
                
                   
                    }
                }
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global).onChanged({ value in
                
                    if value.location.y < 700 {
                    
                        withAnimation(.easeOut) {
                            dragAmount.height = value.translation.height
                        }
                    }
                    if value.location.y < 350{
                        withAnimation(.spring().delay(0.04)) {
                            expandView = true
                            originalFrame.width = 500
                            originalFrame.height = 460
                            
                        }
                    }
                    
                   
                    
                      
                  
                }).onEnded({ value in
                    
                    if expandView {
                        dragAmount = .zero
                      
                    }
                    if value.location.y < 300 {
                        return
                    }else {
                        withAnimation(.easeInOut) {
                            dragAmount = .zero
                            expandView = false
                        originalFrame  = CGSize(width: 300, height:380)
                        }
                    }
                }))
      
        }
    }
}

struct CardDetailTest:View{
    @Namespace var namespace
    var body: some View{
        
        
        CardDetailView(nameSpace: namespace).environment(Helper())
    }
}

#Preview {
    CardDetailTest()
}
