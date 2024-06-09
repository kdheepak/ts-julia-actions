foo(x) = x + 1

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
