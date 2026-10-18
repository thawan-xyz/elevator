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
  Local_List_Variables(Machine(machine))==(requests,direction,level,weight,time);
  List_Variables(Machine(machine))==(requests,direction,level,weight,time);
  External_List_Variables(Machine(machine))==(requests,direction,level,weight,time)
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
  List_Invariant(Machine(machine))==(time: NATURAL & weight: NATURAL & level: NATURAL & level: LEVELS & direction: DIRECTIONS & requests: LEVELS <-> DIRECTIONS)
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
  Expanded_List_Initialisation(Machine(machine))==(time,weight,level,direction,requests:=0,0,0,up,{});
  Context_List_Initialisation(Machine(machine))==(skip);
  List_Initialisation(Machine(machine))==(time:=0 || weight:=0 || level:=0 || direction:=up || requests:={})
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
  Internal_List_Operations(Machine(machine))==(pass_seconds,pass_minutes,pass_hours,add_request);
  List_Operations(Machine(machine))==(pass_seconds,pass_minutes,pass_hours,add_request)
END
&
THEORY ListInputX IS
  List_Input(Machine(machine),pass_seconds)==(delta);
  List_Input(Machine(machine),pass_minutes)==(delta);
  List_Input(Machine(machine),pass_hours)==(delta);
  List_Input(Machine(machine),add_request)==(r_level,r_direction)
END
&
THEORY ListOutputX IS
  List_Output(Machine(machine),pass_seconds)==(?);
  List_Output(Machine(machine),pass_minutes)==(?);
  List_Output(Machine(machine),pass_hours)==(?);
  List_Output(Machine(machine),add_request)==(?)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(machine),pass_seconds)==(pass_seconds(delta));
  List_Header(Machine(machine),pass_minutes)==(pass_minutes(delta));
  List_Header(Machine(machine),pass_hours)==(pass_hours(delta));
  List_Header(Machine(machine),add_request)==(add_request(r_level,r_direction))
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(machine),pass_seconds)==(delta: NATURAL1);
  List_Precondition(Machine(machine),pass_minutes)==(delta: NATURAL1);
  List_Precondition(Machine(machine),pass_hours)==(delta: NATURAL1);
  List_Precondition(Machine(machine),add_request)==(r_level: LEVELS & r_direction: DIRECTIONS & (r_level = 0 => r_direction/=down) & (r_level = 2 => r_direction/=up))
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(machine),add_request)==(r_level: LEVELS & r_direction: DIRECTIONS & (r_level = 0 => r_direction/=down) & (r_level = 2 => r_direction/=up) | requests:=requests\/{r_level|->r_direction});
  Expanded_List_Substitution(Machine(machine),pass_hours)==(delta: NATURAL1 | time:=time+3600*delta);
  Expanded_List_Substitution(Machine(machine),pass_minutes)==(delta: NATURAL1 | time:=time+60*delta);
  Expanded_List_Substitution(Machine(machine),pass_seconds)==(delta: NATURAL1 | time:=time+delta);
  List_Substitution(Machine(machine),pass_seconds)==(time:=time+delta);
  List_Substitution(Machine(machine),pass_minutes)==(time:=time+60*delta);
  List_Substitution(Machine(machine),pass_hours)==(time:=time+3600*delta);
  List_Substitution(Machine(machine),add_request)==(requests:=requests\/{r_level|->r_direction})
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(machine))==(MIN_LEVEL,MAX_LEVEL,LEVELS);
  Inherited_List_Constants(Machine(machine))==(?);
  List_Constants(Machine(machine))==(MIN_LEVEL,MAX_LEVEL,LEVELS)
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
  List_Enumerated(Machine(machine))==(DIRECTIONS);
  List_Defered(Machine(machine))==(?);
  List_Sets(Machine(machine))==(DIRECTIONS)
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
  List_Properties(Machine(machine))==(MIN_LEVEL = 0 & MAX_LEVEL = 2 & LEVELS <: NATURAL & LEVELS = MIN_LEVEL..MAX_LEVEL & DIRECTIONS: FIN(INTEGER) & not(DIRECTIONS = {}))
END
&
THEORY ListSeenInfoX END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(machine),pass_seconds)==(?);
  List_ANY_Var(Machine(machine),pass_minutes)==(?);
  List_ANY_Var(Machine(machine),pass_hours)==(?);
  List_ANY_Var(Machine(machine),add_request)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(machine)) == (MIN_LEVEL,MAX_LEVEL,LEVELS,DIRECTIONS,up,down | ? | requests,direction,level,weight,time | ? | pass_seconds,pass_minutes,pass_hours,add_request | ? | ? | ? | machine);
  List_Of_HiddenCst_Ids(Machine(machine)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(machine)) == (MIN_LEVEL,MAX_LEVEL,LEVELS);
  List_Of_VisibleVar_Ids(Machine(machine)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(machine)) == (?: ?)
END
&
THEORY SetsEnvX IS
  Sets(Machine(machine)) == (Type(DIRECTIONS) == Cst(SetOf(etype(DIRECTIONS,0,1))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(machine)) == (Type(up) == Cst(etype(DIRECTIONS,0,1));Type(down) == Cst(etype(DIRECTIONS,0,1));Type(MIN_LEVEL) == Cst(btype(INTEGER,?,?));Type(MAX_LEVEL) == Cst(btype(INTEGER,?,?));Type(LEVELS) == Cst(SetOf(btype(INTEGER,"[LEVELS","]LEVELS"))))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(machine)) == (Type(requests) == Mvl(SetOf(btype(INTEGER,?,?)*etype(DIRECTIONS,?,?)));Type(direction) == Mvl(etype(DIRECTIONS,?,?));Type(level) == Mvl(btype(INTEGER,?,?));Type(weight) == Mvl(btype(INTEGER,?,?));Type(time) == Mvl(btype(INTEGER,?,?)))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(machine)) == (Type(add_request) == Cst(No_type,btype(INTEGER,?,?)*etype(DIRECTIONS,?,?));Type(pass_hours) == Cst(No_type,btype(INTEGER,?,?));Type(pass_minutes) == Cst(No_type,btype(INTEGER,?,?));Type(pass_seconds) == Cst(No_type,btype(INTEGER,?,?)))
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
