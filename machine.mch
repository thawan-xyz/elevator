MACHINE
  machine
  
SETS
  DIRECTIONS = {UP, DOWN};
  
  ELEVATOR_STATUS = {OPEN, IDLE, MOVING, BROKEN, MAINTENANCE};
  
  /* 
  Botões do Sistema:
  Lx (internos dos andares 0, 1 e 2)
  UPx / DOWNx (externos de chamada nos andares)
  */
  BUTTONS = {L0, L1, L2, UP0, UP1, DOWN1, DOWN2}
  
CONSTANTS
  LEVELS,
  MAX_CAPACITY
  
PROPERTIES
  LEVELS = 0..2 &
  MAX_CAPACITY = 450
  
VARIABLES
  globalTime,
  doorOpenDuration,
  movementDuration,
  
  totalWeight,
  passegerWeightCounts,
  
  currentFloor,
  travelDirection,
  
  elevatorState,
  
  pendingRequests,
  testedMaintenanceButtons,
  buttonPressTimestamps,
  
  isMaintenanceKeyInserted
  
INVARIANT
  globalTime : NATURAL &
  doorOpenDuration : NATURAL &
  movementDuration : NATURAL &
  
  totalWeight : NATURAL &
  passegerWeightCounts : NATURAL +-> NATURAL1 &
  // totalWeight = SIGMA(X_).(X_ : dom(passegerWeightCounts) | X_ * passegerWeightCounts(X_)) &
  
  currentFloor : NATURAL &
  currentFloor : LEVELS &
  travelDirection : DIRECTIONS &
  
  elevatorState : ELEVATOR_STATUS &
  
  pendingRequests <: BUTTONS &
  pendingRequests : FIN(BUTTONS) & // AJUDA DE PROVA
  testedMaintenanceButtons <: BUTTONS &
  buttonPressTimestamps : BUTTONS +-> NATURAL &
  
  ((currentFloor = 0) => (travelDirection = UP)) &
  ((currentFloor = 2) => (travelDirection = DOWN)) &
  
  isMaintenanceKeyInserted : BOOL
  
INITIALISATION
  globalTime := 0 ||
  doorOpenDuration := 0 ||
  movementDuration := 0 ||
  
  passegerWeightCounts := {} ||
  totalWeight := 0 ||
  
  currentFloor := 0 ||
  travelDirection := UP ||
  
  elevatorState := OPEN ||
  
  pendingRequests := {} ||
  testedMaintenanceButtons := {} ||
  buttonPressTimestamps := {} ||
  
  isMaintenanceKeyInserted := FALSE
  
