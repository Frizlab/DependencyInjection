import Foundation

import ServiceContextModule



@MainActor
public protocol InjectionKeyMainActor : ServiceContextKey {
	
	/**
	 The default value for the injected key.
	 
	 If this is set to `nil`, the value **must** be set by the dependency clients before trying to retrieve it. */
	static var defaultValue: Value! {get}
	
}


public extension Injected {
	
	@MainActor
	init<InjectedKey : InjectionKeyMainActor>(_ keyPath: KeyPath<InjectionKeys, InjectedKey.Type>)
	where InjectedKey.Value == InjectedType {
		let defaultValue = InjectedKey.defaultValue
		self.erasedAccessor = { context[InjectedKey.self] ?? defaultValue! }
	}
	
}

public extension Injected {
	
	@MainActor
	static func value<InjectedKey : InjectionKeyMainActor>(for keyType: InjectedKey.Type = InjectedKey.self) -> InjectedType
	where InjectedKey.Value == InjectedType {
		return context[InjectedKey.self] ?? InjectedKey.defaultValue
	}
	
	@MainActor
	static func setValue<InjectedKey : InjectionKeyMainActor>(_ newValue: InjectedType, for keyType: InjectedKey.Type = InjectedKey.self)
	where InjectedKey.Value == InjectedType {
		context[InjectedKey.self] = newValue
	}
	
	@MainActor
	@inlinable
	static func value<InjectedKey : InjectionKeyMainActor>(for keyPath: KeyPath<InjectionKeys, InjectedKey.Type>) -> InjectedType
	where InjectedKey.Value == InjectedType {
		return value(for: InjectedKey.self)
	}
	
	@MainActor
	@inlinable
	static func setValue<InjectedKey : InjectionKeyMainActor>(_ newValue: InjectedType, for keyPath: KeyPath<InjectionKeys, InjectedKey.Type>)
	where InjectedKey.Value == InjectedType {
		setValue(newValue, for: InjectedKey.self)
	}
	
}

public extension Injected where InjectedType : AutoInjectableMainActor {
	
	@MainActor
	@inlinable
	static var value: InjectedType {
		get {   value(          for: InjectedType.AutoInjectionKey.self)}
		set {setValue(newValue, for: InjectedType.AutoInjectionKey.self)}
	}
	
	@MainActor
	init() {
		let defaultValue = InjectedType.AutoInjectionKey.defaultValue
		self.erasedAccessor = { context[InjectedType.AutoInjectionKey.self] ?? defaultValue! }
	}
	
}
