if (which ^zip | length) == 0 {
  exit 1
}

let managed_files = [
  "main.lua"
  "conf.lua"
  "src"
  "assets"
]

if not ("build" | path exists) {
  mkdir "build"
}

let executable_path = ("build" | path join $"(pwd | path basename)")

$managed_files | ^zip $executable_path ...$in

mv $"($executable_path).zip" $"($executable_path).love"
