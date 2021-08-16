# fortran Surface Geostrophic Velocities

This library contains Fortran scripts to compute surface geostrophic velocities

**References**

Chaigneau, A., Gizolme, A., & Grados, C. (2008). Mesoscale eddies off Peru in altimeter records: Identification algorithms and eddy spatio-temporal patterns. *Progress in Oceanography*, 79(2-4), 106-119.

 **Getting Started**

1. Open *param.f90* and modify line 5,7,8,9,10 with your netcdf file (file_sla), time (t_NAME), lon (lon_NAME), lat (lat_NAME) and variable (zos_NAME):
```
      character(len=*),parameter :: file_sla = "in_sla.nc"
      
      character(len=*),parameter :: time_NAME = "time"
      
      character(len=*),parameter :: lon_NAME = "longitude"
      
      character(len=*),parameter :: lat_NAME = "latitude"
      
      character(len=*),parameter :: zos_NAME = "zos"
```      
 also modify line 12, 16 and 18 with your lon grid number (nx), lat grid number (ny), time steps (nt), rho0,  missing_val , scale factor (sf_sla) and add offset (af_sla):

```
     integer, parameter :: nx = 1321, ny = 481, nt = 1

     real, parameter :: pi = 3.1415927, rho0 = 1026.5, gamma = 7.2921e-5, g = 9.81

     real, parameter :: missing_val = -32767, sf_sla = 1, af_sla = 0
     
```   
2. Open *jobcomp* and modify NETCDFLIB and NETCDFINC path with your netcdf path
3. Run **./jobcomp**
