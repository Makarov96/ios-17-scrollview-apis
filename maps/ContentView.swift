//
//  ContentView.swift
//  maps
//
//  Created by Guerin Steven Colocho Chacon on 11/11/23.
//

import SwiftUI
import MapKit


struct ContentView: View {
    @State private var position: MapCameraPosition = .automatic
    @State var scrollPosition: Int?
    @Namespace var nameSpace
    var helper = Helper()
    
    var body: some View {
        ZStack {

            Color.black.opacity(0.9).ignoresSafeArea()
            
            VStack{
                Text("\(City.this[scrollPosition ?? 0].cityName)")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .fontWeight(.black)
                    .frame(maxWidth: .infinity,maxHeight: 60,  alignment: .top)
                    .background(.ultraThinMaterial)
                    .animation(.spring(), value: scrollPosition)
                    .opacity(helper.isSelected ? 0 : 1)
                    
                    
                   Spacer()
            
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(alignment:.bottom){
                        ForEach(Array(City.this.enumerated()), id: \.1.id) { index, city in
                        
                                
                                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)).frame(width: 250, height: 380)
                                    .overlay(content: {
                                        Image(city.cityPhoto).resizable()
                                           
                                            .cornerRadius(10)
                                            .frame(width: 300, height:380)
                                    })
                                    .matchedGeometryEffect(id: city.id, in: nameSpace)
                                    .id(index)
                               
                                    .onTapGesture {
                                  
                                        withAnimation(.linear) {
                                         
                                                helper.city = city
                                                helper.isSelected = true

                                                position = .region(MKCoordinateRegion(center: helper.city.direction, span: .begin))
                                        
                                          
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                                            
                                            withAnimation(.easeInOut) {
                                                helper.incrementSize = true
                                            }
                                        })
                                    
                                }
                                    .environment(helper)
                                    .padding([.horizontal], 20)

                            
                        }
                        .scrollTransition { content, phase in
                            
                            content.scaleEffect(phase.isIdentity ? 1: 0.6).rotation3DEffect(.degrees(phase.value), axis: (x: 1, y: 1, z: 1))
                            
                        }
                        
                    }.scrollTargetLayout()
               
                    .safeAreaPadding([.horizontal], 80)
                }.scrollPosition(id: $scrollPosition)
                    .frame(height: 500)
                    .padding([.bottom], 200)
                
            }
        }
        
            .overlay {
                if helper.isSelected  {
                    CardDetailView(nameSpace: nameSpace).environment(helper)
                        
                }
            }
        
        
    }
}

#Preview {
    ContentView().colorScheme(.dark)
}
