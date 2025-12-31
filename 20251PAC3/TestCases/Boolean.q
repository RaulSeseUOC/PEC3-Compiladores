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
