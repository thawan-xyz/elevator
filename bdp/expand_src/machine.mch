MACHINE
  machine

SETS
  DIRECTIONS = { UP , DOWN } ;

  ELEVATOR_STATUS = { OPEN , IDLE , MOVING , BROKEN , MAINTENANCE } ;

  BUTTONS = { L0 , L1 , L2 , UP0 , UP1 , DOWN1 , DOWN2 }

CONCRETE_CONSTANTS
  LEVELS ,
  MAX_CAPACITY

PROPERTIES
  LEVELS = 0 .. 2 &
  MAX_CAPACITY = 450

ABSTRACT_VARIABLES
  time ,
  time_open ,

  elevator_weight ,
  frequency ,

  level ,
  direction ,

  elevator_status ,

  active_buttons ,
  pressed_buttons ,

  key_inserted

INVARIANT
  time : NATURAL &
  time_open : NATURAL &

  elevator_weight : NATURAL &
  frequency : NATURAL +-> NATURAL1 &

  level : NATURAL &
  level : LEVELS &
  direction : DIRECTIONS &

  elevator_status : ELEVATOR_STATUS &

  active_buttons <: BUTTONS &
  pressed_buttons : BUTTONS +-> NATURAL &

  key_inserted : BOOL

INITIALISATION
  time := 0 ||
  time_open := 0 ||

  elevator_weight := 0 ||
  frequency := {} ||

  level := 0 ||
  direction := UP ||

  elevator_status := IDLE ||

  active_buttons := {} ||
  pressed_buttons := {} ||

  key_inserted := FALSE

OPERATIONS
  pass_time ( seconds ) =
  PRE
    seconds : NATURAL
  THEN
    time := time + seconds ||
    IF elevator_status = OPEN THEN
      IF time_open + seconds >= 120 THEN
        elevator_status := BROKEN ||
        time_open := 0
      ELSE
        time_open := time_open + seconds
      END
    END
  END ;

  insert_person ( weight ) =
  PRE
    elevator_status /: { IDLE , MOVING } &
    weight : NATURAL
  THEN
    elevator_weight := elevator_weight + weight ||
    IF weight : dom ( frequency ) THEN
      frequency ( weight ) := frequency ( weight ) + 1
    ELSE
      frequency ( weight ) := 1
    END
  END ;

  remove_person ( weight ) =
  PRE
    elevator_status /: { IDLE , MOVING } &
    weight : NATURAL &
    weight : dom ( frequency ) &
    weight <= elevator_weight // AJUDA DE PROVA
  THEN
    elevator_weight := elevator_weight - weight ||
    IF frequency ( weight ) = 1 THEN
      frequency := { weight } <<| frequency
    ELSE
      frequency ( weight ) := frequency ( weight ) - 1
    END
  END ;

  press_button ( button ) =
  PRE
    button : BUTTONS &
    button /: dom ( pressed_buttons )
  THEN
    IF elevator_status = MAINTENANCE THEN
      skip // PISCAR LED
    ELSE
      pressed_buttons ( button ) := time
    END
  END ;

  release_button ( button ) =
  PRE
    button : BUTTONS &
    button : dom ( pressed_buttons )
  THEN
    IF elevator_status = MAINTENANCE THEN
      skip // PISCAR LED
    ELSIF time - pressed_buttons ( button ) >= 3 THEN
      active_buttons := active_buttons - { button } // DESATIVAR BOTAO
    ELSE
      active_buttons := active_buttons \/ { button } // ATIVAR BOTAO
    END ||
    pressed_buttons := { button } <<| pressed_buttons
  END ;

  insert_key =
  PRE
    key_inserted = FALSE &
    elevator_status = BROKEN
  THEN
    key_inserted := TRUE ||
    elevator_status := MAINTENANCE ||
    active_buttons := {} ||
    pressed_buttons := {}
  END ;

  remove_key =
  PRE
    key_inserted = TRUE
  THEN
    key_inserted := FALSE ||
    elevator_status := IDLE
  END
END
