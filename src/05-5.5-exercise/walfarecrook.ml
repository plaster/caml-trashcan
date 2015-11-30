let drop_while p xs =
    let rec loop xs = match xs with
        []          -> []
    |   (x' :: xs') ->
        if p x'
        then loop xs'
        else xs
    in loop xs

let intersect xs ys =
    let rec loop xs ys acc = match xs with
        []          -> acc
    |   ( x :: xs ) ->
        match drop_while ( fun y -> y < x ) ys with
            []                  -> acc
        |   ( z :: zs ) as ys ->
            if x = z
            then loop xs zs (x :: acc)
            else loop xs ys acc
    in loop xs ys []
