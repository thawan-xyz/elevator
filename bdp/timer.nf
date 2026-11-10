Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(timer))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(timer))==(Machine(timer));
  Level(Machine(timer))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(timer)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(timer))==(?)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(timer))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(timer))==(machine);
  List_Includes(Machine(timer))==(machine)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(timer))==(board_passenger,disembark_passenger,insert_maintenance_key,remove_key,open_door,close_door)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(timer))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(timer))==(?);
  Context_List_Variables(Machine(timer))==(?);
  Abstract_List_Variables(Machine(timer))==(?);
  Local_List_Variables(Machine(timer))==(movement_duration,door_open_duration,global_time);
  List_Variables(Machine(timer))==(movement_duration,door_open_duration,global_time,is_maintenance_key_inserted,button_press_timestamps,tested_maintenance_buttons,pending_requests,elevator_state,travel_direction,current_floor,passenger_weights);
  External_List_Variables(Machine(timer))==(movement_duration,door_open_duration,global_time,is_maintenance_key_inserted,button_press_timestamps,tested_maintenance_buttons,pending_requests,elevator_state,travel_direction,current_floor,passenger_weights)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(timer))==(?);
  Abstract_List_VisibleVariables(Machine(timer))==(?);
  External_List_VisibleVariables(Machine(timer))==(?);
  Expanded_List_VisibleVariables(Machine(timer))==(?);
  List_VisibleVariables(Machine(timer))==(?);
  Internal_List_VisibleVariables(Machine(timer))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(timer))==(btrue);
  Gluing_List_Invariant(Machine(timer))==(btrue);
  Abstract_List_Invariant(Machine(timer))==(btrue);
  Expanded_List_Invariant(Machine(timer))==(passenger_weights: seq(NATURAL) & current_floor: NATURAL & current_floor: LEVELS & travel_direction: DIRECTIONS & elevator_state: ELEVATOR_STATUS & pending_requests <: BUTTONS & pending_requests: FIN(BUTTONS) & tested_maintenance_buttons <: BUTTONS & button_press_timestamps: BUTTONS +-> NATURAL & (current_floor = 0 => travel_direction = UP) & (current_floor = 2 => travel_direction = DOWN) & is_maintenance_key_inserted: BOOL);
  Context_List_Invariant(Machine(timer))==(btrue);
  List_Invariant(Machine(timer))==(global_time: NATURAL & door_open_duration: 0..119 & movement_duration: 0..4 & ran(button_press_timestamps) <: 0..global_time)
END
&
THEORY ListAssertionsX IS
  Abstract_List_Assertions(Machine(timer))==(btrue);
  Expanded_List_Assertions(Machine(timer))==(btrue);
  Context_List_Assertions(Machine(timer))==(btrue);
  List_Assertions(Machine(timer))==(btrue)
END
&
THEORY ListCoverageX IS
  List_Coverage(Machine(timer))==(btrue)
END
&
THEORY ListExclusivityX IS
  List_Exclusivity(Machine(timer))==(btrue)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(timer))==(passenger_weights,current_floor,travel_direction,elevator_state,pending_requests,tested_maintenance_buttons,button_press_timestamps,is_maintenance_key_inserted:=<>,0,UP,OPEN,{},{},{},FALSE;global_time,door_open_duration,movement_duration:=0,0,0);
  Context_List_Initialisation(Machine(timer))==(skip);
  List_Initialisation(Machine(timer))==(global_time:=0 || door_open_duration:=0 || movement_duration:=0)
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(timer))==(?)
END
&
THEORY ListInstanciatedParametersX IS
  List_Instanciated_Parameters(Machine(timer),Machine(machine))==(?)
END
&
THEORY ListConstraintsX IS
  List_Constraints(Machine(timer),Machine(machine))==(btrue);
  List_Context_Constraints(Machine(timer))==(btrue);
  List_Constraints(Machine(timer))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(timer))==(tick,press_button,release_button,board_passenger,disembark_passenger,insert_maintenance_key,remove_key,open_door,close_door);
  List_Operations(Machine(timer))==(tick,press_button,release_button,board_passenger,disembark_passenger,insert_maintenance_key,remove_key,open_door,close_door)
