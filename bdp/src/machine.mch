MACHINE
  machine

SETS
  DIRECTIONS = { UP , DOWN } ;

  ELEVATOR_STATUS = { OPEN , IDLE , MOVING , BROKEN , MAINTENANCE } ;

  /*
  Botões do Sistema:
  Lx (internos dos andares 0, 1 e 2)
  UPx / DOWNx (externos de chamada nos andares)
  */
  BUTTONS = { L0 , L1 , L2 , UP0 , UP1 , DOWN1 , DOWN2 }

CONCRETE_CONSTANTS
  LEVELS ,
  MAX_CAPACITY

PROPERTIES
  LEVELS = 0 .. 2 &
  MAX_CAPACITY = 450

ABSTRACT_VARIABLES
  global_time ,
  door_open_duration ,
  movement_duration ,

  passenger_weights ,

  current_floor ,
  travel_direction ,

  elevator_state ,

  pending_requests ,
  tested_maintenance_buttons ,
  button_press_timestamps ,

  is_maintenance_key_inserted

INVARIANT
  global_time : NATURAL &
  door_open_duration : NATURAL &
  movement_duration : NATURAL &

  passenger_weights : seq ( NATURAL ) &

  current_floor : NATURAL &
  current_floor : LEVELS &
  travel_direction : DIRECTIONS &

  elevator_state : ELEVATOR_STATUS &

  pending_requests <: BUTTONS &
  pending_requests : FIN ( BUTTONS ) & // AJUDA DE PROVA
  tested_maintenance_buttons <: BUTTONS &
  button_press_timestamps : BUTTONS +-> NATURAL &

  ( ( current_floor = 0 ) => ( travel_direction = UP ) ) &
  ( ( current_floor = 2 ) => ( travel_direction = DOWN ) ) &

  is_maintenance_key_inserted : BOOL

INITIALISATION
  global_time := 0 ||
  door_open_duration := 0 ||
  movement_duration := 0 ||

  passenger_weights := <> ||

  current_floor := 0 ||
  travel_direction := UP ||

  elevator_state := OPEN ||

  pending_requests := {} ||
  tested_maintenance_buttons := {} ||
  button_press_timestamps := {} ||

  is_maintenance_key_inserted := FALSE

