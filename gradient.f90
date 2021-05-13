      subroutine  gradient(nx,ny,missing_val,lon,lat,f,gx,gy)

      implicit none

      integer, intent(in) :: nx,ny

      real,intent(in) :: f(nx,ny), lon(nx), lat(ny), missing_val

      real, intent(out) :: gx(nx,ny), gy(nx,ny)

      real :: dx, dy

      integer :: i, j

      gx = missing_val
      gy = missing_val

      !OMP PARALLEL DO
      do i = 1,nx-1
        do j = 1,ny
          if ((f(i+1,j).ne.missing_val).and.(f(i,j).ne.missing_val)) then
            call gsw_distance(lon(i+1),lon(i),lat(j),lat(j),dx)
            gx(i,j) = (f(i+1,j)-f(i,j))/dx
          end if
        end do
      end do
      !OMP END PARALLEL DO

      !OMP PARALLEL DO
      do i = 1,nx
        do j = 1,ny-1
          if ((f(i,j+1).ne.missing_val).and.(f(i,j).ne.missing_val)) then
            call gsw_distance(lon(i),lon(i),lat(j+1),lat(j),dy)
            gy(i,j) = (f(i,j+1)-f(i,j))/dy
          end if
        end do
      end do
      !OMP END PARALLEL DO

      end subroutine
