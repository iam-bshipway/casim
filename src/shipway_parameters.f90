module shipway_parameters
  implicit none
  integer, parameter :: max_nmodes = 3
  integer :: nmodes = 1
  real(8) :: Ndi(max_nmodes)
  real(8) :: Rmdi(max_nmodes)
  real(8) :: log_sigi(max_nmodes)
  real(8) :: rhop
  real(8) :: rdi(max_nmodes), sigmad(max_nmodes)
  real(8) :: bi(max_nmodes), betai(max_nmodes), nd_min
  logical :: use_mode(max_nmodes)
end module shipway_parameters
