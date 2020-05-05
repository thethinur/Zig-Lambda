fn createLambdaT(comptime closureT: type, comptime _func: var) type {
    return struct {
        closure: closureT,
        pub const func = _func.func;
    };
}

pub fn createLambda(closure: var, comptime _func: var) createLambdaT(@TypeOf(closure), _func) {

    if (!@hasDecl(_func, "func")){
        @compileError("'func' missing from Lambda struct Declaration");
    }
    
    const LambdaT = createLambdaT(@TypeOf(closure), _func);

    return LambdaT { .closure = closure };
}
