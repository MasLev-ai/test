@[translated]
module main

type Size_t = i64
type Ssize_t = i64
type Rsize_t = usize
type Intptr_t = i64
type Uintptr_t = i64
type Ptrdiff_t = i64
type Wchar_t = u16
type Wint_t = u16
type Wctype_t = u16
type Errno_t = int
type Time_t = Time64_t
type pthreadlocinfo = voidptr
type pthreadmbcinfo = voidptr
struct Locale_tstruct { 
	locinfo Pthreadlocinfo
	mbcinfo Pthreadmbcinfo
}
type _locale_t = voidptr
struct LC_ID { 
	wLanguage u16
	wCountry u16
	wCodePage u16
}
type LPLC_ID = voidptr
struct Threadlocinfo { 
	_locale_pctype &u16
	_locale_mb_cur_max int
	_locale_lc_codepage u32
}
struct FILE { 
	_Placeholder voidptr
}
type _off_t = int
type Off32_t = int
type _off64_t = i64
type Off64_t = i64
type Off_t = Off32_t
type Fpos_t = i64
type _onexit_t = fn () int
struct Div_t { 
	quot int
	rem int
}
struct LDOUBLE { 
	ld [10]u8
}
struct CRT_DOUBLE { 
	x f64
}
struct CRT_FLOAT { 
	f f32
}
struct LONGDOUBLE { 
	x f64
}
struct LDBL12 { 
	ld12 [12]u8
}
type _purecall_handler = fn ()
type _invalid_parameter_handler = fn (&Wchar_t, &Wchar_t, &Wchar_t, u32, Uintptr_t)
struct Lldiv_t { 
	quot i64
	rem i64
}
struct HEAPINFO { 
	_pentry &int
	_size usize
	_useflag int
}
struct Term { 
	coef int
	exp int
	next &Term
}
@[c:'createTerm']
fn createterm(coef int, exp int) &Term {
	newterm := &Term(C.malloc(sizeof(Term)))
	newterm.coef = coef
	newterm.exp = exp
	newterm.next = (voidptr(0))
	return newterm
}

@[c:'derivePolynomial']
fn derivepolynomial(head &Term) &Term {
	derived := (voidptr(0))
	temp := head
	last := (voidptr(0))
	for temp != (voidptr(0)) {
		if temp.exp != 0 {
			newcoef := temp.coef * temp.exp
			newexp := temp.exp - 1
			newterm := createterm(newcoef, newexp)
			if derived == (voidptr(0)) {
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

@[c:'printPolynomial']
fn printpolynomial(head &Term)  {
	temp := head
	for temp != (voidptr(0)) {
		if temp.coef > 0 && temp != head {
			C.printf(c' + ')
		}
		if temp.coef < 0 {
			C.printf(c' - ')
		}
		C.printf(c'%dx^%d', C.abs(temp.coef), temp.exp)
		temp = temp.next
	}
	C.printf(c'\n')
}

fn main()  {
	poly := createterm(4, 3)
	poly.next = createterm(8, 2)
	poly.next.next = createterm(-2, 1)
	poly.next.next.next = createterm(5, 0)
	C.printf(c'Polinomio original: ')
	printpolynomial(poly)
	derivedpoly := derivepolynomial(poly)
	C.printf(c'Derivada: ')
	printpolynomial(derivedpoly)
	for poly != (voidptr(0)) {
		temp := poly
		poly = poly.next
		C.free(temp)
	}
	for derivedpoly != (voidptr(0)) {
		temp := derivedpoly
		derivedpoly = derivedpoly.next
		C.free(temp)
	}
	return 
}

