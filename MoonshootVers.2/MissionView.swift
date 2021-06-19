//
//  MissionView.swift
//  MoonshootVers.2
//
//  Created by Дарья Осипова on 17.06.2021.
//

import SwiftUI

struct MissionView: View {
  
  /// Члены экипажа
  struct CrewMember {
    /// Роль ( командир..)
    let role: String
    
    /// Отсылка к конкретному астронавту
    let astronaut: Astronaut
  }
  
  /// Параметр миссия с отсылкой к структуре
  let mission: Mission
  
  /// Парамет астронавт с отсылкой к массиву членов экипажа
  var astronauts = [CrewMember]()
  
  
  init(mission: Mission, astronauts: [Astronaut]) {
    self.mission = mission
    
    var matches = [CrewMember] ()
    
    for member in mission.crew{
      if let match = astronauts.first(where: { $0.id == member.name }) {
        matches.append(CrewMember(role: member.role, astronaut: match))
      } else {
        fatalError("Missing \(member)")
      }
    }
    self.astronauts = matches
  }
    var body: some View {

// Прокручиваемый VStack с изменяемым размером изображения для значка миссии, затем текстовое представление, затем разделитель, чтобы все было перемещено в верхнюю часть экрана
      GeometryReader {geometry in
        ScrollView(.vertical) {
          VStack {
            Image(self.mission.image)
              .resizable()
              .scaledToFit()
              .frame(maxWidth: geometry.size.width * 0.7)
              .padding(.top)
            
            
// Добавление даты под значком миссии challenge 1
            Text(self.mission.formattedLaunchDate)
              .font(.headline)
              .padding()
            
            Text(self.mission.description)
              .padding()
            
// Добавляем цикл с данными об астронавтах (их ролях), в горизонтальный стек вводим картинку самого астронавта, используя форму зажима капсулы и наложение. В вертикальном стеке записываем имя и роль астронавта
            ForEach(self.astronauts, id: \.role) { crewMember in
            NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
              HStack{
                Image(crewMember.astronaut.id)
                  .resizable()
                  .frame(width: 83, height: 60)
                  .clipShape(Capsule())
                  .overlay(Capsule().stroke(Color.primary, lineWidth: 1))

                VStack(alignment: .leading) {
                  Text(crewMember.astronaut.name)
                    .font(.headline)
                  Text(crewMember.role)
                    .foregroundColor(.secondary)
                }

                  Spacer()
                }
              .padding(.horizontal)
              }
            .buttonStyle(PlainButtonStyle())
            }
            Spacer(minLength: 25)
          }
        }
      }
    .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
  }
}

// В структуре описываем передаваемый параметр через уже готовое расширение с методом декодирования
struct MissionView_Previews: PreviewProvider {
  
  static let missions: [Mission] = Bundle.main.decode("missions.json")
  
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  
  static var previews: some View {
      MissionView(mission: missions[0], astronauts: astronauts)
    }
}