OPERATIONS
  /* 
  Avança o tempo do sistema e atualiza temporizadores de porta e movimento
  Se a porta ficar aberto por >= 120s o elevador quebra - BROKEN
  Se mover por >= 5s, o elevador chega ao destino intermediário/final - IDLE
  */
  pass_time(seconds) =
  PRE
    seconds : NATURAL
  THEN
    globalTime := globalTime + seconds ||
    testedMaintenanceButtons := {} ||
    IF elevatorState = OPEN THEN
      IF doorOpenDuration + seconds >= 120 THEN
        elevatorState := BROKEN ||
        doorOpenDuration := 0
      ELSE
        doorOpenDuration := doorOpenDuration + seconds
      END
    ELSIF elevatorState = MOVING THEN
      IF movementDuration + seconds >= 5 THEN
        elevatorState := IDLE ||
        movementDuration := 0
      ELSE
        movementDuration := movementDuration + seconds
      END
    END
  END;
  
  /* 
  Registra a entrada de um passageito com determinado peso
  Só é permitido quando o elevador não está em transito - IDLE/MOVING
  */
  board_passenger(weight) =
  PRE
    elevatorState /: {IDLE, MOVING} &
    weight : NATURAL
  THEN
    totalWeight := totalWeight + weight ||
    IF weight : dom(passegerWeightCounts) THEN
      passegerWeightCounts(weight) := passegerWeightCounts(weight) + 1
    ELSE
      passegerWeightCounts(weight) := 1
    END
  END;
    
    
  /*
  Registra a saída de uma pessoa do elevador de determinado peso 
  Atualiza o peso total e decrementa ou remove a contagem do mapa
  */
  disembark_passenger(weight) =
  PRE
    elevatorState /: {IDLE, MOVING} &
    weight : NATURAL &
    weight : dom(passegerWeightCounts) &
    weight <= totalWeight // AJUDA DE PROVA
  THEN
    totalWeight := totalWeight - weight ||
    IF passegerWeightCounts(weight) = 1 THEN
      passegerWeightCounts := {weight} <<| passegerWeightCounts
    ELSE
      passegerWeightCounts(weight) := passegerWeightCounts(weight) - 1
    END
  END;
  
  
  /*
  Registra o instante (timestamp) em que o botão começou a ser pressionado
  */
  press_button(button) =
  PRE
    button : BUTTONS &
    button /: dom(buttonPressTimestamps)
  THEN
    buttonPressTimestamps(button) := globalTime
  END;

  /*
  Momento que o botão para de ser pressionado e contagem de tempo para cancelamento
  */
  release_button(button) =
  PRE
    button : BUTTONS &
    button : dom(buttonPressTimestamps)
  THEN
    IF elevatorState = MAINTENANCE THEN
      testedMaintenanceButtons := testedMaintenanceButtons \/ {button}
    ELSIF globalTime - buttonPressTimestamps(button) >= 3 THEN
      pendingRequests := pendingRequests - {button} // DESATIVAR BOTAO
    ELSE
      pendingRequests := pendingRequests \/ {button} // ATIVAR BOTAO
    END ||
    buttonPressTimestamps := {button} <<| buttonPressTimestamps
  END;
  
  
  /*
  Transiciona o elevador do estado BROKEN para MAINTENANCE pela chave física
  */
  insert_maintenance_key =
  PRE
    isMaintenanceKeyInserted = FALSE &
    elevatorState = BROKEN
  THEN
    isMaintenanceKeyInserted := TRUE ||
    elevatorState := MAINTENANCE ||
    pendingRequests := {} ||
    buttonPressTimestamps := {}
  END;
  
  
  /*
  Retira o elevador do estado MAINTENANCE para OPEN (funcionando normalmente)
  */
  remove_key =
  PRE
    isMaintenanceKeyInserted = TRUE
  THEN
    isMaintenanceKeyInserted := FALSE ||
    elevatorState := OPEN
  END;
  
  /*
  Abre a porta do elevador ao chegar em um andar parado - IDLE
  Automaticamente limpa as requisiões atendidas naquele andar e sentido
  */
  open_door =
  PRE
    elevatorState = IDLE
  THEN
    elevatorState := OPEN ||
    IF currentFloor = 0 THEN
      pendingRequests := pendingRequests - {L0, UP0}
    ELSIF currentFloor = 1 & travelDirection = UP THEN
      pendingRequests := pendingRequests - {L1, UP1}
    ELSIF currentFloor = 1 & travelDirection = DOWN THEN
      pendingRequests := pendingRequests - {L1, DOWN1}
    ELSIF currentFloor = 2 THEN
      pendingRequests := pendingRequests - {L2, DOWN2}
    END
  END;
  
  
  /*
  Fecha a porta do elevador e zera a contagem de tempo de porta aberta
  */
  close_door =
  PRE
    elevatorState = OPEN
  THEN
    elevatorState := IDLE ||
    doorOpenDuration := 0
  END;
  
  
  /*
  Inicia o movimento entre andares com base na fila de chamadas pendentes (pendingRequests)
  Respeita a capacidade máxima de carga e define a lógica de prioridade de sentido
  */
  start_moving =
  PRE
    elevatorState = IDLE &
    totalWeight <= MAX_CAPACITY
  THEN
    elevatorState := MOVING ||
    IF currentFloor = 0 & card(pendingRequests - {L0, UP0}) > 0 THEN
      currentFloor := 1
    ELSIF currentFloor = 2 & card(pendingRequests - {L2, DOWN2}) > 0 THEN
      currentFloor := 1
    ELSIF currentFloor = 1 THEN
      IF travelDirection = UP THEN
        IF card(pendingRequests /\ {L2, DOWN2}) > 0 THEN
          currentFloor := 2 ||
          travelDirection := DOWN
        ELSIF card(pendingRequests /\ {L0, UP0}) > 0 THEN
          currentFloor := 0
        END
      ELSIF travelDirection = DOWN THEN
        IF card(pendingRequests /\ {L0, UP0}) > 0 THEN
          currentFloor := 0 ||
          travelDirection := UP
        ELSIF card(pendingRequests /\ {L2, DOWN2}) > 0 THEN
          currentFloor := 2
        END
      END
    END
  END
END
