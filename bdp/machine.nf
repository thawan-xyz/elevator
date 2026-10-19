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
  Local_List_Variables(Machine(machine))==(key_inserted,pressed_buttons,active_buttons,elevator_status,direction,level,frequency,elevator_weight,time_open,time);
  List_Variables(Machine(machine))==(key_inserted,pressed_buttons,active_buttons,elevator_status,direction,level,frequency,elevator_weight,time_open,time);
  External_List_Variables(Machine(machine))==(key_inserted,pressed_buttons,active_buttons,elevator_status,direction,level,frequency,elevator_weight,time_open,time)
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
  List_Invariant(Machine(machine))==(time: NATURAL & time_open: NATURAL & elevator_weight: NATURAL & frequency: NATURAL +-> NATURAL1 & level: NATURAL & level: LEVELS & direction: DIRECTIONS & elevator_status: ELEVATOR_STATUS & active_buttons <: BUTTONS & pressed_buttons: BUTTONS +-> NATURAL & key_inserted: BOOL)
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
  Expanded_List_Initialisation(Machine(machine))==(time,time_open,elevator_weight,frequency,level,direction,elevator_status,active_buttons,pressed_buttons,key_inserted:=0,0,0,{},0,UP,IDLE,{},{},FALSE);
  Context_List_Initialisation(Machine(machine))==(skip);
  List_Initialisation(Machine(machine))==(time:=0 || time_open:=0 || elevator_weight:=0 || frequency:={} || level:=0 || direction:=UP || elevator_status:=IDLE || active_buttons:={} || pressed_buttons:={} || key_inserted:=FALSE)
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
  Internal_List_Operations(Machine(machine))==(pass_time,insert_person,remove_person,press_button,release_button,insert_key,remove_key);
  List_Operations(Machine(machine))==(pass_time,insert_person,remove_person,press_button,release_button,insert_key,remove_key)
END
&
THEORY ListInputX IS
  List_Input(Machine(machine),pass_time)==(seconds);
  List_Input(Machine(machine),insert_person)==(weight);
  List_Input(Machine(machine),remove_person)==(weight);
  List_Input(Machine(machine),press_button)==(button);
  List_Input(Machine(machine),release_button)==(button);
  List_Input(Machine(machine),insert_key)==(?);
  List_Input(Machine(machine),remove_key)==(?)
