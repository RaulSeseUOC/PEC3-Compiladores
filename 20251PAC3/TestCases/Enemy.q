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

