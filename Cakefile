exec = require('child_process').exec

task 'build', "Build coffeescripts", ->
  exec "coffee -c -o lib src"
task 'watch', "Watch coffeescripts", ->
  exec "coffee -cw -o lib src"