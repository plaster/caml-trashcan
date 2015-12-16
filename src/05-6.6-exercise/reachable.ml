type ('key, 'value) dictionary =
  Leaf
| Node of 'key
        * 'value
        * ('key, 'value) dictionary
        * ('key, 'value) dictionary

let empty = Leaf

let rec add dic k v = match dic with                                                      
    Leaf -> Node(k, v, Leaf, Leaf)
  | Node(k0, v0, left, right) ->
      if k < k0
      then Node(k0, v0, (add left k v), right)
      else if k0 < k
      then Node(k0, v0, left, add right k v) 
      else dic

let rec find dic k = match dic with
    Leaf -> raise Not_found
  | Node(k0, v0, left, right) ->
      if k < k0
      then find left k
      else if k0 < k
      then find right k
      else v0

let member dic k =
  try
    match find dic k with
      _ -> true
  with Not_found -> false

type vertex = int
type graph = (vertex, vertex list) dictionary
type vertex_set = (vertex, unit) dictionary

let reachable_vertices (g : graph) (s : vertex) =
  let rec loop (vs : vertex_set) (ss : vertex list) =
    match ss with
      [] -> vs
    | s :: ss ->
      if member vs s
      then vs
      else
        try
          let children = find g s
          in loop ( loop ( add vs s () )
                         children )
                  ss
        with Not_found -> vs
  in loop empty [s]

let reachable (g : graph) (s : vertex) (d : vertex) =
  let vs = reachable_vertices empty s
  in member vs d
