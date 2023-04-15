//
//  TodayPageView.swift
//  Pupil Planner
//
//  Created by Pruett Fedorowicz on 4/11/23.
//

import SwiftUI

struct TodayPageView: View {
    let todaysDate = Date()
    
    var body: some View {
        VStack(spacing: 14) {
            TopBar(pageName: "Today")
            
            // Scrolling Page
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    HStack {
                        Text("Today's Classes")
                            .scrollTextStyle()
                            .padding([.top, .leading], 23.0)
                        Spacer()
                    }
                    TodayClasses()
                    
                    HStack {
                        Text("Today's Tasks")
                            .scrollTextStyle()
                            .padding(.leading, 23.0)
                        Spacer()
                    }
                    TodayTasks(todaysDate: todaysDate)
                    
                    HStack {
                        Text("Upcoming Tasks")
                            .scrollTextStyle()
                            .padding(.leading, 23.0)
                        Spacer()
                    }
                    UpcomingTasks(todaysDate: todaysDate)
                }
                .padding(.bottom, 120)
            }
            .background(Color("Background Color Accent"))
            .cornerRadius(30.0)
            .shadow(radius: 15)
        }
        .background(Color("Background Color"))
        .ignoresSafeArea()
    }
}

struct TodayPageView_Previews: PreviewProvider {
    static var previews: some View {
        TodayPageView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.dark)
    }
}

struct TodayClasses : View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)]) var classes: FetchedResults<Category>
    
    var body: some View {
        if classes.count > 0 {
            TabView {
                ForEach(classes, id: \.self) { course in
                    Text(course.name ?? "Failed")
                }
                .rowShadow()
                .padding(.horizontal, 18)
                .padding(.bottom, classes.count == 1 ? 23 : 44)
            }
            .frame(height: classes.count == 1 ? 128 : 151)
            .padding(.top, 8)
            .tabViewStyle(.page)
        } else {
            EmptyItemsView(title: "No classes today 😁", caption: "Go have some fun!")
        }
    }
}

struct TodayTasks : View {
    // Get tasks due today
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.dueDate, ascending: true)],
        predicate: filterByToday()
    ) var todaysTasks: FetchedResults<Task>
    
    let todaysDate : Date
    
    var body: some View {
        if todaysTasks.count > 0 {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18) {
                    ForEach(todaysTasks, id: \.self) { task in
                        TaskBoxCard(task: task)
                            .drawingGroup()
                    }
                }
                .rowPadding()
                .rowShadow()
            }
        }
        else {
            EmptyItemsView(title: "Nothing's due today 👍", caption: "But check your upcoming tasks!")
        }
    }
}

struct UpcomingTasks : View {
    let todaysDate : Date
    
    // Get tasks not due today
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.dueDate, ascending: true)],
        predicate: filterByUpcoming()
    ) var upcomingTasks: FetchedResults<Task>
    
    var body: some View {
        if upcomingTasks.count > 0 {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18.0) {
                    ForEach(upcomingTasks, id: \.self) { task in
                        TaskBoxCard(task: task)
                            .drawingGroup()
                    }
                }
                .rowPadding()
                .rowShadow()
            }
        }
        else {
            EmptyItemsView(title: "No upcoming tasks 🥳", caption: "Give yourself a pat on the back!")
        }
    }
}
