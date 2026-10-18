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
  Local_List_Variables(Machine(machine))==(doors,status,requests,direction,level,weights,weight,time);
  List_Variables(Machine(machine))==(doors,status,requests,direction,level,weights,weight,time);
  External_List_Variables(Machine(machine))==(doors,status,requests,direction,level,weights,weight,time)
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
  List_Invariant(Machine(machine))==(time: NATURAL & weight: NATURAL & weights: NATURAL +-> NATURAL1 & level: NATURAL & level: LEVELS & direction: DIRECTIONS & requests: LEVELS <-> DIRECTIONS & status: STATUS & doors: DOORS)
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
  Expanded_List_Initialisation(Machine(machine))==(time,weight,weights,level,direction,requests,status,doors:=0,0,{},0,up,{},stopped,closed);
  Context_List_Initialisation(Machine(machine))==(skip);
  List_Initialisation(Machine(machine))==(time:=0 || weight:=0 || weights:={} || level:=0 || direction:=up || requests:={} || status:=stopped || doors:=closed)
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
  Internal_List_Operations(Machine(machine))==(pass_seconds,insert_person,remove_person,move);
  List_Operations(Machine(machine))==(pass_seconds,insert_person,remove_person,move)
END
&
THEORY ListInputX IS
  List_Input(Machine(machine),pass_seconds)==(delta);
  List_Input(Machine(machine),insert_person)==(person_weight);
  List_Input(Machine(machine),remove_person)==(person_weight);
  List_Input(Machine(machine),move)==(?)
END
&
THEORY ListOutputX IS
  List_Output(Machine(machine),pass_seconds)==(?);
  List_Output(Machine(machine),insert_person)==(?);
  List_Output(Machine(machine),remove_person)==(?);
  List_Output(Machine(machine),move)==(?)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(machine),pass_seconds)==(pass_seconds(delta));
  List_Header(Machine(machine),insert_person)==(insert_person(person_weight));
  List_Header(Machine(machine),remove_person)==(remove_person(person_weight));
  List_Header(Machine(machine),move)==(move)
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(machine),pass_seconds)==(delta: NATURAL1);
  List_Precondition(Machine(machine),insert_person)==(person_weight: NATURAL1);
  List_Precondition(Machine(machine),remove_person)==(person_weight: NATURAL1 & person_weight: dom(weights));
  List_Precondition(Machine(machine),move)==(status = stopped & doors = closed & weight<=MAX_CAPACITY)
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(machine),move)==(status = stopped & doors = closed & weight<=MAX_CAPACITY | status:=moving);
  Expanded_List_Substitution(Machine(machine),remove_person)==(person_weight: NATURAL1 & person_weight: dom(weights) | weight:=weight-person_weight || (weights(person_weight) = 1 ==> weights:={person_weight}<<|weights [] not(weights(person_weight) = 1) ==> weights:=weights<+{person_weight|->weights(person_weight)-1}));
  Expanded_List_Substitution(Machine(machine),insert_person)==(person_weight: NATURAL1 | weight:=weight+person_weight || (person_weight: dom(weights) ==> weights:=weights<+{person_weight|->weights(person_weight)+1} [] not(person_weight: dom(weights)) ==> weights:=weights<+{person_weight|->1}));
  Expanded_List_Substitution(Machine(machine),pass_seconds)==(delta: NATURAL1 | time:=time+delta);
  List_Substitution(Machine(machine),pass_seconds)==(time:=time+delta);
  List_Substitution(Machine(machine),insert_person)==(weight:=weight+person_weight || IF person_weight: dom(weights) THEN weights(person_weight):=weights(person_weight)+1 ELSE weights(person_weight):=1 END);
  List_Substitution(Machine(machine),remove_person)==(weight:=weight-person_weight || IF weights(person_weight) = 1 THEN weights:={person_weight}<<|weights ELSE weights(person_weight):=weights(person_weight)-1 END);
  List_Substitution(Machine(machine),move)==(status:=moving)
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(machine))==(MIN_LEVEL,MAX_LEVEL,LEVELS,MAX_CAPACITY);
  Inherited_List_Constants(Machine(machine))==(?);
  List_Constants(Machine(machine))==(MIN_LEVEL,MAX_LEVEL,LEVELS,MAX_CAPACITY)
