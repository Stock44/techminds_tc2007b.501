//
//  ContentView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 05/05/23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State var authUser: FirebaseAuth.User?
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [
            .font : UIFont(name: "Comfortaa", size: 48)!,
        ]
        navBarAppearance.titleTextAttributes = [
            .font : UIFont(name: "Comfortaa-SemiBold", size: 32)!,
        ]
        
        navBarAppearance.layoutMargins = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 48)
        
        Auth.auth().addStateDidChangeListener(self.onAuthStateChange)
    }
    
    func onAuthStateChange(auth: Auth, authUser: FirebaseAuth.User?) {
        self.authUser = authUser
    }
    
    var body: some View {
        NavigationView {
            if self.authUser != nil {
                MainMenuView()
            } else {
                LogInView()
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
