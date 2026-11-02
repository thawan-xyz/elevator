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
  time_moving ,

  elevator_weight ,
  frequency ,

  level ,
  direction ,

  elevator_status ,

  active_buttons ,
  maintenance_buttons ,
  pressed_buttons ,

  key_inserted

INVARIANT
  time : NATURAL &
  time_open : NATURAL &
  time_moving : NATURAL &

  elevator_weight : NATURAL &
  frequency : NATURAL +-> NATURAL1 &
  // elevator_weight = SIGMA(X_).(X_ : dom(frequency) | X_ * frequency(X_)) &

  level : NATURAL &
  level : LEVELS &
  direction : DIRECTIONS &

  elevator_status : ELEVATOR_STATUS &

  active_buttons <: BUTTONS &
  active_buttons : FIN ( BUTTONS ) & // AJUDA DE PROVA
  maintenance_buttons <: BUTTONS &
  pressed_buttons : BUTTONS +-> NATURAL &

  ( ( level = 0 ) => ( direction = UP ) ) &
  ( ( level = 2 ) => ( direction = DOWN ) ) &

  key_inserted : BOOL

INITIALISATION
  time := 0 ||
  time_open := 0 ||
  time_moving := 0 ||

  frequency := {} ||
  elevator_weight := 0 ||

  level := 0 ||
  direction := UP ||

  elevator_status := OPEN ||

  active_buttons := {} ||
  maintenance_buttons := {} ||
  pressed_buttons := {} ||

  key_inserted := FALSE

OPERATIONS
  pass_time ( seconds ) =
  PRE
    seconds : NATURAL
  THEN
    time := time + seconds ||
    maintenance_buttons := {} ||
    IF elevator_status = OPEN THEN
      IF time_open + seconds >= 120 THEN
        elevator_status := BROKEN ||
        time_open := 0
      ELSE
        time_open := time_open + seconds
      END
    ELSIF elevator_status = MOVING THEN
      IF time_moving + seconds >= 5 THEN
        elevator_status := IDLE ||
        time_moving := 0
      ELSE
        time_moving := time_moving + seconds
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
    weight <= elevator_weight
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
    pressed_buttons ( button ) := time
  END ;

  release_button ( button ) =
  PRE
    button : BUTTONS &
    button : dom ( pressed_buttons )
  THEN
    IF elevator_status = MAINTENANCE THEN
      maintenance_buttons := maintenance_buttons \/ { button }
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
    elevator_status := OPEN
  END ;

  open_door =
  PRE
    elevator_status = IDLE
  THEN
    elevator_status := OPEN ||
    IF level = 0 THEN
      active_buttons := active_buttons - { L0 , UP0 }
    ELSIF level = 1 & direction = UP THEN
      active_buttons := active_buttons - { L1 , UP1 }
    ELSIF level = 1 & direction = DOWN THEN
      active_buttons := active_buttons - { L1 , DOWN1 }
    ELSIF level = 2 THEN
      active_buttons := active_buttons - { L2 , DOWN2 }
    END
  END ;

  close_door =
  PRE
    elevator_status = OPEN
  THEN
    elevator_status := IDLE
  END ;

  move =
  PRE
    elevator_status = IDLE &
    elevator_weight <= MAX_CAPACITY
  THEN
    elevator_status := MOVING ||
    IF level = 0 & card ( active_buttons - { L0 , UP0 } ) > 0 THEN
      level := 1
    ELSIF level = 2 & card ( active_buttons - { L2 , DOWN2 } ) > 0 THEN
      level := 1
    ELSIF level = 1 THEN
      IF direction = UP THEN
        IF card ( active_buttons /\ { L2 , DOWN2 } ) > 0 THEN
          level := 2 ||
          direction := DOWN
        ELSIF card ( active_buttons /\ { L0 , UP0 } ) > 0 THEN
          level := 0
        END
      ELSIF direction = DOWN THEN
        IF card ( active_buttons /\ { L0 , UP0 } ) > 0 THEN
          level := 0 ||
          direction := UP
        ELSIF card ( active_buttons /\ { L2 , DOWN2 } ) > 0 THEN
          level := 2
        END
      END
    END
  END
END
