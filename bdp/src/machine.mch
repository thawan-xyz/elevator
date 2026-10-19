MACHINE
  machine

SETS
  DIRECTIONS = { UP , DOWN } ;
  DOOR_STATUS = { OPEN , CLOSED } ;
  BUTTONS = { L0 , L1 , L2 , UP0 , UP1 , DOWN1 , DOWN2 }

CONCRETE_CONSTANTS
  LEVELS ,
  MAX_CAPACITY

PROPERTIES
  LEVELS = 0 .. 2 &
  MAX_CAPACITY = 450

ABSTRACT_VARIABLES
  time ,

  elevator_weight ,
  weight_frequency ,

  level ,
  direction ,

  door_status ,
  active_buttons ,
  pressed_buttons

INVARIANT
  time : NATURAL &

  elevator_weight : NATURAL &
  weight_frequency : NATURAL +-> NATURAL1 &

  level : NATURAL &
  level : LEVELS &
  direction : DIRECTIONS &

  door_status : DOOR_STATUS &
  active_buttons <: BUTTONS &
  pressed_buttons : BUTTONS +-> NATURAL

INITIALISATION
  time := 0 ||

  elevator_weight := 0 ||
  weight_frequency := {} ||

  level := 0 ||
  direction := UP ||

  door_status := CLOSED ||

  active_buttons := {} ||
  pressed_buttons := {}

OPERATIONS
  pass_time ( seconds ) =
  PRE
    seconds : NATURAL
  THEN
    time := time + seconds
  END ;

  insert_person ( weight ) =
  PRE
    weight : NATURAL
  THEN
    elevator_weight := elevator_weight + weight ||
    IF weight : dom ( weight_frequency ) THEN
      weight_frequency ( weight ) := weight_frequency ( weight ) + 1
    ELSE
      weight_frequency ( weight ) := 1
    END
  END ;

  remove_person ( weight ) =
  PRE
    weight : NATURAL &
    weight : dom ( weight_frequency ) &
    weight <= elevator_weight
  THEN
    elevator_weight := elevator_weight - weight ||
    IF weight_frequency ( weight ) = 1 THEN
      weight_frequency := { weight } <<| weight_frequency
    ELSE
      weight_frequency ( weight ) := weight_frequency ( weight ) - 1
    END
  END ;

  press_button ( button ) =
  PRE
    button : BUTTONS &
    button /: dom ( pressed_buttons )
  THEN
    pressed_buttons ( button ) := time
  END ;

  release_button ( button ) =
  PRE
    button : BUTTONS &
    button : dom ( pressed_buttons )
  THEN
    IF time - pressed_buttons ( button ) >= 3 THEN
      active_buttons := active_buttons - { button }
    ELSE
      active_buttons := active_buttons \/ { button }
    END ||
    pressed_buttons := { button } <<| pressed_buttons
  END
END
