const std = @import("std");
const eql = std.mem.eql;

fn isFuncT(comptime T: type) type {
    return @typeInfo(T) == .Function;
}

fn ReturnType(comptime func: type) type {
    if (isFuncT(func)) 
        return @typeInfo(func).Function.return_type
    else 
        @compileError("Not a func");
}

fn LambdaT(comptime closureT: type, comptime func: var) type {
    return struct {
        closure: closureT,
        pub fn call(self: @This(), args: var) ReturnType(@TypeOf(func)) {
            return @call(.{}, Struct.func, .{ self.closure } ++ args);
        }
    };
}

pub fn lambda(closure: var, comptime func: var) LambdaT(@TypeOf(closure), func) {
    const LambdaT = LambdaT(@TypeOf(closure),  func);
    return LambdaT { .closure = closure };
}
