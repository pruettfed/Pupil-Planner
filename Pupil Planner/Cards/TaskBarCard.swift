//
//  TaskBarCard.swift
//  Pupil Planner
//
//  Created by Pruett Fedorowicz on 4/11/23.
//

import SwiftUI

struct TaskBarCard: View {
    @ObservedObject var task: Task
    
    var body: some View {
        let color = task.category?.color ?? "Blue"

        HStack(spacing: 10) {
            Button(action: { task.isCompleted.toggle() }) {
                if task.isCompleted {
                    RoundedRectangle(cornerRadius: 10)
                        .gradientForeground(color: color)
                        .aspectRatio(contentMode: .fit)
                        .overlay(
                            Image(systemName: "checkmark")
                            .font(.system(size: 12).weight(.black))
                            .shadow(radius: 2, y: 2)
                            .foregroundColor(.white)
                        )
                }
                else {
                    RoundedRectangle(cornerRadius: 10)
                        .gradientStroke(color: color, width: 4.5)
                        .background(
                            Circle()
                                .foregroundColor(Color(color + "GradientBottom"))
                                .opacity(0.3))
                        .aspectRatio(contentMode: .fit)
                }
            }
            .padding([.top, .leading, .bottom], 14)
            
            
            Text(task.category?.icon ?? "🎓")
            
            HStack {
                Text(task.name ?? "Assignment")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
            .padding(.vertical, 12)
            .lineLimit(2)
            .minimumScaleFactor(0.75)
            
            Spacer()
            
            if task.subtasks?.count ?? 0 > 0 {
                HStack(spacing: 3) {
                    Text("\(task.subtasks?.count ?? 0)")
                        .font(.system(size: 14, weight: .medium))
                    Image(systemName: "list.bullet.indent")
                        .imageScale(.small)
                        .font(.system(size: 18, weight: .bold))

                }
                .foregroundColor(.gray)
            }
            
            let taskPriority = getTaskPriority(priority: task.priority)
            if taskPriority != nil {
                Image(systemName: taskPriority!) // No need to unwrap
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.gray)
            }
            
            let taskIcon = (task.type ?? "Task")
            Image(systemName: TaskType[taskIcon] ?? "questionmark.square.dashed")
                .imageScale(.small)
                .padding(.trailing, 18.0)
                .foregroundColor(.gray)
        }
        .frame(height: 60)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("Background Color"))
        )    }
}

struct TaskBarCard_Previews: PreviewProvider {
    static var previews: some View {
        let moc = PersistenceController.preview.container.viewContext
        
        TaskBarCard(task: Task(context: moc))
    }
}

private func getTaskPriority(priority: Int64) -> String? {
    switch priority {
    case 1:
        return "exclamationmark"
    case 2:
        return "exclamationmark.2"
    case 3:
        return "exclamationmark.3"
    default:
        return nil
    }
}
