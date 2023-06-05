//
//  CollectionsView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 18/05/23.
//

import SwiftUI

struct StudentCollectionsView: View {
    var body: some View {
        Grid (horizontalSpacing: 24, verticalSpacing: 24) {
            GridRow {
                CollectionButton(action: "", collectionColor: "accent1 lighter", collectionTitle: "Lorem ipsum", titleColor: "accent1 darker")
                
                CollectionButton(action: "", collectionColor: "primary lighter", collectionTitle: "Lorem ipsum", titleColor: "primary darker")
                
                CollectionButton(action: "", collectionColor: "secondary lighter", collectionTitle: "Lorem ipsum", titleColor: "secondary darker")
            }
            GridRow {
                CollectionButton(action: "", collectionColor: "accent2 lighter", collectionTitle: "Lorem ipsum", titleColor: "accent2 darker")
                
                CollectionButton(action: "", collectionColor: "secondary lighter", collectionTitle: "Lorem ipsum", titleColor: "secondary darker")
                
                CollectionButton(action: "", collectionColor: "accent2 lighter", collectionTitle: "Lorem ipsum", titleColor: "accent2 darker")
            }
            GridRow {
                CollectionButton(action: "", collectionColor: "primary lighter", collectionTitle: "Lorem ipsum", titleColor: "primary darker")
                
                CollectionButton(action: "", collectionColor: "accent1 lighter", collectionTitle: "Lorem ipsum", titleColor: "accent1 darker")
                
                CollectionButton(action: "", collectionColor: "accent2 lighter", collectionTitle: "Lorem ipsum", titleColor: "accent2 darker")
            }
        }
        .navigationTitle("Colecciones")
        .toolbar {
            ToolbarItemGroup (placement: .navigationBarTrailing){
                Button {
                    
                } label: {
                    Image("pencil")
                }
            }
        }
        .padding(EdgeInsets(top: 32, leading: 48, bottom: 32, trailing: 48))
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentCollectionsView()
    }
}
