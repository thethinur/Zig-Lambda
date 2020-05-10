const std = @import("std");
const eql = std.mem.eql;

fn CreateLambdaT(comptime closureT: type, comptime Struct: type) type {
    return struct {
        closure: closureT,
        pub fn call(self: @This(), args: var) Struct.ReturnType {
            return @call(.{}, Struct.func, .{ self.closure } ++ args);
        }
    };
}

pub fn createLambda(closure: var, comptime Struct: var) CreateLambdaT(@TypeOf(closure), Struct) {

    comptime {
        if (@hasDecl(Struct, "Func")){
            @compileError("function: 'Func' missing from Lambda Declaration");
        }
        if (@hasDecl(Struct, "ReturnType")){
            @compileError("type: ReturnType missing from Lambda Declaration");
        }
        if (@typeInfo(@TypeOf(closure)) != .Struct) {
            @compileError("closure is not a struct");
        }
    }
    
    const LambdaT = CreateLambdaT(@TypeOf(closure),  Struct);

    return LambdaT { .closure = closure };
}
