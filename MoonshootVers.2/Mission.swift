import Foundation

/// Миссия
struct Mission: Codable, Identifiable {
    
  /// Роль экипажа
  struct CrewRole: Codable {
      
    /// Имя члена команды
        let name: String
    
    /// Роль в экипаже
        let role: String
    }

  /// Идентифицированный номер
    let id: Int
  
  /// Дата запуска
    let launchDate: Date?
    
  /// Массив экипажа
    let crew: [CrewRole]
    
  /// Описание
    let description: String
  
  /// Имя дисплея
    var displayName: String {
      "Apollo \(id)"
  }
  /// Изображение
  var image: String {
      "apollo\(id)"
  }
  
//  Предоставление отформатированной дату запуска, которая преобразует необязательную дату в аккуратно отформатированную строку или отправляет обратно «N / A» для отсутствующих дат.
  var formattedLaunchDate: String {
      if let launchDate = launchDate {
        
          let formatter = DateFormatter()
          
          formatter.dateStyle = .long
          
          return formatter.string(from: launchDate)
      } else {
          return "N/A"
      }
  }
}
