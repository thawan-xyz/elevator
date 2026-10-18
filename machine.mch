/* machine
 * Author: Thawan
 * Creation date: 18/10/2026
 */
MACHINE
  machine

SETS
  DIRECTIONS = {up, down}

VARIABLES
  position,
  direction

INVARIANT
  position : NAT &
  direction : DIRECTIONS

INITIALISATION
  position := 0 ||
  direction := up

END
