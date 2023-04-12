//
//  TopBar.swift
//  Pupil Planner
//
//  Created by Pruett Fedorowicz on 4/11/23.
//

import SwiftUI

struct TopBar: View {
    var pageName: String = "Page"
    var date = Date()
    
    
    var body: some View {
        //topbar
        HStack(alignment: .bottom) {
            //date
            VStack(alignment: .leading, spacing: 5.0){
                Text(date, style: .date)
                    .font(.system(size: 16).weight(.bold))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.leading)
                //pagename
                Text(pageName)
                    .font(.system(size: 48))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            Button(action: {}) {
                Text("🎓")
                    .font(.system(size: 30))
                    .shadow(radius: 5, y: 5)
                    .padding(16.0)
                    .background(Color("Background Color Accent"))
                    .cornerRadius(18)
                    .foregroundColor(Color("Text Accent"))
                    .padding(.bottom, 8)
                    .shadow(radius: 15, y: 5)
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 56)
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar(pageName: "Today")
            .preferredColorScheme(.dark)
    }
}
