/* machine
 * Author: Thawan
 * Creation date: 18/10/2026
 */
MACHINE
  machine

SETS
  DIRECTIONS = { up , down }

ABSTRACT_VARIABLES
  time ,
  position ,
  direction

INVARIANT
  time : NATURAL &
  position : NATURAL &
  direction : DIRECTIONS

INITIALISATION
  time := 0 ||
  position := 0 ||
  direction := up

OPERATIONS
  pass_seconds ( delta ) =
    PRE
      delta : NATURAL1
    THEN
      time := time + delta
    END ;

  pass_minutes ( delta ) =
    PRE
      delta : NATURAL1
    THEN
      time := time + 60 * delta
    END
END
