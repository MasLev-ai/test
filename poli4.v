


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
    // Polinomio de ejemplo: 4x^6 + 2x^5 - 9x^4 + 7x^3 - 1x^2 + 11x^1 + 2x^0
    mut poly := create_term(4, 6)
    poly.next = create_term(2, 5)
    poly.next.next = create_term(-9, 4)
    poly.next.next.next = create_term(7, 3)
	poly.next.next.next.next = create_term(-1, 2)
	poly.next.next.next.next.next = create_term(11, 1)
	poly.next.next.next.next.next.next = create_term(2, 0)

    println('Polinomio original: ')
    print_polynomial(mut poly)

    mut derived_poly := derive_polynomial(mut poly)
    println('Derivada: ')
    print_polynomial(mut derived_poly)
	// La Derivada: 24x^5 + 10x^4 - 36x^3 + 21x^2 - 2x^1 + 11x^0

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

[Running] v run "c:\Users\52554\Documents\c++_progrs\derivadas\poli4.v"
Polinomio original: 
4x^6 + 2x^5 - 9x^4 + 7x^3 - 1x^2 + 11x^1 + 2x^0
Derivada: 
24x^5 + 10x^4 - 36x^3 + 21x^2 - 2x^1 + 11x^0

[Done] exited with code=0 in 0.668 seconds

*/