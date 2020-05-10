const std = @import("std");
const assert = std.debug.assert;

const lambda = @import("lambda/lambda.zig");
const createLambda = lambda.createLambda;

pub fn main() void
{
    const stdout = std.io.getStdOut().outStream();

    var a: i32 = 10;
    var b: i32 = 20;

    var lambda1 = createLambda(
        .{ .a = a, .b = &b, }, 
    struct {
        pub const ReturnType = i32;
        pub fn func(closure: var) ReturnType 
        {  

            return closure.a + closure.b.*; 
        }
    }
    );

    var err = stdout.print("{}\n", .{ lambda1.call(.{}) });

    a = 30;
    b = 30;

    err = stdout.print("{}\n", .{ lambda1.call(.{}) });

    var lambda2 = createLambda(
        .{ .b = &b, }, 
    struct {
        pub const ReturnType = i32;
        pub fn func(closure: var, a2: i32) ReturnType 
        { 

            return a2 + closure.b.*; 
        }
    }
    );

    err = stdout.print("{}\n", .{ lambda2.call(.{40}) });

    b = 40;

    err = stdout.print("{}\n", .{ lambda2.call(.{40}) });
}
