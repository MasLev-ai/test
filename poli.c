
#include <stdio.h>
#include <stdlib.h>

// Estructura para representar un término del polinomio
typedef struct Term {
    int coef; // Coeficiente
    int exp;  // Exponente
    struct Term* next; // Siguiente término
} Term;

// Función para crear un nuevo término
Term* createTerm(int coef, int exp) {
    Term* newTerm = (Term*)malloc(sizeof(Term));
    newTerm->coef = coef;
    newTerm->exp = exp;
    newTerm->next = NULL;
    //printf("Termino creado: %dx^%d\n", coef, exp);
    return newTerm;
}

// Función para derivar un polinomio
Term* derivePolynomial(Term* head) {
    Term* derived = NULL;
    Term* temp = head;
    Term* last = NULL;

    while (temp != NULL) {
        if (temp->exp != 0) {
            int newCoef = temp->coef * temp->exp;
            int newExp = temp->exp - 1;
            Term* newTerm = createTerm(newCoef, newExp);

            if (derived == NULL) {
                derived = newTerm;
            } else {
                last->next = newTerm;
            }
            last = newTerm;
        }
        temp = temp->next;
    }
    return derived;
}

// Función para imprimir el polinomio
void printPolynomial(Term* head) {
    Term* temp = head;
    while (temp != NULL) {
        if (temp->coef > 0 && temp != head) {
            printf(" + ");
        }
        if (temp->coef < 0) {
            printf(" - ");
        }
        printf("%dx^%d", abs(temp->coef), temp->exp);
        temp = temp->next;
    }
    printf("\n");
}

int main() {
    // Polinomio de ejemplo: 4x^3 + 8x^2 - 2x + 5
    Term* poly = createTerm(4, 3);
    poly->next = createTerm(8, 2);
    poly->next->next = createTerm(-2, 1);
    poly->next->next->next = createTerm(5, 0);

    printf("Polinomio original: ");
    printPolynomial(poly);

    Term* derivedPoly = derivePolynomial(poly);
    printf("Derivada: ");
    printPolynomial(derivedPoly);

    // Liberar memoria
    while (poly != NULL) {
        Term* temp = poly;
        poly = poly->next;
        free(temp);
    }

    while (derivedPoly != NULL) {
        Term* temp = derivedPoly;
        derivedPoly = derivedPoly->next;
        free(temp);
    }

    return 0;
}