END
&
THEORY ListOutputX IS
  List_Output(Machine(machine),pass_time)==(?);
  List_Output(Machine(machine),insert_person)==(?);
  List_Output(Machine(machine),remove_person)==(?);
  List_Output(Machine(machine),press_button)==(?);
  List_Output(Machine(machine),release_button)==(?);
  List_Output(Machine(machine),insert_key)==(?);
  List_Output(Machine(machine),remove_key)==(?)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(machine),pass_time)==(pass_time(seconds));
  List_Header(Machine(machine),insert_person)==(insert_person(weight));
  List_Header(Machine(machine),remove_person)==(remove_person(weight));
  List_Header(Machine(machine),press_button)==(press_button(button));
  List_Header(Machine(machine),release_button)==(release_button(button));
  List_Header(Machine(machine),insert_key)==(insert_key);
  List_Header(Machine(machine),remove_key)==(remove_key)
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(machine),pass_time)==(seconds: NATURAL);
  List_Precondition(Machine(machine),insert_person)==(elevator_status/:{IDLE,MOVING} & weight: NATURAL);
  List_Precondition(Machine(machine),remove_person)==(elevator_status/:{IDLE,MOVING} & weight: NATURAL & weight: dom(frequency) & weight<=elevator_weight);
  List_Precondition(Machine(machine),press_button)==(button: BUTTONS & button/:dom(pressed_buttons));
  List_Precondition(Machine(machine),release_button)==(button: BUTTONS & button: dom(pressed_buttons));
  List_Precondition(Machine(machine),insert_key)==(key_inserted = FALSE & elevator_status = BROKEN);
  List_Precondition(Machine(machine),remove_key)==(key_inserted = TRUE)
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(machine),remove_key)==(key_inserted = TRUE | key_inserted,elevator_status:=FALSE,IDLE);
  Expanded_List_Substitution(Machine(machine),insert_key)==(key_inserted = FALSE & elevator_status = BROKEN | key_inserted,elevator_status,active_buttons,pressed_buttons:=TRUE,MAINTENANCE,{},{});
  Expanded_List_Substitution(Machine(machine),release_button)==(button: BUTTONS & button: dom(pressed_buttons) | elevator_status = MAINTENANCE ==> skip [] not(elevator_status = MAINTENANCE) ==> (time-pressed_buttons(button)>=3 ==> active_buttons:=active_buttons-{button} [] not(time-pressed_buttons(button)>=3) ==> active_buttons:=active_buttons\/{button}) || pressed_buttons:={button}<<|pressed_buttons);
  Expanded_List_Substitution(Machine(machine),press_button)==(button: BUTTONS & button/:dom(pressed_buttons) | elevator_status = MAINTENANCE ==> skip [] not(elevator_status = MAINTENANCE) ==> pressed_buttons:=pressed_buttons<+{button|->time});
  Expanded_List_Substitution(Machine(machine),remove_person)==(elevator_status/:{IDLE,MOVING} & weight: NATURAL & weight: dom(frequency) & weight<=elevator_weight | elevator_weight:=elevator_weight-weight || (frequency(weight) = 1 ==> frequency:={weight}<<|frequency [] not(frequency(weight) = 1) ==> frequency:=frequency<+{weight|->frequency(weight)-1}));
  Expanded_List_Substitution(Machine(machine),insert_person)==(elevator_status/:{IDLE,MOVING} & weight: NATURAL | elevator_weight:=elevator_weight+weight || (weight: dom(frequency) ==> frequency:=frequency<+{weight|->frequency(weight)+1} [] not(weight: dom(frequency)) ==> frequency:=frequency<+{weight|->1}));
  Expanded_List_Substitution(Machine(machine),pass_time)==(seconds: NATURAL | time:=time+seconds || (elevator_status = OPEN ==> (time_open+seconds>=120 ==> elevator_status,time_open:=BROKEN,0 [] not(time_open+seconds>=120) ==> time_open:=time_open+seconds) [] not(elevator_status = OPEN) ==> skip));
  List_Substitution(Machine(machine),pass_time)==(time:=time+seconds || IF elevator_status = OPEN THEN IF time_open+seconds>=120 THEN elevator_status:=BROKEN || time_open:=0 ELSE time_open:=time_open+seconds END END);
  List_Substitution(Machine(machine),insert_person)==(elevator_weight:=elevator_weight+weight || IF weight: dom(frequency) THEN frequency(weight):=frequency(weight)+1 ELSE frequency(weight):=1 END);
  List_Substitution(Machine(machine),remove_person)==(elevator_weight:=elevator_weight-weight || IF frequency(weight) = 1 THEN frequency:={weight}<<|frequency ELSE frequency(weight):=frequency(weight)-1 END);
  List_Substitution(Machine(machine),press_button)==(IF elevator_status = MAINTENANCE THEN skip ELSE pressed_buttons(button):=time END);
  List_Substitution(Machine(machine),release_button)==(IF elevator_status = MAINTENANCE THEN skip ELSIF time-pressed_buttons(button)>=3 THEN active_buttons:=active_buttons-{button} ELSE active_buttons:=active_buttons\/{button} END || pressed_buttons:={button}<<|pressed_buttons);
  List_Substitution(Machine(machine),insert_key)==(key_inserted:=TRUE || elevator_status:=MAINTENANCE || active_buttons:={} || pressed_buttons:={});
  List_Substitution(Machine(machine),remove_key)==(key_inserted:=FALSE || elevator_status:=IDLE)
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
  List_ANY_Var(Machine(machine),insert_person)==(?);
  List_ANY_Var(Machine(machine),remove_person)==(?);
  List_ANY_Var(Machine(machine),press_button)==(?);
  List_ANY_Var(Machine(machine),release_button)==(?);
  List_ANY_Var(Machine(machine),insert_key)==(?);
  List_ANY_Var(Machine(machine),remove_key)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(machine)) == (LEVELS,MAX_CAPACITY,DIRECTIONS,ELEVATOR_STATUS,BUTTONS,UP,DOWN,OPEN,IDLE,MOVING,BROKEN,MAINTENANCE,L0,L1,L2,UP0,UP1,DOWN1,DOWN2 | ? | key_inserted,pressed_buttons,active_buttons,elevator_status,direction,level,frequency,elevator_weight,time_open,time | ? | pass_time,insert_person,remove_person,press_button,release_button,insert_key,remove_key | ? | ? | ? | machine);
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
  Variables(Machine(machine)) == (Type(key_inserted) == Mvl(btype(BOOL,?,?));Type(pressed_buttons) == Mvl(SetOf(etype(BUTTONS,?,?)*btype(INTEGER,?,?)));Type(active_buttons) == Mvl(SetOf(etype(BUTTONS,?,?)));Type(elevator_status) == Mvl(etype(ELEVATOR_STATUS,?,?));Type(direction) == Mvl(etype(DIRECTIONS,?,?));Type(level) == Mvl(btype(INTEGER,?,?));Type(frequency) == Mvl(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)));Type(elevator_weight) == Mvl(btype(INTEGER,?,?));Type(time_open) == Mvl(btype(INTEGER,?,?));Type(time) == Mvl(btype(INTEGER,?,?)))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(machine)) == (Type(remove_key) == Cst(No_type,No_type);Type(insert_key) == Cst(No_type,No_type);Type(release_button) == Cst(No_type,etype(BUTTONS,?,?));Type(press_button) == Cst(No_type,etype(BUTTONS,?,?));Type(remove_person) == Cst(No_type,btype(INTEGER,?,?));Type(insert_person) == Cst(No_type,btype(INTEGER,?,?));Type(pass_time) == Cst(No_type,btype(INTEGER,?,?)))
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
