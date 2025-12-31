# Everything is correct
BOSS enemy_sa {
  DATA {
    var1 = true
  }
  STATE { }
  ACTION {} 
}

# Duplicate states and actions
BOSS enemy_sa_2 {
  DATA {
    var2 = true
  }
  # Duplicate state test2  
  # Name var2 can be reused with no problems
  STATE  { test1, test2, test3, test2, var2, test2 }
  # Name test1 can be reused with no problems
  # Name var2 can be reused with no problems
  ACTION { test1, var2, test4, test5, test6, test6 }
  STATE test9 { CHANCE(10%) -> GOTO test1; }
}

# Redeclaring states and actions in another boss does not cause problems
BOSS enemy_sa_3 {
  DATA {
    var3 = false
  }
  # Name test3 can be reused with no problems
  STATE { test3 }
  # Name test4 can be reused with no problems
  # Duplicate identifier test7
  ACTION { test4, test7, test7 } 
  STATE test10 {
    CHANCE(10%) -> 
      GOTO test11;
      no_action;
  }
} 


