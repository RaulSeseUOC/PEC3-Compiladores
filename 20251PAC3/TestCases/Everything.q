BOSS enemy_boolean {
  DATA {
    var_a = true
    var_b = 1
    var_c = "hello"
    var_d = true AND NOT (false OR false)
    # Type error
    var_e = NOT 1
    # Type error
    var_f = true AND "hello"
    # Two type errors
    var_g = 1.0 OR 1.0
  }
  STATE  {}
  ACTION {}


}
# Empty enemy
BOSS enemy1 {
  DATA {
    var1 = true
  }
  STATE {}
  ACTION {}
}

# Enemy with new name
BOSS enemy2 { 
  DATA {
    var2 = true
    # Forbidden name
    enemy2 = false
    # No error here
    enemy1 = true
  }
  STATE {}
  ACTION {}
}

# Enemy with duplicate name
BOSS enemy1 { 
  DATA {
    var3 = true
  }
  STATE {}
  ACTION {}
}



# Enemy with several variables
BOSS example2 {
  DATA {
    var1 = true
    var2 = false
    var3 = true
  }
  STATE {}
  ACTION {}
}

BOSS example_expressions {
  DATA {
    # Constant expressions
    var1 = true
    var2 = false
    var3 = 147
    var4 = 191
    var5 = 176.24
    var6 = "Hello"

   # Variable assignments
   var7 = 113 + 450

   # Boolean expressions 
   var9 = NOT true
   var10 = true AND false 
   var11 = NOT true AND (var10 OR var11 OR var12)

   # ARITHMETIC expressions
   var12 = (a + b) - c *2
   var13 = (a / d)

   # Comparisons
   # Correct
   var14 = var13 >= var12
   # Type error - var14 is a boolean
   var15 = var14 != 2
   # Correct
   var16 = var12 = var13   

   # Everything
   var17 = NOT (a * b - 1) >= 14
   # No need to check for type errors in arithmetic operations
   var18 = 52 * "hello"
  }
  
  STATE { one_state }
  ACTION { one_action }

  STATE one_state {
    # Type error - var2 is of type boolean
    IF var2 >= 15 -> 
       one_action;
       # Type error - var5 is of type float
       var5 = 1 != 2;
    # Type error - condition should be boolean
    IF 7 -> one_action;
  }
  

}
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
} 


BOSS test1 {

  DATA {
    var1 = false
    var2 = true
    var3 = false
    # Duplicate variable var1
    var1 = true

    # Undeclared variable var5
    var4 = var5
  }

  STATE  {}
  ACTION {}
}

BOSS test2 {
  DATA {
    var3 = true
    var6 = false
    # Duplicate variable var6
    var6 = "Repeat"
  }
  STATE {}
  ACTION {}
}


