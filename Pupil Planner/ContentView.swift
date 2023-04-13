//
//  ContentView.swift
//  Pupil Planner
//
//  Created by Pruett Fedorowicz on 4/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                
            switch selectedTab {
            case 0:
                TodayPageView()
            case 1:
                TasksPageView()
            case 2:
                PlannerPageView()
            default:
                TodayPageView()
            }

            MenuBar(selectedTab: $selectedTab)
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let moc = PersistenceController.preview.container.viewContext
        
        ContentView().environment(\.managedObjectContext, moc)
            .preferredColorScheme(.dark)
        
        
    }
}

struct MenuBar : View {
    @Binding var selectedTab : Int
    
    
    let tabs = ["graduationcap.fill", "bookmark.fill", "mail.stack.fill"]
    
    var body: some View {
        HStack {
            ForEach(0..<3) { num in
                Button(action: { selectedTab = num }) {
                    Spacer()
                    
                    // Tab icons
                    Image(systemName: tabs[num])
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(selectedTab == num ? Color("BlueGradientTop") : Color.gray.opacity(0.4))
                        .shadow(color: selectedTab == num ? Color("BlueGradientTop").opacity(0.25) : Color.black, radius: 7, y: 5)
                    
                    Spacer()
                }
            }
        }
        .padding([.leading, .bottom, .trailing], 16)
        .frame(height: 100)
        .background(Color("Background Color"))
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(radius: 10, y: -15)
    }
}
