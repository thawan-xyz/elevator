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
  MAX_CAPACITY ,
  SERVED

PROPERTIES
  LEVELS = 0 .. 2 &
  MAX_CAPACITY = 450 &

  /*
  Botões atendidos ao abrir a porta em cada andar, de acordo com o sentido
  */
  SERVED : ( LEVELS * DIRECTIONS ) <-> BUTTONS &
  SERVED = {
    ( 0 |-> UP ) |-> L0 , ( 0 |-> UP ) |-> UP0 ,
    ( 0 |-> DOWN ) |-> L0 , ( 0 |-> DOWN ) |-> UP0 ,
    ( 1 |-> UP ) |-> L1 , ( 1 |-> UP ) |-> UP1 ,
    ( 1 |-> DOWN ) |-> L1 , ( 1 |-> DOWN ) |-> DOWN1 ,
    ( 2 |-> UP ) |-> L2 , ( 2 |-> UP ) |-> DOWN2 ,
    ( 2 |-> DOWN ) |-> L2 , ( 2 |-> DOWN ) |-> DOWN2
  }

ABSTRACT_VARIABLES
  passenger_weights ,

  current_floor ,
  travel_direction ,

  elevator_state ,

  pending_requests ,
  tested_maintenance_buttons ,
  button_press_timestamps ,

  is_maintenance_key_inserted

INVARIANT
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
  Chamada pelo timer a cada segundo.
  door_expired = TRUE  -> porta aberta atingiu 120s: quebra (BROKEN)
  movement_done = TRUE -> movimento atingiu 5s: chega ao andar
  Ao chegar ou estando parado, abre a porta se houver chamada para este andar/sentido.
  Parado e sem chamada aqui: move-se para outro andar (respeitando a capacidade).
  No andar 1, segue no sentido atual se houver chamada à frente; senão, se houver
  chamada no andar 1 para o sentido oposto, inverte o sentido para atendê-la
  antes de partir para o outro lado.
  */
  time_step ( door_expired , movement_done ) =
  PRE
    door_expired : BOOL &
    movement_done : BOOL
  THEN
    tested_maintenance_buttons := {} ||
    LET served BE
      served = SERVED [ { current_floor |-> travel_direction } ]
    IN
      IF elevator_state = OPEN & door_expired = TRUE THEN
        elevator_state := BROKEN

      ELSIF elevator_state = MOVING & movement_done = TRUE THEN
        IF pending_requests /\ served /= {} THEN
          elevator_state := OPEN ||
          pending_requests := pending_requests - served
        ELSE
          elevator_state := IDLE
        END

      ELSIF elevator_state = IDLE & pending_requests /\ served /= {} THEN
        elevator_state := OPEN ||
        pending_requests := pending_requests - served

      ELSIF elevator_state = IDLE &
            SIGMA ( idx ) . ( idx : dom ( passenger_weights ) | passenger_weights ( idx ) ) <= MAX_CAPACITY THEN
        IF current_floor = 0 & pending_requests - { L0 , UP0 } /= {} THEN
          elevator_state := MOVING ||
          current_floor := 1
        ELSIF current_floor = 2 & pending_requests - { L2 , DOWN2 } /= {} THEN
          elevator_state := MOVING ||
          current_floor := 1
        ELSIF current_floor = 1 & travel_direction = UP &
              pending_requests /\ { L2 , DOWN2 } /= {} THEN
          elevator_state := MOVING ||
          current_floor := 2 ||
          travel_direction := DOWN
        ELSIF current_floor = 1 & travel_direction = DOWN &
              pending_requests /\ { L0 , UP0 } /= {} THEN
          elevator_state := MOVING ||
          current_floor := 0 ||
          travel_direction := UP
        ELSIF current_floor = 1 & travel_direction = UP & DOWN1 : pending_requests THEN
          travel_direction := DOWN
        ELSIF current_floor = 1 & travel_direction = DOWN & UP1 : pending_requests THEN
          travel_direction := UP
        ELSIF current_floor = 1 & pending_requests /\ { L0 , UP0 } /= {} THEN
          elevator_state := MOVING ||
          current_floor := 0 ||
          travel_direction := UP
        ELSIF current_floor = 1 & pending_requests /\ { L2 , DOWN2 } /= {} THEN
          elevator_state := MOVING ||
          current_floor := 2 ||
          travel_direction := DOWN
        END
      END
    END
  END ;

  /*
  Registra a entrada de um passageiro com determinado peso
  Só é permitido quando o elevador não está em trânsito - IDLE/MOVING
  */
  board_passenger ( weight ) =
  PRE
    elevator_state /: { IDLE , MOVING } &
    weight : NATURAL
  THEN
    passenger_weights := passenger_weights <- weight
  END ;


  /*
  Registra a saída de um passageiro de determinado peso
  Remove uma ocorrência desse peso da sequência
  */
  disembark_passenger ( weight ) =
  PRE
    elevator_state /: { IDLE , MOVING } &
    weight : NATURAL &
    weight : ran ( passenger_weights )
  THEN
    ANY idx WHERE
      idx : dom ( passenger_weights ) & passenger_weights ( idx ) = weight
    THEN
      passenger_weights := ( passenger_weights /|\ ( idx - 1 ) ) ^ ( passenger_weights \|/ idx )
    END
  END ;

  /*
  Registra o instante (now, fornecido pelo timer) em que o botão começou a ser pressionado
  */
  press_button_at ( button , now ) =
  PRE
    button : BUTTONS &
    button /: dom ( button_press_timestamps ) &
    now : NATURAL
  THEN
    button_press_timestamps ( button ) := now
  END ;

  /*
  Momento (now, fornecido pelo timer) em que o botão para de ser pressionado
  Segurar por >= 3s cancela a chamada; menos que isso ativa
  Em manutenção, apenas registra o botão como testado
  */
  release_button_at ( button , now ) =
  PRE
    button : BUTTONS &
    button : dom ( button_press_timestamps ) &
    now : NATURAL
  THEN
    IF elevator_state = MAINTENANCE THEN
      tested_maintenance_buttons := tested_maintenance_buttons \/ { button }
    ELSIF now - button_press_timestamps ( button ) >= 3 THEN
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
  Abre manualmente a porta do elevador parado - IDLE
  Limpa as requisições atendidas naquele andar e sentido
  */
  open_door =
  PRE
    elevator_state = IDLE
  THEN
    elevator_state := OPEN ||
    pending_requests := pending_requests - SERVED [ { current_floor |-> travel_direction } ]
  END ;

  /*
  Fecha a porta do elevador
  (chamada pelo timer, que também zera o contador de porta aberta)
  */
  shut_door =
  PRE
    elevator_state = OPEN
  THEN
    elevator_state := IDLE
  END
END
