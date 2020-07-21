import Foundation

protocol SaveManagerKeys {
    func key() -> String
}

final class SaveManager {
    
    // MARK: Manager
    func save(object: Any, key: SaveManagerKeys) {
        standard().set(object, forKey: key.key())
    }
    
    func get(key: SaveManagerKeys) -> Any? {
        return standard().object(forKey: key.key()) as Any
    }
    
    func delete(key: SaveManagerKeys) {
        standard().removeObject(forKey: key.key())
    }
    
    func removeAllSavedDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
    }
    
    func urchive(object: NSCoding, key: SaveManagerKeys) throws {
        let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
        standard().set(data, forKey: key.key())
    }
    
    //are template constraints needed?
    func unurchive<T: NSCoding & NSObject>(key: SaveManagerKeys) throws -> T? {
        guard let data = standard().object(forKey: key.key()) as? Data else { return nil}
        return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
    }
    
    // MARK: Helpers
    private func standard () -> UserDefaults {
        return UserDefaults.standard
    }
    
}

