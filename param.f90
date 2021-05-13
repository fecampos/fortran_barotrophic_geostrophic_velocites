      module param

      implicit none

      character(len=*),parameter :: file_sla = "in_sla.nc"

      character(len=*),parameter :: time_NAME = "time"
      character(len=*),parameter :: lon_NAME = "longitude"
      character(len=*),parameter :: lat_NAME = "latitude"
      character(len=*),parameter :: zos_NAME = "zos"
      character(len=*),parameter :: ugeos_NAME = "ugeos"
      character(len=*),parameter :: vgeos_NAME = "vgeos"

      integer, parameter :: nx = 1321, ny = 481, nt = 1

      integer :: i, j

      real, parameter :: pi = 3.1415927, rho0 = 1026.5, gamma = 7.2921e-5, g = 9.81

      real, parameter :: missing_val = -32767, sf_sla = 1, af_sla = 0

      real :: T(nt), X(nx), Y(ny), sla(nx,ny,nt), ugeos(nx,ny,nt), vgeos(nx,ny,nt)

      integer :: ncid, retval, timevarid, lonvarid, latvarid, slavarid, ugeosvarid, vgeosvarid

      end module
