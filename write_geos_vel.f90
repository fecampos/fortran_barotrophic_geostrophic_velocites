      subroutine write_geos_vel(nx,ny,nt,X,Y,T,missing_value,ugeos,vgeos)
      
      use netcdf 

      implicit none      

      character(len=*), parameter :: file_out="output_geos.nc"

      real :: missing_value

      integer :: nx, ny, nt

      real :: X(nx), Y(ny), T(nt), ugeos(nx,ny,nt), vgeos(nx,ny,nt)

      integer, parameter :: NDIMS3 = 3

      character(len=*), parameter :: t_NAME="time"
      character(len=*), parameter :: x_NAME="longitude"
      character(len=*), parameter :: y_NAME="latitude"

      integer :: t_dimid, y_dimid, x_dimid, t_varid, y_varid, x_varid

      character(len=*), parameter :: ugeos_NAME="ugeos"
      character(len=*), parameter :: vgeos_NAME="vgeos"

      integer :: ugeos_varid, vgeos_varid, dimids3(NDIMS3)

      character(len=*), parameter :: UNITS = "units"

      character(len=*), parameter :: t_UNITS=&    
      & "hours since 1950-1-1 00:00:00"
      character(len=*), parameter :: y_UNITS="degrees_north"
      character(len=*), parameter :: x_UNITS="degrees_east"

      character(len=*), parameter :: ugeos_UNITS="m/s"
      character(len=*), parameter :: vgeos_UNITS="m/s"

      character(len=*), parameter :: LNAME="long_name"

      character(len=*), parameter :: t_LNAME=&
      &"hours since 1950-1-1 00:00:00"
      character(len=*), parameter :: y_LNAME="Latitude"
      character(len=*), parameter :: x_LNAME="Longitude"
   
      character(len=*), parameter :: ugeos_LNAME=&
      &"zonal geostrophic velocity "
      character(len=*), parameter :: vgeos_LNAME=&
      &"meridional geostrophic velocity"

      integer :: retval, ncid, rhvarid

      retval = nf90_create(file_out,ior(nf90_noclobber,nf90_64bit_offset),ncid)

      retval = nf90_def_dim(ncid, t_NAME, NT, t_dimid)
      retval = nf90_def_dim(ncid, y_NAME, NY, y_dimid)
      retval = nf90_def_dim(ncid, x_NAME, NX, x_dimid)

      retval = nf90_def_var(ncid, t_NAME, NF90_REAL, t_dimid, t_varid)
      retval = nf90_def_var(ncid, y_NAME, NF90_REAL, y_dimid, y_varid)
      retval = nf90_def_var(ncid, x_NAME, NF90_REAL, x_dimid, x_varid)

      retval = nf90_put_att(ncid, t_varid, UNITS, t_UNITS)
      retval = nf90_put_att(ncid, y_varid, UNITS, y_UNITS)
      retval = nf90_put_att(ncid, x_varid, UNITS, x_UNITS)

      retval = nf90_put_att(ncid, t_varid, LNAME, t_LNAME)
      retval = nf90_put_att(ncid, y_varid, LNAME, y_LNAME)
      retval = nf90_put_att(ncid, x_varid, LNAME, x_LNAME)

      retval = nf90_put_att(ncid, rhvarid,"title",&
                &"written by fecg: fecampos1302@gmail.com")

      dimids3(1) = x_dimid
      dimids3(2) = y_dimid
      dimids3(3) = t_dimid

      retval = nf90_def_var(ncid, ugeos_NAME, NF90_REAL, dimids3, ugeos_varid)
      retval = nf90_def_var(ncid, vgeos_NAME, NF90_REAL, dimids3, vgeos_varid)
            
      retval = nf90_put_att(ncid, ugeos_varid, UNITS, ugeos_UNITS)
      retval = nf90_put_att(ncid, ugeos_varid, LNAME, ugeos_LNAME)
      retval = nf90_put_att(ncid, vgeos_varid, UNITS, vgeos_UNITS)
      retval = nf90_put_att(ncid, vgeos_varid, LNAME, vgeos_LNAME)

      retval = nf90_put_att(ncid, ugeos_varid,'missing_value', missing_value)
      retval = nf90_put_att(ncid, vgeos_varid,'missing_value', missing_value)

      retval = nf90_enddef(ncid)

      retval = nf90_put_var(ncid, t_varid, T)
      retval = nf90_put_var(ncid, y_varid, Y)
      retval = nf90_put_var(ncid, x_varid, X)

      retval = nf90_put_var(ncid, ugeos_varid, ugeos)
      retval = nf90_put_var(ncid, vgeos_varid, vgeos)

      retval = nf90_close(ncid)

      return

      end subroutine
