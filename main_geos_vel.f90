      program main_geos_vel

      use netcdf

      use param

      implicit none

      real, dimension(nx,ny) :: f, dsladx, dslady

      retval = nf90_open(file_sla, NF90_NOWRITE, ncid)
      retval = nf90_inq_varid(ncid, lon_NAME, lonvarid)
      retval = nf90_get_var(ncid, lonvarid, X)
      retval = nf90_inq_varid(ncid, lat_NAME, latvarid)
      retval = nf90_get_var(ncid, latvarid, Y)
      retval = nf90_inq_varid(ncid, time_NAME, timevarid)
      retval = nf90_get_var(ncid, timevarid, T)
      retval = nf90_inq_varid(ncid, zos_NAME, slavarid)
      retval = nf90_get_var(ncid, slavarid, sla)
      retval = nf90_close(ncid)

      do i = 1,nx
        f(i,:) = 2*gamma*sin(Y*pi/180)
      end do

      call gradient(nx,ny,missing_val,X,Y,sla,dsladx,dslady)

      ugeos = missing_val
      vgeos = missing_val

      where ((dsladx.ne.missing_val).and.(dslady.ne.missing_val).and.(f.ne.0))
        ugeos(:,:,nt) = -g*dslady/f
        vgeos(:,:,nt) = g*dsladx/f
      end where

      call write_geos_vel(nx,ny,nt,X,Y,T,missing_val,ugeos,vgeos)

      end program
