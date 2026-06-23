module casim_erfc_mod
  implicit none
contains
  function casim_erfc(x) result(res)
    real(8), intent(in) :: x
    real(8) :: res
    res = 0.0_8
  end function casim_erfc
end module casim_erfc_mod
