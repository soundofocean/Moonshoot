

import SwiftUI

struct ContentView: View {
  ///Параметр, в котором находится декодированная версия файла astronauts
  let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
 
  /// ///Параметр, в котором находится декодированная версия файла missions
  let missions: [Mission] = Bundle.main.decode("missions.json")
  
  
  /// Параметр, отвечающий за переключение отображений дат запуска и отображений имен экипажей.
  @State var showDate =  true
    
  var body: some View {
      NavigationView {
          List(missions) { mission in
            NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                  Image(mission.image)
                      .resizable()
                      .scaledToFit()
                      .frame(width: 44, height: 44)

                  VStack(alignment: .leading) {
                      Text(mission.displayName)
                          .font(.headline)
                      Text(mission.formattedLaunchDate)
                    
// challenge 3 Условие переключения между отображениями дат запуска и и имен экипажей
                    if self.showDate {
                      Text(mission.formatedLaunchDate)
                        .font(.subheadline)
                    } else {
                      Text(mission.crewNames(astronauts: self.astronauts))
                        .font(.subheadline)
                    }
                  }
              }
          }
          .navigationBarTitle("Moonshot")
        
//challenge 3 Кнопка, отвечающая за переключение между отображениями дат запуска и и имен экипажей
          .navigationBarItems(trailing:
                          Button(action: {
                              self.showDate.toggle()
                          }, label: {
                              Text("Show \(self.showDate ? "crew" : "date")")
                          })
          )
        }
      }
  }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