OPERATIONS
  /*
  Avança o tempo do sistema e atualiza temporizadores de porta e movimento
  Se a porta ficar aberto por >= 120s o elevador quebra - BROKEN
  Se mover por >= 5s, o elevador chega ao destino intermediário/final - IDLE
  */
  pass_time ( seconds ) =
  PRE
    seconds : NATURAL
  THEN
    global_time := global_time + seconds ||
    tested_maintenance_buttons := {} ||
    IF elevator_state = OPEN THEN
      IF door_open_duration + seconds >= 120 THEN
        elevator_state := BROKEN ||
        door_open_duration := 0
      ELSE
        door_open_duration := door_open_duration + seconds
      END
    ELSIF elevator_state = MOVING THEN
      IF movement_duration + seconds >= 5 THEN
        elevator_state := IDLE ||
        movement_duration := 0
      ELSE
        movement_duration := movement_duration + seconds
      END
    END
  END ;

  /*
  Registra a entrada de um passageito com determinado peso
  Só é permitido quando o elevador não está em transito - IDLE/MOVING
  */
  board_passenger ( weight ) =
  PRE
    elevator_state /: { IDLE , MOVING } &
    weight : NATURAL
  THEN
    passenger_weights := passenger_weights <- weight
  END ;


  /*
  Registra a saída de uma pessoa do elevador de determinado peso
  Atualiza o peso total e decrementa ou remove a contagem do mapa
  */
  disembark_passenger ( weight ) =
  PRE
    elevator_state /: { IDLE , MOVING } &
    weight : NATURAL &
    weight : ran ( passenger_weights )
  THEN
    LET idx BE
      idx = min ( passenger_weights ~ [ { weight } ] )
    IN
      passenger_weights := ( passenger_weights /|\ ( idx - 1 ) ) ^ ( passenger_weights \|/ idx )
    END
  END ;


  /*
  Registra o instante (timestamp) em que o botão começou a ser pressionado
  */
  press_button ( button ) =
  PRE
    button : BUTTONS &
    button /: dom ( button_press_timestamps )
  THEN
    button_press_timestamps ( button ) := global_time
  END ;

  /*
  Momento que o botão para de ser pressionado e contagem de tempo para cancelamento
  */
  release_button ( button ) =
  PRE
    button : BUTTONS &
    button : dom ( button_press_timestamps )
  THEN
    IF elevator_state = MAINTENANCE THEN
      tested_maintenance_buttons := tested_maintenance_buttons \/ { button }
    ELSIF global_time - button_press_timestamps ( button ) >= 3 THEN
      pending_requests := pending_requests - { button } // DESATIVAR BOTAO
    ELSE
      pending_requests := pending_requests \/ { button } // ATIVAR BOTAO
    END ||
    button_press_timestamps := { button } <<| button_press_timestamps
  END ;


  /*
  Transiciona o elevador do estado BROKEN para MAINTENANCE pela chave física
  */
  insert_maintenance_key =
  PRE
    is_maintenance_key_inserted = FALSE &
    elevator_state = BROKEN
  THEN
    is_maintenance_key_inserted := TRUE ||
    elevator_state := MAINTENANCE ||
    pending_requests := {} ||
    button_press_timestamps := {}
  END ;


  /*
  Retira o elevador do estado MAINTENANCE para OPEN (funcionando normalmente)
  */
  remove_key =
  PRE
    is_maintenance_key_inserted = TRUE
  THEN
    is_maintenance_key_inserted := FALSE ||
    elevator_state := OPEN
  END ;

  /*
  Abre a porta do elevador ao chegar em um andar parado - IDLE
  Automaticamente limpa as requisiões atendidas naquele andar e sentido
  */
  open_door =
  PRE
    elevator_state = IDLE
  THEN
    elevator_state := OPEN ||
    IF current_floor = 0 THEN
      pending_requests := pending_requests - { L0 , UP0 }
    ELSIF current_floor = 1 & travel_direction = UP THEN
      pending_requests := pending_requests - { L1 , UP1 }
    ELSIF current_floor = 1 & travel_direction = DOWN THEN
      pending_requests := pending_requests - { L1 , DOWN1 }
    ELSIF current_floor = 2 THEN
      pending_requests := pending_requests - { L2 , DOWN2 }
    END
  END ;


  /*
  Fecha a porta do elevador e zera a contagem de tempo de porta aberta
  */
  close_door =
  PRE
    elevator_state = OPEN
  THEN
    elevator_state := IDLE ||
    door_open_duration := 0
  END ;


  /*
  Inicia o movimento entre andares com base na fila de chamadas pendentes (pending_requests)
  Respeita a capacidade máxima de carga e define a lógica de prioridade de sentido
  */
  start_moving =
  PRE
    elevator_state = IDLE &
    SIGMA ( idx ) . ( idx : dom ( passenger_weights ) | passenger_weights ( idx ) ) <= MAX_CAPACITY
  THEN
    elevator_state := MOVING ||
    IF current_floor = 0 & card ( pending_requests - { L0 , UP0 } ) > 0 THEN
      current_floor := 1
    ELSIF current_floor = 2 & card ( pending_requests - { L2 , DOWN2 } ) > 0 THEN
      current_floor := 1
    ELSIF current_floor = 1 THEN
      IF travel_direction = UP THEN
        IF card ( pending_requests /\ { L2 , DOWN2 } ) > 0 THEN
          current_floor := 2 ||
          travel_direction := DOWN
        ELSIF card ( pending_requests /\ { L0 , UP0 } ) > 0 THEN
          current_floor := 0
        END
      ELSIF travel_direction = DOWN THEN
        IF card ( pending_requests /\ { L0 , UP0 } ) > 0 THEN
          current_floor := 0 ||
          travel_direction := UP
        ELSIF card ( pending_requests /\ { L2 , DOWN2 } ) > 0 THEN
          current_floor := 2
        END
      END
    END
  END
END
