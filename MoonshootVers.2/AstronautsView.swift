//
//  AstronautsView.swift
//  MoonshootVers.2
//
//  Created by Дарья Осипова on 17.06.2021.
//

import SwiftUI

/// Отдельная структура экрана Астронавтов
struct AstronautView: View {
  
  /// Экземпляр структуры астронавт
  let astronaut: Astronaut
  
  /// Миссии астронавтов challenge 2
  let missions: [Mission]
  
  init(astronaut: Astronaut) {
    self.astronaut = astronaut

// Отображаем все миссии, в которых летал космонавт
    var matches = [Mission] ()
    
    let missions = Missions.missions
           for mission in missions {
               if mission.crew.first(where: { $0.name == astronaut.id }) != nil {
                   matches.append(mission)
               }
           }
    self.missions = matches
  }
            
           
  

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                  
                  
// Отображение всех миссий, в которых летал космонавт challenge 2
                  ForEach(self.missions) { mission in
                    HStack {
                      Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                      Text(mission.displayName)
                        .font(.headline)
                      
                      Spacer()
                      
                        .padding(.horizontal)
                    }
                    
                  }
                  
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautsView_Previews: PreviewProvider {
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

      static var previews: some View {
          AstronautView(astronaut: astronauts[0])
      }
}
