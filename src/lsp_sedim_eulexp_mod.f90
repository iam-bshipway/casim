module lsp_sedim_eulexp_mod
  implicit none
contains
  subroutine lsp_sedim_eulexp(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, &
    arg9, arg10, arg11)
    integer  :: arg1
    real(8)  :: arg2
    real(8)  :: arg3(arg1)
    real(8)  :: arg4(arg1), arg5(arg1)
    real(8)  :: arg6(arg1), arg7(arg1), arg8(arg1), arg9(arg1), arg10(arg1)
    real(8)  :: arg11(arg1)
  end subroutine
end module lsp_sedim_eulexp_mod
