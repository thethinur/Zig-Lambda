fn createLambdaT(comptime closureT: type, comptime _func: var) type {
    return struct {
        closure: closureT,
        pub const func = _func;
    };
}

pub fn createLambda(closure: var, comptime _func: var) createLambdaT(@TypeOf(closure), _func) {

    const typename = @typeName(@TypeOf(_func));
    const funcname = (typename)[0..2];

    if (funcname ==  "fn"){
        @compileError("Function missing from Lambda Declaration");
    }
    
    const LambdaT = createLambdaT(@TypeOf(closure), _func);

    return LambdaT { .closure = closure };
}
