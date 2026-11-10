Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(machine))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(machine))==(Machine(machine));
  Level(Machine(machine))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(machine)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(machine))==(?)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(machine))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(machine))==(?);
  List_Includes(Machine(machine))==(?)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(machine))==(?)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(machine))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(machine))==(?);
  Context_List_Variables(Machine(machine))==(?);
  Abstract_List_Variables(Machine(machine))==(?);
  Local_List_Variables(Machine(machine))==(is_maintenance_key_inserted,button_press_timestamps,tested_maintenance_buttons,pending_requests,elevator_state,travel_direction,current_floor,passenger_weights,movement_duration,door_open_duration,global_time);
  List_Variables(Machine(machine))==(is_maintenance_key_inserted,button_press_timestamps,tested_maintenance_buttons,pending_requests,elevator_state,travel_direction,current_floor,passenger_weights,movement_duration,door_open_duration,global_time);
  External_List_Variables(Machine(machine))==(is_maintenance_key_inserted,button_press_timestamps,tested_maintenance_buttons,pending_requests,elevator_state,travel_direction,current_floor,passenger_weights,movement_duration,door_open_duration,global_time)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(machine))==(?);
  Abstract_List_VisibleVariables(Machine(machine))==(?);
  External_List_VisibleVariables(Machine(machine))==(?);
  Expanded_List_VisibleVariables(Machine(machine))==(?);
  List_VisibleVariables(Machine(machine))==(?);
  Internal_List_VisibleVariables(Machine(machine))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(machine))==(btrue);
  Gluing_List_Invariant(Machine(machine))==(btrue);
  Expanded_List_Invariant(Machine(machine))==(btrue);
  Abstract_List_Invariant(Machine(machine))==(btrue);
  Context_List_Invariant(Machine(machine))==(btrue);
  List_Invariant(Machine(machine))==(global_time: NATURAL & door_open_duration: NATURAL & movement_duration: NATURAL & passenger_weights: seq(NATURAL) & current_floor: NATURAL & current_floor: LEVELS & travel_direction: DIRECTIONS & elevator_state: ELEVATOR_STATUS & pending_requests <: BUTTONS & pending_requests: FIN(BUTTONS) & tested_maintenance_buttons <: BUTTONS & button_press_timestamps: BUTTONS +-> NATURAL & (current_floor = 0 => travel_direction = UP) & (current_floor = 2 => travel_direction = DOWN) & is_maintenance_key_inserted: BOOL)
END
&
THEORY ListAssertionsX IS
  Expanded_List_Assertions(Machine(machine))==(btrue);
  Abstract_List_Assertions(Machine(machine))==(btrue);
  Context_List_Assertions(Machine(machine))==(btrue);
  List_Assertions(Machine(machine))==(btrue)
END
&
THEORY ListCoverageX IS
  List_Coverage(Machine(machine))==(btrue)
END
&
THEORY ListExclusivityX IS
  List_Exclusivity(Machine(machine))==(btrue)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(machine))==(global_time,door_open_duration,movement_duration,passenger_weights,current_floor,travel_direction,elevator_state,pending_requests,tested_maintenance_buttons,button_press_timestamps,is_maintenance_key_inserted:=0,0,0,<>,0,UP,OPEN,{},{},{},FALSE);
  Context_List_Initialisation(Machine(machine))==(skip);
  List_Initialisation(Machine(machine))==(global_time:=0 || door_open_duration:=0 || movement_duration:=0 || passenger_weights:=<> || current_floor:=0 || travel_direction:=UP || elevator_state:=OPEN || pending_requests:={} || tested_maintenance_buttons:={} || button_press_timestamps:={} || is_maintenance_key_inserted:=FALSE)
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(machine))==(?)
END
&
THEORY ListInstanciatedParametersX END
&
THEORY ListConstraintsX IS
  List_Context_Constraints(Machine(machine))==(btrue);
  List_Constraints(Machine(machine))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(machine))==(pass_time,board_passenger,disembark_passenger,press_button,release_button,insert_maintenance_key,remove_key,open_door,close_door,start_moving);
  List_Operations(Machine(machine))==(pass_time,board_passenger,disembark_passenger,press_button,release_button,insert_maintenance_key,remove_key,open_door,close_door,start_moving)
END
&
THEORY ListInputX IS
  List_Input(Machine(machine),pass_time)==(seconds);
  List_Input(Machine(machine),board_passenger)==(weight);
  List_Input(Machine(machine),disembark_passenger)==(weight);
  List_Input(Machine(machine),press_button)==(button);
  List_Input(Machine(machine),release_button)==(button);
  List_Input(Machine(machine),insert_maintenance_key)==(?);
  List_Input(Machine(machine),remove_key)==(?);
  List_Input(Machine(machine),open_door)==(?);
  List_Input(Machine(machine),close_door)==(?);
  List_Input(Machine(machine),start_moving)==(?)
