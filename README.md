# Zig-Lambda
<pre>
Example Lambda implementation for Zig.
</pre>
## Lambda Create Example:
```
var lambdaName = createLambda(
    .{ .someVar = somei32VarA, .someRef = &somei32VarB, }, 
struct {
    pub fn func(closure: var, someArg: i32) i32 
    {  
        return closure.someVar + closure.someRef.* + someArg; 
    }
}.func
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
