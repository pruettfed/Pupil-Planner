//
//  TasksPageView.swift
//  Pupil Planner
//
//  Created by Pruett Fedorowicz on 4/11/23.
//

import SwiftUI

struct TasksPageView: View {
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    @State var selectedSection = 0
    
    var body: some View {
        VStack(spacing: 14) {
            TopBar(pageName: "Tasks")
            
            // Completed/Incomplete Picker
            HStack {
                Button(action: {
                    selectedSection = 0
                }) {
                    Text("Current")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 52)
                        .padding(.vertical, 6)
                        .background(Color.blue.gradient.opacity(selectedSection == 0 ? 1 : 0))
                        .clipShape(Capsule())
                        .padding(.leading, 6)
                        .shadow(color: selectedSection == 0 ? Color("BlueGradientBottom").opacity(0.3) : Color.black.opacity(0), radius: 7, y: 3)
                }
                
                Spacer()
                
                Button(action: {
                    selectedSection = 1
                }) {
                    Text("Completed")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 52)
                        .padding(.vertical, 6)
                        .background(Color.blue.gradient.opacity(selectedSection == 1 ? 1 : 0))
                        .clipShape(Capsule())
                        .padding(.trailing, 6)
                        .shadow(color: selectedSection == 1 ? Color("BlueGradientTop").opacity(0.3) : Color.black.opacity(0), radius: 7, y: 3)
                }
            }
            .padding(.vertical, 6)
            .background(Color("Background Color Accent"))
            .clipShape(Capsule())
            .padding(.horizontal, 18)
            
            // Scrolling page
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 23) {
//                    let currentGroup = groupTasksByDate(tasks: tasks.items)
                    
                    // Small task card
                    if selectedSection == 0 {
                        ForEach(tasks) { group in
                            TaskList(tasks: [group], date: [group].first?.dueDate ?? Date())
                        }
                    }
                    else {
                        ForEach(tasks) { group in
                            TaskList(tasks: [group], date: [group].first?.dueDate ?? Date())
                        }
                    }
                }
                .padding(.top, 18)
                .padding(.bottom, 120)
                .rowShadow()
            }
            .background(Color("Background Color Accent"))
            .cornerRadius(30.0)
            .shadow(radius: 15)
        }
        .background(Color("Background Color"))
        .ignoresSafeArea()
    }
}


struct TasksPageView_Previews: PreviewProvider {
    static var previews: some View {
        TasksPageView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.dark)
    }
}

//func groupTasksByDate(tasks: [Task]) -> (current: [[Task]], completed: [[Task]]) {
//    let groupByDate = Dictionary(grouping: getCurrentTasks(tasks: tasks).0) { toStartOfDay(date: $0.dueDate) }
//
//    var groupedTasks = [[Task]]()
//    var groupedCompletedTasks = [[Task]]()
//
//    //for all current tasks
//    let sortedKeys = groupByDate.keys.sorted()
//
//    //for each item sort by key (date) and append the array onto larger array, groupTasks
//    sortedKeys.forEach { (key) in
//        let values = groupByDate[key]
//
//        groupedTasks.append(values ?? [])
//    }
//
//    //for completed tasks
//    let pastGroupByDate = Dictionary(grouping: getCurrentTasks(tasks: tasks).1) { toStartOfDay(date: $0.dueDate) }
//
//    let completedSortedKeys = pastGroupByDate.keys.sorted(by: >)
//
//    completedSortedKeys.forEach { (key) in
//        let pastValues = pastGroupByDate[key]
//
//        groupedCompletedTasks.append(pastValues ?? [])
//    }
//
//    return (groupedTasks, groupedCompletedTasks)
//}
//
//func getCurrentTasks(tasks: [Task]) -> ([Task], [Task]) {
//
//    var currentArray : [Task] = []
//    var completedArray : [Task] = []
//
//    for task in tasks {
//        if !task.isCompleted {
//            currentArray.append(task)
//        }
//        else if task.isCompleted {
//            completedArray.append(task)
//        }
//    }
//
//    currentArray.sort(by: {$0.dueDate < $1.dueDate})
//    completedArray.sort(by: {$0.dueDate < $1.dueDate})
//
//    return (currentArray, completedArray)
//}
//

struct TaskList : View {
    let todaysDate = Date()

    let tasks : [Task]
    let date : Date
    
    var body: some View {
        let daysBetween = numberOfDaysBetween(startDate: todaysDate, toDate: date)
        
        let daysBetweenColor = setBetweenColor(daysBetween: daysBetween)
        
        //Date Header
        VStack(spacing: 8) {
            HStack {
                Text(dateToDayOfWeek(dateString: date))
                    .font(.title2)
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                Text(date, style: .date)
                    .font(.callout)
                    .foregroundColor(Color("Text Accent"))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Spacer()
                
                //Days between marker
                HStack {
                    Text(setBetweenString(daysBetween: daysBetween))
                        .font(.caption)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 9)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                }
                .foregroundColor(Color("\(daysBetweenColor)GradientTop"))
                .background(Color("\(daysBetweenColor)GradientTop").opacity(0.2))
                .clipShape(Capsule())
                .padding(.bottom, 4)

            }
            .padding(.leading, 5)
            
            //Array of tasks
            VStack(spacing: 18) {
                ForEach(tasks, id: \.name) { task in
                    Text(task.name ?? "Failed")
                }
            }
        }
        .padding(.horizontal, 18)
    }
}
