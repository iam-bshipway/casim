module casim_reflec_mod
  implicit none
  real(8) :: ref_lim = -100.0_8
contains
  subroutine casim_reflec(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12)
    integer :: a1, a2, a3
    real(8) :: a4(*)
    real(8) :: a5(a3,a1)
    real(8) :: a6(a3,a1)
    real(8) :: a7(*), a8(*), a9(*), a10(*), a11(*), a12(*)
  end subroutine
  subroutine setup_reflec_constants()
  end subroutine
end module casim_reflec_mod
