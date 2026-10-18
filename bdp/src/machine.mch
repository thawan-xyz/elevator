MACHINE
  machine

SETS
  DIRECTIONS = { up , down } ;
  STATUS = { stopped , moving } ;
  DOORS = { open , closed }

CONCRETE_CONSTANTS
  MIN_LEVEL ,
  MAX_LEVEL ,
  LEVELS ,
  MAX_CAPACITY

PROPERTIES
  MIN_LEVEL = 0 &
  MAX_LEVEL = 2 &
  LEVELS = MIN_LEVEL .. MAX_LEVEL &
  MAX_CAPACITY = 450

ABSTRACT_VARIABLES
  time ,
  weight ,
  weights ,
  level ,
  direction ,
  requests ,
  status ,
  doors

INVARIANT
  time : NATURAL &
  weight : NATURAL &
  weights : NATURAL +-> NATURAL1 &
  level : NATURAL &
  level : LEVELS &
  direction : DIRECTIONS &
  requests : LEVELS <-> DIRECTIONS &
  status : STATUS &
  doors : DOORS

INITIALISATION
  time := 0 ||
  weight := 0 ||
  weights := {} ||
  level := 0 ||
  direction := up ||
  requests := {} ||
  status := stopped ||
  doors := closed

OPERATIONS
  pass_seconds ( delta ) =
  PRE
    delta : NATURAL1
  THEN
    time := time + delta
  END ;

  insert_person ( person_weight ) =
  PRE
    person_weight : NATURAL1
  THEN
    weight := weight + person_weight ||
    IF person_weight : dom ( weights ) THEN
      weights ( person_weight ) := weights ( person_weight ) + 1
    ELSE
      weights ( person_weight ) := 1
    END
  END ;

  remove_person ( person_weight ) =
  PRE
    person_weight : NATURAL1 &
    person_weight : dom ( weights )
  THEN
    weight := weight - person_weight ||
    IF weights ( person_weight ) = 1 THEN
      weights := { person_weight } <<| weights
    ELSE
      weights ( person_weight ) := weights ( person_weight ) - 1
    END
  END ;

  move =
  PRE
    status = stopped &
    doors = closed &
    weight <= MAX_CAPACITY
  THEN
    status := moving
  END
END
