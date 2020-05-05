const std = @import("std");
const eql = std.mem.eql;

fn createLambdaT(comptime closureT: type, comptime _func: var) type {
    return struct {
        closure: closureT,
        pub const func = _func;
    };
}

pub fn createLambda(closure: var, comptime _func: var) createLambdaT(@TypeOf(closure), _func) {

    const typename = @typeName(@TypeOf(_func));

    comptime {
        if (!eql(u8, typename[0..6] , "fn(var")){
            @compileError("function missing from Lambda Declaration");
        }
        if (@typeInfo(@TypeOf(closure)) != .Struct) {
            @compileError("closure is not a struct");
        }
    }
  
    
    const LambdaT = createLambdaT(@TypeOf(closure), _func);

    return LambdaT { .closure = closure };
}
