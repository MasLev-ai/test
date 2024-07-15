

// Estructura para representar un término del polinomio
struct Term {
    coef int // Coeficiente
    exp  int // Exponente
    mut:
    next &Term //= unsafe { none } // Siguiente término
}

// Función para crear un nuevo término
fn create_term(coef int, exp int) &Term {
    return &Term{
        coef: coef
        exp: exp
        next: unsafe { none }
    }
}

// Función para derivar un polinomio
fn derive_polynomial(mut head &Term) &Term {
    mut derived := unsafe { none }
    mut temp := head
    mut last := unsafe { none }

    for temp != unsafe { none } {
        if temp.exp != 0 {
            new_coef := temp.coef * temp.exp
            new_exp := temp.exp - 1
            new_term := create_term(new_coef, new_exp)

            if derived == unsafe { none } {
                derived = new_term
            } else {
                last.next = new_term
            }
            last = new_term
        }
        temp = temp.next
    }
    return derived
}

// Función para imprimir el polinomio
fn print_polynomial(mut head &Term) {
    mut temp := head
    for temp != unsafe { none } {
        if temp.coef > 0 && temp != head {
            print(' + ')
        }
        if temp.coef < 0 {
            print(' - ')
        }
        print('${abs(temp.coef)}x^${temp.exp}')
        temp = temp.next
    }
    println('')
}

fn main() {
    // Polinomio de ejemplo: 4x^3 + 8x^2 - 2x + 5
    mut poly := create_term(4, 3)
    poly.next = create_term(8, 2)
    poly.next.next = create_term(-2, 1)
    poly.next.next.next = create_term(5, 0)

    println('Polinomio original: ')
    print_polynomial(poly)

    derived_poly := derive_polynomial(poly)
    println('Derivada: ')
    print_polynomial(derived_poly)

    // Liberar memoria
    mut temp := poly
    for temp != unsafe { none } {
        next := temp.next
        unsafe { free(temp) }
        temp = next
    }

    temp = derived_poly
    for temp != unsafe { none } {
        next := temp.next
        unsafe { free(temp) }
        temp = next
    }
}
