MACHINE
  machine

SETS
  DIRECTIONS = {up, down}

VARIABLES
  time,
  position,
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
  pass_seconds(delta) =
    PRE
      delta : NATURAL1
    THEN
      time := time + delta
    END;
  
  pass_minutes(delta) =
    PRE
      delta : NATURAL1
    THEN
      time := time + 60 * delta
    END
END
