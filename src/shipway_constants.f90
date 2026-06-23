module shipway_constants
  implicit none
  real(8) :: Mw, rhow, eps, Rd, Dv, Lv, cp, g, p0, alpha_c, zetasa, Ru
contains
  function Dv_mean(T, p) result(res)
    real(8), intent(in) :: T, p
    real(8) :: res
    res = 0.0_8
  end function Dv_mean
end module shipway_constants
