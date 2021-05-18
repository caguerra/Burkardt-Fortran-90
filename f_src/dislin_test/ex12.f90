program main

!*****************************************************************************80
!
!! EX12 demonstrates a shaded contour plot.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    26 February 2014
!
!  Author:
!
!    This FORTRAN90 version by John Burkardt
!
!  Reference:
!
!    Helmut Michels,
!    The Data Plotting Software DISLIN - version 10.4,
!    Shaker Media GmbH, January 2010,
!    ISBN13: 978-3-86858-517-9.
!
  use dislin

  implicit none

  integer ( kind = 4 ), parameter :: m = 50
  integer ( kind = 4 ), parameter :: n = 50

  integer ( kind = 4 ) i
  integer ( kind = 4 ) j
  real ( kind = 8 ) x
  real ( kind = 8 ) xray(m)
  real ( kind = 8 ) y
  real ( kind = 8 ) yray(n)
  real ( kind = 8 ) zlev(12)
  real ( kind = 8 ) zmat(m,n)

  call timestamp ( )
  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'DISLIN_EX12:'
  write ( *, '(a)' ) '  FORTRAN90 version'
  write ( *, '(a)' ) '  Demonstrate the creation of '
  write ( *, '(a)' ) '  a shaded contour plot.'

  do i = 1, m
    x = 1.6D+00 * real ( i - 1, kind = 8 ) / real ( m - 1, kind = 8 )
    xray(i) = x
    do j = 1, n
      y = 1.6D+00 * real ( j - 1, kind = 8 ) / real ( n - 1, kind = 8 )
      yray(j) = y
      zmat(i,j) = ( x * x - 1.0D+00 )**2 + ( y * y - 1.0D+00 )**2
    end do
  end do
!
!  Specify the format of the output file.
!
  call metafl ( 'png' )
!
!  Indicate that new data overwrites old data.
!
  call filmod ( 'delete' )
!
!  Specify the name of the output graphics file.
!
  call setfil ( 'ex12.png' )
!
!  Choose the page size and orientation.
!
  call setpag ( 'usap' )
!
!  For PNG output, reverse the default black background to white.
!
  call scrmod ( 'reverse' )
!
!  Open DISLIN.
!
  call disini ( )
!
!  Plot a border around the page.
!
  call pagera ( )
!
!  Use the COMPLEX font.
!
  call complx ( )

  call mixalf ( )
  call titlin ( 'Shaded contour plot', 1 )
  call titlin ( 'f(x,y) = (x[2$ - 1)[2$ + (y[2$ - 1)[2$', 3 )
  call name ( 'x-axis', 'x' )
  call name ( 'y-axis', 'y' )

  call shdmod ( 'poly', 'contur' )
  call axspos ( 450, 2670 )

  call graf ( 0.0D+00, 1.6D+00, 0.0D+00, 0.2D+00, &
    0.0D+00, 1.6D+00, 0.0D+00, 0.2D+00 )

  do i = 1, 12
    zlev(13-i) = 0.1D+00 + real( i - 1, kind = 8 ) * 0.1D+00
  end do

  call conshd ( xray, m, yray, n, zmat, zlev, 12 )

  call height ( 50 )
  call title ( )
!
!  Close DISLIN.
!
  call disfin ( )
!
!  Terminate.
!
  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'EX12:'
  write ( *, '(a)' ) '  Normal end of execution.'
  write ( *, '(a)' ) ' '
  call timestamp ( )

  stop
end
subroutine timestamp ( )

!*****************************************************************************80
!
!! TIMESTAMP prints the current YMDHMS date as a time stamp.
!
!  Example:
!
!    31 May 2001   9:45:54.872 AM
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    18 May 2013
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    None
!
  implicit none

  character ( len = 8 ) ampm
  integer ( kind = 4 ) d
  integer ( kind = 4 ) h
  integer ( kind = 4 ) m
  integer ( kind = 4 ) mm
  character ( len = 9 ), parameter, dimension(12) :: month = (/ &
    'January  ', 'February ', 'March    ', 'April    ', &
    'May      ', 'June     ', 'July     ', 'August   ', &
    'September', 'October  ', 'November ', 'December ' /)
  integer ( kind = 4 ) n
  integer ( kind = 4 ) s
  integer ( kind = 4 ) values(8)
  integer ( kind = 4 ) y

  call date_and_time ( values = values )

  y = values(1)
  m = values(2)
  d = values(3)
  h = values(5)
  n = values(6)
  s = values(7)
  mm = values(8)

  if ( h < 12 ) then
    ampm = 'AM'
  else if ( h == 12 ) then
    if ( n == 0 .and. s == 0 ) then
      ampm = 'Noon'
    else
      ampm = 'PM'
    end if
  else
    h = h - 12
    if ( h < 12 ) then
      ampm = 'PM'
    else if ( h == 12 ) then
      if ( n == 0 .and. s == 0 ) then
        ampm = 'Midnight'
      else
        ampm = 'AM'
      end if
    end if
  end if

  write ( *, '(i2,1x,a,1x,i4,2x,i2,a1,i2.2,a1,i2.2,a1,i3.3,1x,a)' ) &
    d, trim ( month(m) ), y, h, ':', n, ':', s, '.', mm, trim ( ampm )

  return
end
