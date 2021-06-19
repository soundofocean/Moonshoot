
import Foundation

/// Структура Астронавт, в которой существует id, имя и описание каждого астронавта
struct Astronaut: Codable, Identifiable {
   
  let id: String
  
  let name: String

  let description: String
}
