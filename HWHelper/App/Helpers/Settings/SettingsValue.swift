import Foundation

extension Settings {
    
    @propertyWrapper
    struct Value<T> {
        
        let key: String
        let defaultValue: T
        
        var wrappedValue: T {
            get { container.object(forKey: key) as? T ?? self.defaultValue }
            set { container.set(newValue, forKey: key) }
        }
        
        init(wrappedValue: T, key: String, defaultValue: T? = nil) {
            self.key = key
            self.defaultValue = defaultValue ?? wrappedValue
        }
    }
}
