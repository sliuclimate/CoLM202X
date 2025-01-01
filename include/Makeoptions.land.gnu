# =======================================================
# mpif90 - gfortran 
# 

  FF = mpif90 -fopenmp
   
  NETCDF_LIB = /opt/netcdf-c-4.9.2-fortran-4.6.0-gnu/lib
  NETCDF_INC = /opt/netcdf-c-4.9.2-fortran-4.6.0-gnu/include
   
  MOD_CMD = -J

# determine the gfortran version
  GCC_VERSION := "`gcc -dumpversion`"
  IS_GCC_ABOVE_10 := $(shell expr "$(GCC_VERSION)" ">=" "10")
  ifeq "$(IS_GCC_ABOVE_10)" "1" 
     FOPTS = -fdefault-real-8 -ffree-form -C -g -u -xcheck=stkovf \
           -ffpe-trap=invalid,zero,overflow -fbounds-check \
           -mcmodel=medium -fbacktrace -fdump-core -cpp \
           -ffree-line-length-0 -fallow-argument-mismatch 
  else
     FOPTS = -fdefault-real-8 -ffree-form -C -g -u -xcheck=stkovf \
           -ffpe-trap=invalid,zero,overflow -fbounds-check \
           -mcmodel=medium -fbacktrace -fdump-core -cpp \
           -ffree-line-length-0
  endif

  INCLUDE_DIR = -I../include -I../share -I../mksrfdata -I../mkinidata -I../main -I$(NETCDF_INC)
  LDFLAGS = -L$(NETCDF_LIB) -lnetcdff -lnetcdf -llapack -lblas 



#============================================================
# CaMa-Flood Mkinclude (for Linux, gfortran)

RM = /bin/rm -f
CP = /bin/cp
#----
# Pre-Prosessing options
# DMPI=-DUseMPI: activate when MPI parallelization is used
# DCDF=-DUseCDF: activate when using netCDF, comment out when not needed
# DATM=-DNoAtom: activate when OMP ATOMIC calculation should be avoided (bit identical simulation)
#----
#DMPI=-DUseMPI
DCDF=-DUseCDF -DUseCDF_CMF
#DATM=-DNoAtom
CFLAGS=$(DMPI) $(DCDF) $(DATM) 
#----
FCMP = /usr/bin/gfortran -fopenmp
FC   = /usr/bin/gfortran 

LFLAGS =
FFLAGS = -O3 -Wall -cpp -free -fimplicit-none -fbounds-check -fbacktrace 
