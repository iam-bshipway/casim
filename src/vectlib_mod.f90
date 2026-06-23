module vectlib_mod
  implicit none
contains
  subroutine exp_v(n, a, b)
    integer, intent(in) :: n
    real(8), intent(in) :: a(n)
    real(8), intent(out) :: b(n)
    b = exp(a)
  end subroutine exp_v
  
  subroutine oneover_v(n, a, b)
    integer, intent(in) :: n
    real(8), intent(in) :: a(n)
    real(8), intent(out) :: b(n)
    b = 1.0_8 / a
  end subroutine oneover_v
  
  subroutine powr_v(n, a, b, c)
    integer, intent(in) :: n
    real(8), intent(in) :: a(n)
    real(8), intent(in) :: b    ! scalar exponent
    real(8), intent(out) :: c(n)
    c = a ** b
  end subroutine powr_v
end module vectlib_mod
