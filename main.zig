const std = @import("std");
const assert = std.debug.assert;

usingnamespace @import("lib/lambda.zig");

pub fn main() void
{
    const stdout = std.io.getStdOut().outStream();

    var a: i32 = 10;
    var b: i32 = 20;

    var Lambda = createLambda(
        .{ .a = a, .b = &b, }, 
    struct {
        fn func(lambdaHandle: var) i32 
        { 
            const closure = lambdaHandle.closure; 

            return closure.a + closure.b.*; 
        }
    }.func);

    var err = stdout.print("{}\n", .{ Lambda.func() });

    a = 30;
    b = 30;

    err = stdout.print("{}\n", .{ Lambda.func() });

    var Lambda2 = createLambda(
        .{ .b = &b, }, 
    struct {
        fn func(lambdaHandle: var, a2: i32) i32 
        { 
            const closure = lambdaHandle.closure; 

            return a2 + closure.b.*; 
        }
    }.func);

    err = stdout.print("{}\n", .{ Lambda2.func(40) });

    b = 40;

    err = stdout.print("{}\n", .{ Lambda2.func(40) });
}

