-- # Global settings
-- Used by many files

return {ignore= "?",
        sep=    ",",
        here=   os.getenv("Lure"),
        sample= { most=256},
        tree=   { min=2, 
                  maxDepth=10},
        chop=   { m=0.5,
                  cohen=0.2}
      }