END
&
THEORY ListOutputX IS
  List_Output(Machine(machine),pass_time)==(?);
  List_Output(Machine(machine),board_passenger)==(?);
  List_Output(Machine(machine),disembark_passenger)==(?);
  List_Output(Machine(machine),press_button)==(?);
  List_Output(Machine(machine),release_button)==(?);
  List_Output(Machine(machine),insert_maintenance_key)==(?);
  List_Output(Machine(machine),remove_key)==(?);
  List_Output(Machine(machine),open_door)==(?);
  List_Output(Machine(machine),close_door)==(?);
  List_Output(Machine(machine),start_moving)==(?)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(machine),pass_time)==(pass_time(seconds));
  List_Header(Machine(machine),board_passenger)==(board_passenger(weight));
  List_Header(Machine(machine),disembark_passenger)==(disembark_passenger(weight));
  List_Header(Machine(machine),press_button)==(press_button(button));
  List_Header(Machine(machine),release_button)==(release_button(button));
  List_Header(Machine(machine),insert_maintenance_key)==(insert_maintenance_key);
  List_Header(Machine(machine),remove_key)==(remove_key);
  List_Header(Machine(machine),open_door)==(open_door);
  List_Header(Machine(machine),close_door)==(close_door);
  List_Header(Machine(machine),start_moving)==(start_moving)
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(machine),pass_time)==(seconds: NATURAL);
  List_Precondition(Machine(machine),board_passenger)==(elevator_state/:{IDLE,MOVING} & weight: NATURAL);
  List_Precondition(Machine(machine),disembark_passenger)==(elevator_state/:{IDLE,MOVING} & weight: NATURAL & weight: ran(passenger_weights));
  List_Precondition(Machine(machine),press_button)==(button: BUTTONS & button/:dom(button_press_timestamps));
  List_Precondition(Machine(machine),release_button)==(button: BUTTONS & button: dom(button_press_timestamps));
  List_Precondition(Machine(machine),insert_maintenance_key)==(is_maintenance_key_inserted = FALSE & elevator_state = BROKEN);
  List_Precondition(Machine(machine),remove_key)==(is_maintenance_key_inserted = TRUE);
  List_Precondition(Machine(machine),open_door)==(elevator_state = IDLE);
  List_Precondition(Machine(machine),close_door)==(elevator_state = OPEN);
  List_Precondition(Machine(machine),start_moving)==(elevator_state = IDLE & SIGMA(idx).(idx: dom(passenger_weights) | passenger_weights(idx))<=MAX_CAPACITY)
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(machine),start_moving)==(elevator_state = IDLE & SIGMA(idx).(idx: dom(passenger_weights) | passenger_weights(idx))<=MAX_CAPACITY | elevator_state:=MOVING || (current_floor = 0 & card(pending_requests-{L0,UP0})>0 ==> current_floor:=1 [] not(current_floor = 0 & card(pending_requests-{L0,UP0})>0) ==> (current_floor = 2 & card(pending_requests-{L2,DOWN2})>0 ==> current_floor:=1 [] not(current_floor = 2 & card(pending_requests-{L2,DOWN2})>0) ==> (current_floor = 1 ==> (travel_direction = UP ==> (card(pending_requests/\{L2,DOWN2})>0 ==> current_floor,travel_direction:=2,DOWN [] not(card(pending_requests/\{L2,DOWN2})>0) ==> (card(pending_requests/\{L0,UP0})>0 ==> current_floor:=0 [] not(card(pending_requests/\{L0,UP0})>0) ==> skip)) [] not(travel_direction = UP) ==> (travel_direction = DOWN ==> (card(pending_requests/\{L0,UP0})>0 ==> current_floor,travel_direction:=0,UP [] not(card(pending_requests/\{L0,UP0})>0) ==> (card(pending_requests/\{L2,DOWN2})>0 ==> current_floor:=2 [] not(card(pending_requests/\{L2,DOWN2})>0) ==> skip)) [] not(travel_direction = DOWN) ==> skip)) [] not(current_floor = 1) ==> skip))));
  Expanded_List_Substitution(Machine(machine),close_door)==(elevator_state = OPEN | elevator_state,door_open_duration:=IDLE,0);
  Expanded_List_Substitution(Machine(machine),open_door)==(elevator_state = IDLE | elevator_state:=OPEN || (current_floor = 0 ==> pending_requests:=pending_requests-{L0,UP0} [] not(current_floor = 0) ==> (current_floor = 1 & travel_direction = UP ==> pending_requests:=pending_requests-{L1,UP1} [] not(current_floor = 1 & travel_direction = UP) ==> (current_floor = 1 & travel_direction = DOWN ==> pending_requests:=pending_requests-{L1,DOWN1} [] not(current_floor = 1 & travel_direction = DOWN) ==> (current_floor = 2 ==> pending_requests:=pending_requests-{L2,DOWN2} [] not(current_floor = 2) ==> skip)))));
  Expanded_List_Substitution(Machine(machine),remove_key)==(is_maintenance_key_inserted = TRUE | is_maintenance_key_inserted,elevator_state:=FALSE,OPEN);
  Expanded_List_Substitution(Machine(machine),insert_maintenance_key)==(is_maintenance_key_inserted = FALSE & elevator_state = BROKEN | is_maintenance_key_inserted,elevator_state,pending_requests,button_press_timestamps:=TRUE,MAINTENANCE,{},{});
  Expanded_List_Substitution(Machine(machine),release_button)==(button: BUTTONS & button: dom(button_press_timestamps) | elevator_state = MAINTENANCE ==> tested_maintenance_buttons:=tested_maintenance_buttons\/{button} [] not(elevator_state = MAINTENANCE) ==> (global_time-button_press_timestamps(button)>=3 ==> pending_requests:=pending_requests-{button} [] not(global_time-button_press_timestamps(button)>=3) ==> pending_requests:=pending_requests\/{button}) || button_press_timestamps:={button}<<|button_press_timestamps);
  Expanded_List_Substitution(Machine(machine),press_button)==(button: BUTTONS & button/:dom(button_press_timestamps) | button_press_timestamps:=button_press_timestamps<+{button|->global_time});
  Expanded_List_Substitution(Machine(machine),disembark_passenger)==(elevator_state/:{IDLE,MOVING} & weight: NATURAL & weight: ran(passenger_weights) | @idx.(idx = min(passenger_weights~[{weight}]) ==> passenger_weights:=passenger_weights/|\idx-1^(passenger_weights\|/idx)));
  Expanded_List_Substitution(Machine(machine),board_passenger)==(elevator_state/:{IDLE,MOVING} & weight: NATURAL | passenger_weights:=passenger_weights<-weight);
  Expanded_List_Substitution(Machine(machine),pass_time)==(seconds: NATURAL | global_time,tested_maintenance_buttons:=global_time+seconds,{} || (elevator_state = OPEN ==> (door_open_duration+seconds>=120 ==> elevator_state,door_open_duration:=BROKEN,0 [] not(door_open_duration+seconds>=120) ==> door_open_duration:=door_open_duration+seconds) [] not(elevator_state = OPEN) ==> (elevator_state = MOVING ==> (movement_duration+seconds>=5 ==> elevator_state,movement_duration:=IDLE,0 [] not(movement_duration+seconds>=5) ==> movement_duration:=movement_duration+seconds) [] not(elevator_state = MOVING) ==> skip)));
  List_Substitution(Machine(machine),pass_time)==(global_time:=global_time+seconds || tested_maintenance_buttons:={} || IF elevator_state = OPEN THEN IF door_open_duration+seconds>=120 THEN elevator_state:=BROKEN || door_open_duration:=0 ELSE door_open_duration:=door_open_duration+seconds END ELSIF elevator_state = MOVING THEN IF movement_duration+seconds>=5 THEN elevator_state:=IDLE || movement_duration:=0 ELSE movement_duration:=movement_duration+seconds END END);
  List_Substitution(Machine(machine),board_passenger)==(passenger_weights:=passenger_weights<-weight);
  List_Substitution(Machine(machine),disembark_passenger)==(LET idx BE idx = min(passenger_weights~[{weight}]) IN passenger_weights:=passenger_weights/|\idx-1^(passenger_weights\|/idx) END);
  List_Substitution(Machine(machine),press_button)==(button_press_timestamps(button):=global_time);
  List_Substitution(Machine(machine),release_button)==(IF elevator_state = MAINTENANCE THEN tested_maintenance_buttons:=tested_maintenance_buttons\/{button} ELSIF global_time-button_press_timestamps(button)>=3 THEN pending_requests:=pending_requests-{button} ELSE pending_requests:=pending_requests\/{button} END || button_press_timestamps:={button}<<|button_press_timestamps);
  List_Substitution(Machine(machine),insert_maintenance_key)==(is_maintenance_key_inserted:=TRUE || elevator_state:=MAINTENANCE || pending_requests:={} || button_press_timestamps:={});
  List_Substitution(Machine(machine),remove_key)==(is_maintenance_key_inserted:=FALSE || elevator_state:=OPEN);
  List_Substitution(Machine(machine),open_door)==(elevator_state:=OPEN || IF current_floor = 0 THEN pending_requests:=pending_requests-{L0,UP0} ELSIF current_floor = 1 & travel_direction = UP THEN pending_requests:=pending_requests-{L1,UP1} ELSIF current_floor = 1 & travel_direction = DOWN THEN pending_requests:=pending_requests-{L1,DOWN1} ELSIF current_floor = 2 THEN pending_requests:=pending_requests-{L2,DOWN2} END);
  List_Substitution(Machine(machine),close_door)==(elevator_state:=IDLE || door_open_duration:=0);
  List_Substitution(Machine(machine),start_moving)==(elevator_state:=MOVING || IF current_floor = 0 & card(pending_requests-{L0,UP0})>0 THEN current_floor:=1 ELSIF current_floor = 2 & card(pending_requests-{L2,DOWN2})>0 THEN current_floor:=1 ELSIF current_floor = 1 THEN IF travel_direction = UP THEN IF card(pending_requests/\{L2,DOWN2})>0 THEN current_floor:=2 || travel_direction:=DOWN ELSIF card(pending_requests/\{L0,UP0})>0 THEN current_floor:=0 END ELSIF travel_direction = DOWN THEN IF card(pending_requests/\{L0,UP0})>0 THEN current_floor:=0 || travel_direction:=UP ELSIF card(pending_requests/\{L2,DOWN2})>0 THEN current_floor:=2 END END END)
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(machine))==(LEVELS,MAX_CAPACITY);
  Inherited_List_Constants(Machine(machine))==(?);
  List_Constants(Machine(machine))==(LEVELS,MAX_CAPACITY)