END
&
THEORY ListInputX IS
  List_Input(Machine(timer),close_door)==(?);
  List_Input(Machine(timer),open_door)==(?);
  List_Input(Machine(timer),remove_key)==(?);
  List_Input(Machine(timer),insert_maintenance_key)==(?);
  List_Input(Machine(timer),disembark_passenger)==(weight);
  List_Input(Machine(timer),board_passenger)==(weight);
  List_Input(Machine(timer),tick)==(?);
  List_Input(Machine(timer),press_button)==(button);
  List_Input(Machine(timer),release_button)==(button)
END
&
THEORY ListOutputX IS
  List_Output(Machine(timer),close_door)==(?);
  List_Output(Machine(timer),open_door)==(?);
  List_Output(Machine(timer),remove_key)==(?);
  List_Output(Machine(timer),insert_maintenance_key)==(?);
  List_Output(Machine(timer),disembark_passenger)==(?);
  List_Output(Machine(timer),board_passenger)==(?);
  List_Output(Machine(timer),tick)==(?);
  List_Output(Machine(timer),press_button)==(?);
  List_Output(Machine(timer),release_button)==(?)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(timer),close_door)==(close_door);
  List_Header(Machine(timer),open_door)==(open_door);
  List_Header(Machine(timer),remove_key)==(remove_key);
  List_Header(Machine(timer),insert_maintenance_key)==(insert_maintenance_key);
  List_Header(Machine(timer),disembark_passenger)==(disembark_passenger(weight));
  List_Header(Machine(timer),board_passenger)==(board_passenger(weight));
  List_Header(Machine(timer),tick)==(tick);
  List_Header(Machine(timer),press_button)==(press_button(button));
  List_Header(Machine(timer),release_button)==(release_button(button))
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  Own_Precondition(Machine(timer),close_door)==(elevator_state = OPEN);
  List_Precondition(Machine(timer),close_door)==(elevator_state = OPEN);
  Own_Precondition(Machine(timer),open_door)==(elevator_state = IDLE);
  List_Precondition(Machine(timer),open_door)==(elevator_state = IDLE);
  Own_Precondition(Machine(timer),remove_key)==(is_maintenance_key_inserted = TRUE);
  List_Precondition(Machine(timer),remove_key)==(is_maintenance_key_inserted = TRUE);
  Own_Precondition(Machine(timer),insert_maintenance_key)==(is_maintenance_key_inserted = FALSE & elevator_state = BROKEN);
  List_Precondition(Machine(timer),insert_maintenance_key)==(is_maintenance_key_inserted = FALSE & elevator_state = BROKEN);
  Own_Precondition(Machine(timer),disembark_passenger)==(elevator_state/:{IDLE,MOVING} & weight: NATURAL & weight: ran(passenger_weights));
  List_Precondition(Machine(timer),disembark_passenger)==(elevator_state/:{IDLE,MOVING} & weight: NATURAL & weight: ran(passenger_weights));
  Own_Precondition(Machine(timer),board_passenger)==(elevator_state/:{IDLE,MOVING} & weight: NATURAL);
  List_Precondition(Machine(timer),board_passenger)==(elevator_state/:{IDLE,MOVING} & weight: NATURAL);
  List_Precondition(Machine(timer),tick)==(btrue);
  List_Precondition(Machine(timer),press_button)==(button: BUTTONS & button/:dom(button_press_timestamps));
  List_Precondition(Machine(timer),release_button)==(button: BUTTONS & button: dom(button_press_timestamps))
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(timer),release_button)==(button: BUTTONS & button: dom(button_press_timestamps) & button: BUTTONS & button: dom(button_press_timestamps) & global_time: NATURAL | elevator_state = MAINTENANCE ==> tested_maintenance_buttons:=tested_maintenance_buttons\/{button} [] not(elevator_state = MAINTENANCE) ==> (global_time-button_press_timestamps(button)>=3 ==> pending_requests:=pending_requests-{button} [] not(global_time-button_press_timestamps(button)>=3) ==> pending_requests:=pending_requests\/{button}) || button_press_timestamps:={button}<<|button_press_timestamps);
  Expanded_List_Substitution(Machine(timer),press_button)==(button: BUTTONS & button/:dom(button_press_timestamps) & button: BUTTONS & button/:dom(button_press_timestamps) & global_time: NATURAL | button_press_timestamps:=button_press_timestamps<+{button|->global_time});
  Expanded_List_Substitution(Machine(timer),tick)==(btrue & bool(door_open_duration+1>=120): BOOL & bool(movement_duration+1>=5): BOOL | global_time:=global_time+1 || (elevator_state = OPEN & door_open_duration+1<120 ==> door_open_duration:=door_open_duration+1 [] not(elevator_state = OPEN & door_open_duration+1<120) ==> door_open_duration:=0) || (elevator_state = MOVING & movement_duration+1<5 ==> movement_duration:=movement_duration+1 [] not(elevator_state = MOVING & movement_duration+1<5) ==> movement_duration:=0) || (tested_maintenance_buttons:={} || @served.(served = SERVED[{current_floor|->travel_direction}] ==> (elevator_state = OPEN & bool(door_open_duration+1>=120) = TRUE ==> elevator_state:=BROKEN [] not(elevator_state = OPEN & bool(door_open_duration+1>=120) = TRUE) ==> (elevator_state = MOVING & bool(movement_duration+1>=5) = TRUE ==> (pending_requests/\served/={} ==> elevator_state,pending_requests:=OPEN,pending_requests-served [] not(pending_requests/\served/={}) ==> elevator_state:=IDLE) [] not(elevator_state = MOVING & bool(movement_duration+1>=5) = TRUE) ==> (elevator_state = IDLE & pending_requests/\served/={} ==> elevator_state,pending_requests:=OPEN,pending_requests-served [] not(elevator_state = IDLE & pending_requests/\served/={}) ==> (elevator_state = IDLE & SIGMA(idx).(idx: dom(passenger_weights) | passenger_weights(idx))<=MAX_CAPACITY ==> (current_floor = 0 & pending_requests-{L0,UP0}/={} ==> elevator_state,current_floor:=MOVING,1 [] not(current_floor = 0 & pending_requests-{L0,UP0}/={}) ==> (current_floor = 2 & pending_requests-{L2,DOWN2}/={} ==> elevator_state,current_floor:=MOVING,1 [] not(current_floor = 2 & pending_requests-{L2,DOWN2}/={}) ==> (current_floor = 1 & travel_direction = UP & pending_requests/\{L2,DOWN2}/={} ==> elevator_state,current_floor,travel_direction:=MOVING,2,DOWN [] not(current_floor = 1 & travel_direction = UP & pending_requests/\{L2,DOWN2}/={}) ==> (current_floor = 1 & travel_direction = DOWN & pending_requests/\{L0,UP0}/={} ==> elevator_state,current_floor,travel_direction:=MOVING,0,UP [] not(current_floor = 1 & travel_direction = DOWN & pending_requests/\{L0,UP0}/={}) ==> (current_floor = 1 & travel_direction = UP & DOWN1: pending_requests ==> travel_direction:=DOWN [] not(current_floor = 1 & travel_direction = UP & DOWN1: pending_requests) ==> (current_floor = 1 & travel_direction = DOWN & UP1: pending_requests ==> travel_direction:=UP [] not(current_floor = 1 & travel_direction = DOWN & UP1: pending_requests) ==> (current_floor = 1 & pending_requests/\{L0,UP0}/={} ==> elevator_state,current_floor,travel_direction:=MOVING,0,UP [] not(current_floor = 1 & pending_requests/\{L0,UP0}/={}) ==> (current_floor = 1 & pending_requests/\{L2,DOWN2}/={} ==> elevator_state,current_floor,travel_direction:=MOVING,2,DOWN [] not(current_floor = 1 & pending_requests/\{L2,DOWN2}/={}) ==> skip)))))))) [] not(elevator_state = IDLE & SIGMA(idx).(idx: dom(passenger_weights) | passenger_weights(idx))<=MAX_CAPACITY) ==> skip)))))));
  List_Substitution(Machine(timer),close_door)==(elevator_state:=IDLE);
  Expanded_List_Substitution(Machine(timer),close_door)==(elevator_state = OPEN | elevator_state:=IDLE);
  List_Substitution(Machine(timer),open_door)==(elevator_state:=OPEN || pending_requests:=pending_requests-SERVED[{current_floor|->travel_direction}]);
  Expanded_List_Substitution(Machine(timer),open_door)==(elevator_state = IDLE | elevator_state,pending_requests:=OPEN,pending_requests-SERVED[{current_floor|->travel_direction}]);
  List_Substitution(Machine(timer),remove_key)==(is_maintenance_key_inserted:=FALSE || elevator_state:=OPEN);
  Expanded_List_Substitution(Machine(timer),remove_key)==(is_maintenance_key_inserted = TRUE | is_maintenance_key_inserted,elevator_state:=FALSE,OPEN);
  List_Substitution(Machine(timer),insert_maintenance_key)==(is_maintenance_key_inserted:=TRUE || elevator_state:=MAINTENANCE || pending_requests:={} || button_press_timestamps:={});
  Expanded_List_Substitution(Machine(timer),insert_maintenance_key)==(is_maintenance_key_inserted = FALSE & elevator_state = BROKEN | is_maintenance_key_inserted,elevator_state,pending_requests,button_press_timestamps:=TRUE,MAINTENANCE,{},{});
  List_Substitution(Machine(timer),disembark_passenger)==(ANY idx WHERE idx: dom(passenger_weights) & passenger_weights(idx) = weight THEN passenger_weights:=passenger_weights/|\idx-1^(passenger_weights\|/idx) END);
  Expanded_List_Substitution(Machine(timer),disembark_passenger)==(elevator_state/:{IDLE,MOVING} & weight: NATURAL & weight: ran(passenger_weights) | @idx.(idx: dom(passenger_weights) & passenger_weights(idx) = weight ==> passenger_weights:=passenger_weights/|\idx-1^(passenger_weights\|/idx)));
  List_Substitution(Machine(timer),board_passenger)==(passenger_weights:=passenger_weights<-weight);
  Expanded_List_Substitution(Machine(timer),board_passenger)==(elevator_state/:{IDLE,MOVING} & weight: NATURAL | passenger_weights:=passenger_weights<-weight);
  List_Substitution(Machine(timer),tick)==(global_time:=global_time+1 || IF elevator_state = OPEN & door_open_duration+1<120 THEN door_open_duration:=door_open_duration+1 ELSE door_open_duration:=0 END || IF elevator_state = MOVING & movement_duration+1<5 THEN movement_duration:=movement_duration+1 ELSE movement_duration:=0 END || time_step(bool(door_open_duration+1>=120),bool(movement_duration+1>=5)));
  List_Substitution(Machine(timer),press_button)==(press_button_at(button,global_time));
  List_Substitution(Machine(timer),release_button)==(release_button_at(button,global_time))
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(timer))==(LEVELS,MAX_CAPACITY,SERVED);
  Inherited_List_Constants(Machine(timer))==(LEVELS,MAX_CAPACITY,SERVED);
  List_Constants(Machine(timer))==(?)
