module micro_main_f2py
  use micro_main, only: shipway_microphysics
  use initialize, only: mphys_init, mphys_finalise
  use casim_parent_mod, only: casim_parent, parent_kid
  use variable_precision, only: wp
  implicit none

contains

  subroutine wrap_initialise(nz_in, nx_in, hydro, aero, l_tendency, l_warm_in)
    use mphys_parameters, only: nz
    use mphys_switches, only: set_mphys_switches, l_warm
    use casim_runtime, only: casim_smax, casim_smax_limit_time
    integer, intent(in) :: nz_in, nx_in, hydro, aero
    logical, intent(in) :: l_tendency
    logical, intent(in) :: l_warm_in  ! .true. = warm rain only (no ice)
    
    ! ALWAYS SET PARENT KID
    casim_parent = parent_kid

    ! Disable KiD supersaturation clamping (casim_smax=0 default would zero
    ! all condensation for the KiD parent; set to a large value to skip it)
    casim_smax = 1.0e10_wp
    casim_smax_limit_time = -1.0_wp

    l_warm = l_warm_in
    call set_mphys_switches(hydro, aero)
    nz = nz_in
    ! Use high-level mphys_init which calls initialise_micromain + initialise_sedr
    ! + lookup tables + gamma functions
    call mphys_init(1, nx_in, 1, 1, 1, nz_in, &
                    is_in=1, ie_in=nx_in, js_in=1, je_in=1, ks_in=1, ke_in=nz_in, &
                    l_tendency=l_tendency)
  end subroutine

  subroutine wrap_finalise()
    call mphys_finalise()
  end subroutine

  subroutine wrap_shipway_microphysics(&
       il, iu, jl, ju, kl, ku, dt, &
       q_fields, a_fields, cf_fields, env_fields, &
       dq_fields, dth, da_fields)
    
    implicit none
    
    integer, intent(in) :: il, iu, jl, ju, kl, ku
    real(wp), intent(in) :: dt
    
    real(wp), intent(inout) :: q_fields(kl:ku, il:iu, jl:ju, 14)
    real(wp), intent(inout) :: a_fields(kl:ku, il:iu, jl:ju, 20)
    real(wp), intent(in)    :: cf_fields(kl:ku, il:iu, jl:ju, 5)
    real(wp), intent(in)    :: env_fields(kl:ku, il:iu, jl:ju, 7)
    
    real(wp), intent(inout) :: dq_fields(kl:ku, il:iu, jl:ju, 14)
    real(wp), intent(inout) :: dth(kl:ku, il:iu, jl:ju)
    real(wp), intent(inout) :: da_fields(kl:ku, il:iu, jl:ju, 17)
    
    real(wp) :: q_tmp(kl:ku, il:iu, jl:ju, 14)
    real(wp) :: a_tmp(kl:ku, il:iu, jl:ju, 20)
    real(wp) :: cf_tmp(kl:ku, il:iu, jl:ju, 5)
    real(wp) :: env_tmp(kl:ku, il:iu, jl:ju, 7)
    real(wp) :: dq_tmp(kl:ku, il:iu, jl:ju, 14)
    real(wp) :: da_tmp(kl:ku, il:iu, jl:ju, 17)
    real(wp) :: dth_tmp(kl:ku, il:iu, jl:ju)
    
    q_tmp = q_fields
    a_tmp = a_fields
    cf_tmp = cf_fields
    env_tmp = env_fields
    
    dq_tmp = 0.0_wp
    da_tmp = 0.0_wp
    dth_tmp = 0.0_wp

    call shipway_microphysics(&
       il, iu, jl, ju, kl, ku, dt, &
       q_tmp(:,:,:,1), q_tmp(:,:,:,2), q_tmp(:,:,:,3), q_tmp(:,:,:,4), q_tmp(:,:,:,5), &
       q_tmp(:,:,:,6), q_tmp(:,:,:,7), q_tmp(:,:,:,8), q_tmp(:,:,:,9), q_tmp(:,:,:,10), &
       q_tmp(:,:,:,11), q_tmp(:,:,:,12), q_tmp(:,:,:,13), q_tmp(:,:,:,14), &
       env_tmp(:,:,:,1), a_tmp(:,:,:,1), a_tmp(:,:,:,2), a_tmp(:,:,:,3), a_tmp(:,:,:,4), &
       a_tmp(:,:,:,5), a_tmp(:,:,:,6), a_tmp(:,:,:,7), a_tmp(:,:,:,8), a_tmp(:,:,:,9), &
       a_tmp(:,:,:,10), a_tmp(:,:,:,11), a_tmp(:,:,:,12), a_tmp(:,:,:,13), a_tmp(:,:,:,14), &
       a_tmp(:,:,:,15), a_tmp(:,:,:,16), a_tmp(:,:,:,17), a_tmp(:,:,:,18), a_tmp(:,:,:,19), &
       a_tmp(:,:,:,20), &
       env_tmp(:,:,:,2), env_tmp(:,:,:,3), env_tmp(:,:,:,4), env_tmp(:,:,:,5), &
       env_tmp(:,:,:,6), env_tmp(:,:,:,7), &
       cf_tmp(:,:,:,1), cf_tmp(:,:,:,2), cf_tmp(:,:,:,3), cf_tmp(:,:,:,4), cf_tmp(:,:,:,5), &
       dq_tmp(:,:,:,1), dq_tmp(:,:,:,2), dq_tmp(:,:,:,3), dq_tmp(:,:,:,4), dq_tmp(:,:,:,5), &
       dq_tmp(:,:,:,6), dq_tmp(:,:,:,7), dq_tmp(:,:,:,8), dq_tmp(:,:,:,9), dq_tmp(:,:,:,10), &
       dq_tmp(:,:,:,11), dq_tmp(:,:,:,12), dq_tmp(:,:,:,13), dq_tmp(:,:,:,14), &
       dth_tmp, da_tmp(:,:,:,1), da_tmp(:,:,:,2), da_tmp(:,:,:,3), da_tmp(:,:,:,4), da_tmp(:,:,:,5), &
       da_tmp(:,:,:,6), da_tmp(:,:,:,7), da_tmp(:,:,:,8), da_tmp(:,:,:,9), da_tmp(:,:,:,10), &
       da_tmp(:,:,:,11), da_tmp(:,:,:,12), da_tmp(:,:,:,13), da_tmp(:,:,:,14), &
       da_tmp(:,:,:,15), da_tmp(:,:,:,16), da_tmp(:,:,:,17), &
       is_in=il, ie_in=iu, js_in=jl, je_in=ju)
       
    ! Copy back
    dq_fields = dq_tmp
    da_fields = da_tmp
    dth = dth_tmp
    q_fields = q_tmp
    a_fields = a_tmp
  end subroutine
end module micro_main_f2py
