MACHINE
  machine
  
SETS
  DIRECTIONS = {up, down}
  
CONSTANTS
  MIN_LEVEL,
  MAX_LEVEL,
  LEVELS
  
PROPERTIES
  MIN_LEVEL = 0 &
  MAX_LEVEL = 2 &
  LEVELS <: NATURAL &
  LEVELS = MIN_LEVEL..MAX_LEVEL
  
VARIABLES
  time,
  weight,
  level,
  direction,
  requests
  
INVARIANT
  time : NATURAL &
  weight : NATURAL &
  level : NATURAL &
  level : LEVELS &
  direction : DIRECTIONS &
  requests : LEVELS <-> DIRECTIONS
  
INITIALISATION
  time := 0 ||
  weight := 0 ||
  level := 0 ||
  direction := up ||
  requests := {}
  
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
  END;
  
  pass_hours(delta) =
  PRE
    delta : NATURAL1
  THEN
    time := time + 3600 * delta
  END;
  
  add_request(r_level, r_direction) =
  PRE
    r_level : LEVELS &
    r_direction : DIRECTIONS &
    (r_level = 0 => r_direction /= down) &
    (r_level = 2 => r_direction /= up)
  THEN
    requests := requests \/ {r_level |-> r_direction}
  END

END