END
&
THEORY ListSetsX IS
  Set_Definition(Machine(timer),BUTTONS)==({L0,L1,L2,UP0,UP1,DOWN1,DOWN2});
  Context_List_Enumerated(Machine(timer))==(?);
  Context_List_Defered(Machine(timer))==(?);
  Context_List_Sets(Machine(timer))==(?);
  List_Valuable_Sets(Machine(timer))==(?);
  Inherited_List_Enumerated(Machine(timer))==(DIRECTIONS,ELEVATOR_STATUS,BUTTONS);
  Inherited_List_Defered(Machine(timer))==(?);
  Inherited_List_Sets(Machine(timer))==(DIRECTIONS,ELEVATOR_STATUS,BUTTONS);
  List_Enumerated(Machine(timer))==(?);
  List_Defered(Machine(timer))==(?);
  List_Sets(Machine(timer))==(?);
  Set_Definition(Machine(timer),ELEVATOR_STATUS)==({OPEN,IDLE,MOVING,BROKEN,MAINTENANCE});
  Set_Definition(Machine(timer),DIRECTIONS)==({UP,DOWN})
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(timer))==(?);
  Expanded_List_HiddenConstants(Machine(timer))==(?);
  List_HiddenConstants(Machine(timer))==(?);
  External_List_HiddenConstants(Machine(timer))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(timer))==(btrue);
  Context_List_Properties(Machine(timer))==(btrue);
  Inherited_List_Properties(Machine(timer))==(LEVELS = 0..2 & MAX_CAPACITY = 450 & SERVED: LEVELS*DIRECTIONS <-> BUTTONS & SERVED = {0|->UP|->L0,0|->UP|->UP0,0|->DOWN|->L0,0|->DOWN|->UP0,1|->UP|->L1,1|->UP|->UP1,1|->DOWN|->L1,1|->DOWN|->DOWN1,2|->UP|->L2,2|->UP|->DOWN2,2|->DOWN|->L2,2|->DOWN|->DOWN2} & DIRECTIONS: FIN(INTEGER) & not(DIRECTIONS = {}) & ELEVATOR_STATUS: FIN(INTEGER) & not(ELEVATOR_STATUS = {}) & BUTTONS: FIN(INTEGER) & not(BUTTONS = {}));
  List_Properties(Machine(timer))==(btrue)
