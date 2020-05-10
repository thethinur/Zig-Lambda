# Zig-Lambda
<pre>
Example Lambda implementation for Zig.
Implementation works by verifying a struct interface.

Sadly the current state of Zig does not allow for type inferring on function types, without that I have 
to have the ReturnType in the struct interface and cant have just an anonymous function. 
</pre>
## Lambda Create Example:
```
var lambdaName = createLambda(
    .{ .someVar = somei32VarA, .someRef = &somei32VarB, }, 
struct {
    pub const ReturnType = i32;
    pub fn func(closure: var, someArg: i32) ReturnType 
    {  
        return closure.someVar + closure.someRef.* + someArg; 
    }
}
);
```
## Lambda Call Example:
```
lambdaName.call(.{ somei32Var3 })
```

## 'example.zig' Output:
> <pre>
> 30
> 40
> 70
> 80
> </pre>
