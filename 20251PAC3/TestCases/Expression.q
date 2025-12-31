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
   var17 = 14 >= NOT (a * b - 1)
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
