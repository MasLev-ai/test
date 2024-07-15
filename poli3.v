

import math

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
        next: unsafe { nil }
    }
}

// Función para derivar un polinomio
fn derive_polynomial(mut head &Term) &Term {
    mut derived := unsafe { nil }
    mut temp := unsafe{&head}
    mut last := temp

	for temp != unsafe { nil } {
		if temp.exp != 0 {
			newcoef := temp.coef * temp.exp
			newexp := temp.exp - 1
			newterm := create_term(newcoef, newexp)
			if derived == unsafe { nil } {
				derived = newterm
			}
			else {
				last.next = newterm
			}
			last = newterm
		}
		temp = temp.next
	}
	return derived
}

// Función para imprimir el polinomio
fn print_polynomial(mut head &Term) {
    mut temp := unsafe{head}
    for temp != unsafe { nil } {
        if temp.coef > 0 && temp != head {
            print(' + ')
        }
        if temp.coef < 0 {
            print(' - ')
        }
        print('${math.abs(temp.coef)}x^${temp.exp}')
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
    print_polynomial(mut poly)

    mut derived_poly := derive_polynomial(mut poly)
    println('Derivada: ')
    print_polynomial(mut derived_poly)

    // Liberar memoria
    mut temp := unsafe{poly}
    for temp != unsafe { nil } {
        next := temp.next
        unsafe { free(temp) }
        temp = next
    }

    temp = unsafe{derived_poly}
    for temp != unsafe { nil } {
        next := temp.next
        unsafe { free(temp) }
        temp = next
    }
}


/*
[Running] v run "c:\Users\52554\Documents\c++_progrs\derivadas\poli2.v"
&Term{
    coef: 4
    exp: 3
    next: &<circular>
}
[Done] exited with code=0 in 0.615 seconds
*/