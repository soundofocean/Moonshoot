import Foundation

////Расширение,позволяющее найти путь к файлу и соответсвующие ошибки при отрицательном результате
extension Bundle {
  
  //  /// Метод декодирования - способ декодировать информацию типа JSON.
  //  /// - Parameter file: Используем дженерики, чтобы эта функция могла работать со всеми типами данных - не только с массивом астронавтов, но и миссий, например При этом Т мы задаем тип codable - для того, чтобы метод декодирования все-таки сработал
  //  /// - Returns: массив астронавтов
  func decode<T: Codable>(_ file: String) -> T {
        
//// Поиск URL файла + описание ошибки. Guard - оператор досрочного выхода, если условие вернуло false - выполняется код в теле оператора
    guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
 
    //// Попытка загрузить файл
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
  
    //    /// Константа, отвечающая за декодер
        let decoder = JSONDecoder()
        
    /// Параметр, отвечающий за тип форматирования даты в виде год-месяц-день
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)

    //// Попытка декодирования файла
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