END
&
THEORY ListSetsX IS
  Set_Definition(Machine(machine),DIRECTIONS)==({UP,DOWN});
  Context_List_Enumerated(Machine(machine))==(?);
  Context_List_Defered(Machine(machine))==(?);
  Context_List_Sets(Machine(machine))==(?);
  List_Valuable_Sets(Machine(machine))==(?);
  Inherited_List_Enumerated(Machine(machine))==(?);
  Inherited_List_Defered(Machine(machine))==(?);
  Inherited_List_Sets(Machine(machine))==(?);
  List_Enumerated(Machine(machine))==(DIRECTIONS,ELEVATOR_STATUS,BUTTONS);
  List_Defered(Machine(machine))==(?);
  List_Sets(Machine(machine))==(DIRECTIONS,ELEVATOR_STATUS,BUTTONS);
  Set_Definition(Machine(machine),ELEVATOR_STATUS)==({OPEN,IDLE,MOVING,BROKEN,MAINTENANCE});
  Set_Definition(Machine(machine),BUTTONS)==({L0,L1,L2,UP0,UP1,DOWN1,DOWN2})
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(machine))==(?);
  Expanded_List_HiddenConstants(Machine(machine))==(?);
  List_HiddenConstants(Machine(machine))==(?);
  External_List_HiddenConstants(Machine(machine))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(machine))==(btrue);
  Context_List_Properties(Machine(machine))==(btrue);
  Inherited_List_Properties(Machine(machine))==(btrue);
  List_Properties(Machine(machine))==(LEVELS = 0..2 & MAX_CAPACITY = 450 & DIRECTIONS: FIN(INTEGER) & not(DIRECTIONS = {}) & ELEVATOR_STATUS: FIN(INTEGER) & not(ELEVATOR_STATUS = {}) & BUTTONS: FIN(INTEGER) & not(BUTTONS = {}))