END
&
THEORY ListSeenInfoX END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(timer),close_door)==(?);
  List_ANY_Var(Machine(timer),open_door)==(?);
  List_ANY_Var(Machine(timer),remove_key)==(?);
  List_ANY_Var(Machine(timer),insert_maintenance_key)==(?);
  List_ANY_Var(Machine(timer),disembark_passenger)==(Var(idx) == btype(INTEGER,?,?));
  List_ANY_Var(Machine(timer),board_passenger)==(?);
  List_ANY_Var(Machine(timer),tick)==(?);
  List_ANY_Var(Machine(timer),press_button)==(?);
  List_ANY_Var(Machine(timer),release_button)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(timer)) == (? | LEVELS,MAX_CAPACITY,SERVED,DIRECTIONS,ELEVATOR_STATUS,BUTTONS,UP,DOWN,OPEN,IDLE,MOVING,BROKEN,MAINTENANCE,L0,L1,L2,UP0,UP1,DOWN1,DOWN2 | movement_duration,door_open_duration,global_time | V,is_maintenance_key_inserted,button_press_timestamps,tested_maintenance_buttons,pending_requests,elevator_state,travel_direction,current_floor,passenger_weights | tick,press_button,release_button | board_passenger,disembark_passenger,insert_maintenance_key,remove_key,open_door,close_door | included(Machine(machine)) | ? | timer);
  List_Of_HiddenCst_Ids(Machine(timer)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(timer)) == (LEVELS,MAX_CAPACITY,SERVED);
  List_Of_VisibleVar_Ids(Machine(timer)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(timer)) == (?: ?);
  List_Of_Ids(Machine(machine)) == (LEVELS,MAX_CAPACITY,SERVED,DIRECTIONS,ELEVATOR_STATUS,BUTTONS,UP,DOWN,OPEN,IDLE,MOVING,BROKEN,MAINTENANCE,L0,L1,L2,UP0,UP1,DOWN1,DOWN2 | ? | is_maintenance_key_inserted,button_press_timestamps,tested_maintenance_buttons,pending_requests,elevator_state,travel_direction,current_floor,passenger_weights | ? | time_step,board_passenger,disembark_passenger,press_button_at,release_button_at,insert_maintenance_key,remove_key,open_door,close_door | ? | ? | ? | machine);
  List_Of_HiddenCst_Ids(Machine(machine)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(machine)) == (LEVELS,MAX_CAPACITY,SERVED);
  List_Of_VisibleVar_Ids(Machine(machine)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(machine)) == (?: ?)
