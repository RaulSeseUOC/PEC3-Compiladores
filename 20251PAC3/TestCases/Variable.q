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


