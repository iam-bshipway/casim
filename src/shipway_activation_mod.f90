module shipway_activation_mod
  implicit none
contains
  subroutine solve_nccn_household(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11)
    integer :: a1
    integer :: a2
    real(8) :: a3,a4,a5,a6,a7,a8,a9
    real(8) :: a10, a11(*)
  end subroutine
  subroutine solve_nccn_brent(a1,a2,a3,a4,a5,a6,a7,a8)
    real(8) :: a1,a2,a3,a4,a5,a6,a7
    real(8) :: a8(*)
  end subroutine
end module shipway_activation_mod
