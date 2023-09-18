//
//  ContentView.swift
//  Memorize
//
//  Created by Ramazan Zypayev on 9/18/23.
//

import SwiftUI

struct ContentView: View {
    @State var vehicleEmojis = ["🚘", "🚃", "✈️", "⛵️", "🚤", "🚂", "🚡", "🛺", "🛴", "🦼", "🚜", "🚌"]
    @State var activityEmojis = ["🎻", "🎭", "🚵‍♀️", "🚣", "🧘", "🏋️", "🥊", "🛝", "🏹", "🏒", "🏈", "⚽️"]
    @State var foodEmojis = ["🍺", "🎂", "🥪", "🍝", "🍉", "🌶️", "🥦", "🍌", "🍔", "🌽", "🍳", "🥞"]
    
    @State var currentCardsView: String = ""
    var body: some View {
        VStack {
            Text("Memorize!")
                .foregroundColor(.red)
                .font(.largeTitle)
            Spacer()
            switch currentCardsView {
            case "vehicle":
                ScrollView{
                    vehicleCards
                }
            case "activity":
                ScrollView{
                    activityCards
                }
            case "food":
                ScrollView{
                    foodCards
                }
            default:
                EmptyView()
            }
            HStack {
                VStack{
                    Button(action: {
                        vehicleEmojis.shuffle()
                        currentCardsView = "vehicle"
                    }, label: {
                        Image(systemName: "car.fill")
                    })
                    Text("Vehicle")
                }
                VStack{
                    Button(action: {
                        activityEmojis.shuffle()
                        currentCardsView = "activity"
                        
                    }, label: {
                        Image(systemName: "figure.run")
                    })
                    Text("Activity")
                }
                VStack{
                    Button(action: {
                        foodEmojis.shuffle()
                        currentCardsView = "food"
                    }, label: {
                        Image(systemName: "carrot.fill")
                    })
                    Text("Food")
                }
            }
            .imageScale(.large)
        }
        .padding()
    }

    func cardThemeChanger(to themeEmojis: [String]) -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(0..<themeEmojis.count, id: \.self) { index in
                CardView(emoji: themeEmojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.red)
    }
    
    var vehicleCards: some View {
        cardThemeChanger(to: vehicleEmojis)
    }
    
    var activityCards: some View {
        cardThemeChanger(to: activityEmojis)
    }
    
    var foodCards: some View {
        cardThemeChanger(to: foodEmojis)
    }
}



struct CardView: View {
    @State var isFaceUp = false
    let emoji: String
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(emoji).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
