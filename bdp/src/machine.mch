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
  elevator_level ,
  elevator_direction ,
  requests

INVARIANT
  time : NATURAL &
  elevator_level : NATURAL &
  elevator_level : LEVELS &
  elevator_direction : DIRECTIONS &
  requests : LEVELS <-> DIRECTIONS

INITIALISATION
  time := 0 ||
  elevator_level := 0 ||
  elevator_direction := up ||
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
  END ;

  add_request ( request_level , request_direction ) =
  PRE
    request_level : LEVELS &
    request_direction : DIRECTIONS &
    ( request_level = 0 => request_direction /= down ) &
    ( request_level = 2 => request_direction /= up )
  THEN
    requests := requests \/ { request_level |-> request_direction }
  END

END
