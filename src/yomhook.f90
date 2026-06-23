module yomhook
  implicit none
  logical :: lhook = .false.
contains
  subroutine dr_hook(name, switch, handle)
    character(len=*), intent(in) :: name
    integer, intent(in) :: switch
    real(8), intent(inout) :: handle
  end subroutine dr_hook
end module yomhook
