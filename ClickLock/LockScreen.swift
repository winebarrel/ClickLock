// from https://www.albertopasca.it/whiletrue/swift-c-lock-macos-programmatically/
import Foundation

func lockScreen() {
    let libHandle = dlopen("/System/Library/PrivateFrameworks/login.framework/Versions/Current/login", RTLD_LAZY)
    let sym = dlsym(libHandle, "SACLockScreenImmediate")
    typealias Func = @convention(c) () -> Void
    let SACLockScreenImmediate = unsafeBitCast(sym, to: Func.self)
    SACLockScreenImmediate()
}