END
&
THEORY ListSeenInfoX END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(machine),pass_time)==(?);
  List_ANY_Var(Machine(machine),board_passenger)==(?);
  List_ANY_Var(Machine(machine),disembark_passenger)==(?);
  List_ANY_Var(Machine(machine),press_button)==(?);
  List_ANY_Var(Machine(machine),release_button)==(?);
  List_ANY_Var(Machine(machine),insert_maintenance_key)==(?);
  List_ANY_Var(Machine(machine),remove_key)==(?);
  List_ANY_Var(Machine(machine),open_door)==(?);
  List_ANY_Var(Machine(machine),close_door)==(?);
  List_ANY_Var(Machine(machine),start_moving)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(machine)) == (LEVELS,MAX_CAPACITY,DIRECTIONS,ELEVATOR_STATUS,BUTTONS,UP,DOWN,OPEN,IDLE,MOVING,BROKEN,MAINTENANCE,L0,L1,L2,UP0,UP1,DOWN1,DOWN2 | ? | is_maintenance_key_inserted,button_press_timestamps,tested_maintenance_buttons,pending_requests,elevator_state,travel_direction,current_floor,passenger_weights,movement_duration,door_open_duration,global_time | ? | pass_time,board_passenger,disembark_passenger,press_button,release_button,insert_maintenance_key,remove_key,open_door,close_door,start_moving | ? | ? | ? | machine);
  List_Of_HiddenCst_Ids(Machine(machine)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(machine)) == (LEVELS,MAX_CAPACITY);
  List_Of_VisibleVar_Ids(Machine(machine)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(machine)) == (?: ?)
