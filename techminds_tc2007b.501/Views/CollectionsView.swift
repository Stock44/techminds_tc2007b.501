//
//  CollectionsView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 18/05/23.
//

import SwiftUI

struct CollectionsView: View {
    var body: some View {
            Grid {
                GridRow {
                    Button {
                        ""
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 350, height: 230)
                                .foregroundColor(Color("accent1 lighter"))
                            Text("Lorem ipsum")
                                .font(.custom("Comfortaa", size: 36))
                                .foregroundColor(Color("accent1 darker"))
                        }
                            
                    }
                    
                    Button {
                        ""
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 350, height: 230)
                                .foregroundColor(Color("primary lighter"))
                            Text("Lorem ipsum")
                                .font(.custom("Comfortaa", size: 36))
                                .foregroundColor(Color("primary darker"))
                        }
                            
                    }
                    
                    Button {
                        ""
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 350, height: 230)
                                .foregroundColor(Color("secondary lighter"))
                            Text("Lorem ipsum")
                                .font(.custom("Comfortaa", size: 36))
                                .foregroundColor(Color("secondary lighter"))
                        }
                            
                    }
                }
                GridRow {
                    Button {
                        ""
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 350, height: 230)
                                .foregroundColor(Color("accent2 lighter"))
                            Text("Lorem ipsum")
                                .font(.custom("Comfortaa", size: 36))
                                .foregroundColor(Color("accent2 darker"))
                        }
                            
                    }
                    
                    Button {
                        ""
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 350, height: 230)
                                .foregroundColor(Color("secondary lighte"))
                            Text("Lorem ipsum")
                                .font(.custom("Comfortaa", size: 36))
                                .foregroundColor(Color("secondary lighte"))
                        }
                            
                    }
                    
                    Button {
                        ""
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 350, height: 230)
                                .foregroundColor(Color("accent2 lighter"))
                            Text("Lorem ipsum")
                                .font(.custom("Comfortaa", size: 36))
                                .foregroundColor(Color("accent2 darker"))
                        }
                            
                    }
                }
                GridRow {
                    Button {
                        ""
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 350, height: 230)
                                .foregroundColor(Color("primary lighter"))
                            Text("Lorem ipsum")
                                .font(.custom("Comfortaa", size: 36))
                                .foregroundColor(Color("primary darker"))
                        }
                    }
                    
                    Button {
                        ""
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 350, height: 230)
                                .foregroundColor(Color("accent1 lighter"))
                            Text("Lorem ipsum")
                                .font(.custom("Comfortaa", size: 36))
                                .foregroundColor(Color("accent1 darker"))
                        }
                            
                    }
                    
                    Button {
                        ""
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 350, height: 230)
                                .foregroundColor(Color("accent2 lighter"))
                            Text("Lorem ipsum")
                                .font(.custom("Comfortaa", size: 36))
                                .foregroundColor(Color("accent2 darker"))
                        }
                            
                    }
                }
            }.navigationTitle("Colecciones")
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
    }
}