END
&
THEORY SetsEnvX IS
  Sets(Machine(timer)) == (Type(BUTTONS) == Cst(SetOf(etype(BUTTONS,0,6)));Type(ELEVATOR_STATUS) == Cst(SetOf(etype(ELEVATOR_STATUS,0,4)));Type(DIRECTIONS) == Cst(SetOf(etype(DIRECTIONS,0,1))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(timer)) == (Type(SERVED) == Cst(SetOf(btype(INTEGER,?,?)*etype(DIRECTIONS,?,?)*etype(BUTTONS,?,?)));Type(MAX_CAPACITY) == Cst(btype(INTEGER,?,?));Type(LEVELS) == Cst(SetOf(btype(INTEGER,"[LEVELS","]LEVELS")));Type(DOWN2) == Cst(etype(BUTTONS,0,6));Type(DOWN1) == Cst(etype(BUTTONS,0,6));Type(UP1) == Cst(etype(BUTTONS,0,6));Type(UP0) == Cst(etype(BUTTONS,0,6));Type(L2) == Cst(etype(BUTTONS,0,6));Type(L1) == Cst(etype(BUTTONS,0,6));Type(L0) == Cst(etype(BUTTONS,0,6));Type(MAINTENANCE) == Cst(etype(ELEVATOR_STATUS,0,4));Type(BROKEN) == Cst(etype(ELEVATOR_STATUS,0,4));Type(MOVING) == Cst(etype(ELEVATOR_STATUS,0,4));Type(IDLE) == Cst(etype(ELEVATOR_STATUS,0,4));Type(OPEN) == Cst(etype(ELEVATOR_STATUS,0,4));Type(DOWN) == Cst(etype(DIRECTIONS,0,1));Type(UP) == Cst(etype(DIRECTIONS,0,1)))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(timer)) == (Type(passenger_weights) == Mvl(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)));Type(current_floor) == Mvl(btype(INTEGER,?,?));Type(travel_direction) == Mvl(etype(DIRECTIONS,?,?));Type(elevator_state) == Mvl(etype(ELEVATOR_STATUS,?,?));Type(pending_requests) == Mvl(SetOf(etype(BUTTONS,?,?)));Type(tested_maintenance_buttons) == Mvl(SetOf(etype(BUTTONS,?,?)));Type(button_press_timestamps) == Mvl(SetOf(etype(BUTTONS,?,?)*btype(INTEGER,?,?)));Type(is_maintenance_key_inserted) == Mvl(btype(BOOL,?,?));Type(movement_duration) == Mvl(btype(INTEGER,?,?));Type(door_open_duration) == Mvl(btype(INTEGER,?,?));Type(global_time) == Mvl(btype(INTEGER,?,?)))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(timer)) == (Type(board_passenger) == Cst(No_type,btype(INTEGER,?,?));Type(disembark_passenger) == Cst(No_type,btype(INTEGER,?,?));Type(insert_maintenance_key) == Cst(No_type,No_type);Type(remove_key) == Cst(No_type,No_type);Type(open_door) == Cst(No_type,No_type);Type(close_door) == Cst(No_type,No_type);Type(release_button) == Cst(No_type,etype(BUTTONS,?,?));Type(press_button) == Cst(No_type,etype(BUTTONS,?,?));Type(tick) == Cst(No_type,No_type))
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
