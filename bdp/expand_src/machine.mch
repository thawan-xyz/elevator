MACHINE
  machine

SETS
  DIRECTIONS = { up , down }

CONCRETE_CONSTANTS
  LEVELS

PROPERTIES
  LEVELS <: NATURAL &
  LEVELS = 0 .. 2

ABSTRACT_VARIABLES
  time ,
  level ,
  direction ,
  requests

INVARIANT
  time : NATURAL &
  level : NATURAL &
  level : LEVELS &
  direction : DIRECTIONS &
  requests : LEVELS <-> DIRECTIONS

INITIALISATION
  time := 0 ||
  level := 0 ||
  direction := up ||
  requests := {}

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
    END ;

  pass_hours ( delta ) =
    PRE
      delta : NATURAL1
    THEN
      time := time + 3600 * delta
    END
END