END
&
THEORY SetsEnvX IS
  Sets(Machine(machine)) == (Type(DIRECTIONS) == Cst(SetOf(etype(DIRECTIONS,0,1)));Type(ELEVATOR_STATUS) == Cst(SetOf(etype(ELEVATOR_STATUS,0,4)));Type(BUTTONS) == Cst(SetOf(etype(BUTTONS,0,6))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(machine)) == (Type(UP) == Cst(etype(DIRECTIONS,0,1));Type(DOWN) == Cst(etype(DIRECTIONS,0,1));Type(OPEN) == Cst(etype(ELEVATOR_STATUS,0,4));Type(IDLE) == Cst(etype(ELEVATOR_STATUS,0,4));Type(MOVING) == Cst(etype(ELEVATOR_STATUS,0,4));Type(BROKEN) == Cst(etype(ELEVATOR_STATUS,0,4));Type(MAINTENANCE) == Cst(etype(ELEVATOR_STATUS,0,4));Type(L0) == Cst(etype(BUTTONS,0,6));Type(L1) == Cst(etype(BUTTONS,0,6));Type(L2) == Cst(etype(BUTTONS,0,6));Type(UP0) == Cst(etype(BUTTONS,0,6));Type(UP1) == Cst(etype(BUTTONS,0,6));Type(DOWN1) == Cst(etype(BUTTONS,0,6));Type(DOWN2) == Cst(etype(BUTTONS,0,6));Type(LEVELS) == Cst(SetOf(btype(INTEGER,"[LEVELS","]LEVELS")));Type(MAX_CAPACITY) == Cst(btype(INTEGER,?,?)))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(machine)) == (Type(is_maintenance_key_inserted) == Mvl(btype(BOOL,?,?));Type(button_press_timestamps) == Mvl(SetOf(etype(BUTTONS,?,?)*btype(INTEGER,?,?)));Type(tested_maintenance_buttons) == Mvl(SetOf(etype(BUTTONS,?,?)));Type(pending_requests) == Mvl(SetOf(etype(BUTTONS,?,?)));Type(elevator_state) == Mvl(etype(ELEVATOR_STATUS,?,?));Type(travel_direction) == Mvl(etype(DIRECTIONS,?,?));Type(current_floor) == Mvl(btype(INTEGER,?,?));Type(passenger_weights) == Mvl(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)));Type(movement_duration) == Mvl(btype(INTEGER,?,?));Type(door_open_duration) == Mvl(btype(INTEGER,?,?));Type(global_time) == Mvl(btype(INTEGER,?,?)))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(machine)) == (Type(start_moving) == Cst(No_type,No_type);Type(close_door) == Cst(No_type,No_type);Type(open_door) == Cst(No_type,No_type);Type(remove_key) == Cst(No_type,No_type);Type(insert_maintenance_key) == Cst(No_type,No_type);Type(release_button) == Cst(No_type,etype(BUTTONS,?,?));Type(press_button) == Cst(No_type,etype(BUTTONS,?,?));Type(disembark_passenger) == Cst(No_type,btype(INTEGER,?,?));Type(board_passenger) == Cst(No_type,btype(INTEGER,?,?));Type(pass_time) == Cst(No_type,btype(INTEGER,?,?)))
END
&
THEORY TCIntRdX IS
  predB0 == OK;
  extended_sees == KO;
  B0check_tab == KO;
  local_op == OK;
  abstract_constants_visible_in_values == KO;
  project_type == SOFTWARE_TYPE;
  event_b_deadlockfreeness == KO;
  variant_clause_mandatory == KO;
  event_b_coverage == KO;
  event_b_exclusivity == KO;
  genFeasibilityPO == KO
END
)
