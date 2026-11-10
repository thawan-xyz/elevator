MACHINE
  timer

INCLUDES
  machine

PROMOTES
  board_passenger ,
  disembark_passenger ,
  insert_maintenance_key ,
  remove_key ,
  open_door ,
  close_door

ABSTRACT_VARIABLES
  global_time ,
  door_open_duration ,
  movement_duration

INVARIANT
  global_time : NATURAL &
  door_open_duration : 0 .. 119 &
  movement_duration : 0 .. 4 &

  // todo botão pressionado foi pressionado no passado
  ran ( button_press_timestamps ) <: 0 .. global_time

INITIALISATION
  global_time := 0 ||
  door_open_duration := 0 ||
  movement_duration := 0

OPERATIONS
  /*
  Avança o relógio em 1 segundo:
  - conta o tempo de porta aberta (ao atingir 120s o elevador quebra)
  - conta o tempo de movimento (ao atingir 5s o elevador chega ao andar)
  - chama o time_step do elevador, que também abre a porta ou inicia o movimento
  */
  tick =
  BEGIN
    global_time := global_time + 1 ||

    IF elevator_state = OPEN & door_open_duration + 1 < 120 THEN
      door_open_duration := door_open_duration + 1
    ELSE
      door_open_duration := 0
    END ||

    IF elevator_state = MOVING & movement_duration + 1 < 5 THEN
      movement_duration := movement_duration + 1
    ELSE
      movement_duration := 0
    END ||

    time_step (
      bool ( door_open_duration + 1 >= 120 ) ,
      bool ( movement_duration + 1 >= 5 )
    )
  END ;

  /*
  Começa a pressionar um botão no instante atual
  */
  press_button ( button ) =
  PRE
    button : BUTTONS &
    button /: dom ( button_press_timestamps )
  THEN
    press_button_at ( button , global_time )
  END ;

  /*
  Solta um botão no instante atual
  */
  release_button ( button ) =
  PRE
    button : BUTTONS &
    button : dom ( button_press_timestamps )
  THEN
    release_button_at ( button , global_time )
  END
END
