const std = @import("std");
const assert = std.debug.assert;

const lambda = @import("lambda/lambda.zig");
const lambda = lambda.lambda;

pub fn main() !void
{
    const stdout = std.io.getStdOut().outStream();

    var a: i32 = 10;
    var b: i32 = 20;

    var lambda1 = lambda(
        .{ .a = a, .b = &b, }, 
    struct {
        pub fn func(closure: var) i32 
        {  

            return closure.a + closure.b.*; 
        }
    }.func
    );

    try stdout.print("{}\n", .{ lambda1.call(.{}) });

    a = 30;
    b = 30;

    try stdout.print("{}\n", .{ lambda1.call(.{}) });

    var lambda2 = lambda(
        .{ .b = &b, }, 
    struct {
        pub fn func(closure: var, a2: i32) i32 
        { 

            return a2 + closure.b.*; 
        }
    }.func
    );

    try stdout.print("{}\n", .{ lambda2.call(.{40}) });

    b = 40;

    try stdout.print("{}\n", .{ lambda2.call(.{40}) });
}
