//
//  TasksPageView.swift
//  Pupil Planner
//
//  Created by Pruett Fedorowicz on 4/11/23.
//

import SwiftUI

struct TasksPageView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.dueDate, ascending: true), NSSortDescriptor(keyPath: \Task.priority, ascending: true), NSSortDescriptor(keyPath: \Task.completionTime, ascending: true)],
        predicate: NSPredicate(format: "isCompleted == false")
    ) var incompleteTasks: FetchedResults<Task>

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.dueDate, ascending: true), NSSortDescriptor(keyPath: \Task.priority, ascending: true), NSSortDescriptor(keyPath: \Task.completionTime, ascending: true)],
        predicate: NSPredicate(format: "isCompleted == true")
    ) var completedTasks: FetchedResults<Task>
    
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
                        .background(Color.blue.opacity(selectedSection == 0 ? 1 : 0))
                        .clipShape(Capsule())
                        .padding(.leading, 6)
                        .shadow(color: selectedSection == 0 ? Color("BlueGradientTop").opacity(0.3) : Color.black.opacity(0), radius: 7, y: 3)
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
                        .background(Color.blue.opacity(selectedSection == 1 ? 1 : 0))
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
                    let groupedTasks = groupTasksByDate(incompleteTasks: incompleteTasks, completedTasks: completedTasks)
                    
                    // Small task card
                    if selectedSection == 0 {
                        ForEach(groupedTasks.incompleteGroup, id: \.self) { group in
                            TaskList(tasks: group, date: group.first?.dueDate ?? Date())
                        }
                    }
                    else {
                        ForEach(groupedTasks.completedGroup, id: \.self) { group in
                            TaskList(tasks: group, date: group.first?.dueDate ?? Date())
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

func groupTasksByDate(incompleteTasks: FetchedResults<Task>, completedTasks: FetchedResults<Task>) -> (incompleteGroup: [[Task]], completedGroup: [[Task]]) {
    var groupedIncomplete = [[Task]]() // Ex [[Task, Task], [Task]]
    var groupedComplete = [[Task]]() // Each array is grouped by date
    
    // For incomplete tasks
    let incompleteGroupByDate = Dictionary(grouping: incompleteTasks, by: { Calendar.current.startOfDay(for: $0.dueDate ?? Date()) }) // Group by date
    for key in incompleteGroupByDate.keys.sorted() {
        groupedIncomplete.append(incompleteGroupByDate[key]!)
    } // Sort and add to list
        
    // For completed tasks
    let completedGroupByDate = Dictionary(grouping: completedTasks, by: { Calendar.current.startOfDay(for: $0.dueDate ?? Date()) })
    for key in completedGroupByDate.keys.sorted() {
        groupedComplete.append(completedGroupByDate[key]!)
    }
        
        
    return (groupedIncomplete, groupedComplete)
}

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
                    TaskBarCard(task: task)
                }
            }
        }
        .padding(.horizontal, 18)
    }
}
