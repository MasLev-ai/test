
struct Next {
    mut:
    coef int
    exp  int
}

// Estructura para representar un término del polinomio
struct Term {
    coef int                // Coeficiente
    exp  int                // Exponente
    mut:
    next Next              //= unsafe { none } // Siguiente término
}

// Función para crear un nuevo término
fn create_term(coef int, exp int) &Term {
    return &Term{
        coef: coef
        exp: exp
        next: Next{coef: 0, exp: 0}
    }
}


fn main() {
    mut poly := Term{coef: 4, exp: 3, next: Next{coef: 0, exp: 0}}
    poly.next = Next{coef: 8, exp: 2}
    poly.next.next = Next{coef: -2, exp: 1}
    poly.next.next.next = Next{coef: 5, exp: 0}
    println(poly.next.next.coef)
}