END
&
THEORY ListSetsX IS
  Set_Definition(Machine(machine),DIRECTIONS)==({up,down});
  Context_List_Enumerated(Machine(machine))==(?);
  Context_List_Defered(Machine(machine))==(?);
  Context_List_Sets(Machine(machine))==(?);
  List_Valuable_Sets(Machine(machine))==(?);
  Inherited_List_Enumerated(Machine(machine))==(?);
  Inherited_List_Defered(Machine(machine))==(?);
  Inherited_List_Sets(Machine(machine))==(?);
  List_Enumerated(Machine(machine))==(DIRECTIONS,STATUS,DOORS);
  List_Defered(Machine(machine))==(?);
  List_Sets(Machine(machine))==(DIRECTIONS,STATUS,DOORS);
  Set_Definition(Machine(machine),STATUS)==({stopped,moving});
  Set_Definition(Machine(machine),DOORS)==({open,closed})
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
  List_Properties(Machine(machine))==(MIN_LEVEL = 0 & MAX_LEVEL = 2 & LEVELS = MIN_LEVEL..MAX_LEVEL & MAX_CAPACITY = 450 & DIRECTIONS: FIN(INTEGER) & not(DIRECTIONS = {}) & STATUS: FIN(INTEGER) & not(STATUS = {}) & DOORS: FIN(INTEGER) & not(DOORS = {}))
END
&
THEORY ListSeenInfoX END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(machine),pass_seconds)==(?);
  List_ANY_Var(Machine(machine),insert_person)==(?);
  List_ANY_Var(Machine(machine),remove_person)==(?);
  List_ANY_Var(Machine(machine),move)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(machine)) == (MIN_LEVEL,MAX_LEVEL,LEVELS,MAX_CAPACITY,DIRECTIONS,STATUS,DOORS,up,down,stopped,moving,open,closed | ? | doors,status,requests,direction,level,weights,weight,time | ? | pass_seconds,insert_person,remove_person,move | ? | ? | ? | machine);
  List_Of_HiddenCst_Ids(Machine(machine)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(machine)) == (MIN_LEVEL,MAX_LEVEL,LEVELS,MAX_CAPACITY);
  List_Of_VisibleVar_Ids(Machine(machine)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(machine)) == (?: ?)
END
&
THEORY SetsEnvX IS
  Sets(Machine(machine)) == (Type(DIRECTIONS) == Cst(SetOf(etype(DIRECTIONS,0,1)));Type(STATUS) == Cst(SetOf(etype(STATUS,0,1)));Type(DOORS) == Cst(SetOf(etype(DOORS,0,1))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(machine)) == (Type(up) == Cst(etype(DIRECTIONS,0,1));Type(down) == Cst(etype(DIRECTIONS,0,1));Type(stopped) == Cst(etype(STATUS,0,1));Type(moving) == Cst(etype(STATUS,0,1));Type(open) == Cst(etype(DOORS,0,1));Type(closed) == Cst(etype(DOORS,0,1));Type(MIN_LEVEL) == Cst(btype(INTEGER,?,?));Type(MAX_LEVEL) == Cst(btype(INTEGER,?,?));Type(LEVELS) == Cst(SetOf(btype(INTEGER,"[LEVELS","]LEVELS")));Type(MAX_CAPACITY) == Cst(btype(INTEGER,?,?)))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(machine)) == (Type(doors) == Mvl(etype(DOORS,?,?));Type(status) == Mvl(etype(STATUS,?,?));Type(requests) == Mvl(SetOf(btype(INTEGER,?,?)*etype(DIRECTIONS,?,?)));Type(direction) == Mvl(etype(DIRECTIONS,?,?));Type(level) == Mvl(btype(INTEGER,?,?));Type(weights) == Mvl(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)));Type(weight) == Mvl(btype(INTEGER,?,?));Type(time) == Mvl(btype(INTEGER,?,?)))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(machine)) == (Type(move) == Cst(No_type,No_type);Type(remove_person) == Cst(No_type,btype(INTEGER,?,?));Type(insert_person) == Cst(No_type,btype(INTEGER,?,?));Type(pass_seconds) == Cst(No_type,btype(INTEGER,?,?)))
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
