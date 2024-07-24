"""
# Header 1

## Header 2

### Header 3

1. List element 1
2. Syntax highlighting for inline `code`
3. **Bold** and _Italic_

```julia
function test()
    println("hello world")
end
```
"""
function foo(x)
  x + 1
end

foo(a,
    b,
    c,
    d,
    ) = x + 1

foo(x) = x[] = 1

foo(x) = begin
    println("hello")
    x + 1
end

markdown = md"""
# Header 1

## Header 2

### Header 3

1. List element 1
2. Syntax highlighting for inline `code`
3. **Bold** and _Italic_

```rust
fn test() {
    println("hello world")
}
```
"""

function test()

    run(`git status`)

    run(`git commit -am "feat: syntax highlighting in commands"`)

    run(`git push`)

end
