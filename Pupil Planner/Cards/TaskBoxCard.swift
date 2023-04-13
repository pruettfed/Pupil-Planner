//
//  TaskBoxCard.swift
//  Pupil Planner
//
//  Created by Pruett Fedorowicz on 4/11/23.
//

import SwiftUI

struct TaskBoxCard: View {
    @State var task: Task
    
    var body: some View {
        let daysBetween = numberOfDaysBetween(startDate: Date(), toDate: task.dueDate ?? Date())
        let daysBetweenColor = setBetweenColor(daysBetween: daysBetween)
        
        VStack {
            Text(task.category?.icon ?? "🎓")
                .font(.system(size: 20))
                .shadow(color: .black, radius: 10, y: 7)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .gradientForeground(color: task.category?.color ?? "Blue"))
                .padding(.top, 16)
            
            Spacer()
            
            Text(task.name ?? "Assignment")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.vertical,4)
                .lineLimit(3)
                .minimumScaleFactor(0.6)
            
            Spacer()
            
            // Completed check
            HStack (spacing: 4) {
                if task.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 9, weight: .heavy))
                }
                
                Text(setBetweenString(daysBetween: daysBetween))
                    .font(.system(size: 9))
                    .fontWeight(.medium)
                    .padding(.vertical, 6)
                    .scaledToFit()
                    .minimumScaleFactor(0.5)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(
                Color("\(daysBetweenColor)GradientTop"))
            .background(
                Color("\(daysBetweenColor)GradientTop").opacity(0.2))
            .clipShape(Capsule())
            .padding([.leading, .bottom, .trailing], 12.0)
        }
        .frame(width: 130, height: 180)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .foregroundColor(Color("Background Color"))
        )
    }
}

struct TaskBoxCard_Previews: PreviewProvider {
    static var previews: some View {
        let moc = PersistenceController.preview.container.viewContext
        
        TaskBoxCard(task: Task(context: moc))
    }
}
