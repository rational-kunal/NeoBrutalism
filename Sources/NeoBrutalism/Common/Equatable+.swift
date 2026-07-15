
/// A type-erased `Equatable` value, used where `NBRadioGroup`/`NBRadioItem` need to compare
/// selection values without being generic over a single concrete type.
public typealias AnyEquatable = any Equatable

extension Equatable {
    func isEqual(_ other: any Equatable) -> Bool {
        guard let other = other as? Self else {
            return false
        }
        return self == other
    }
}
