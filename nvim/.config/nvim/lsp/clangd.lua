return {
  cmd = {"clangd", "--background-index", "--pch-storage=memory", "--clang-tidy"},
  filetypes = {"c", "cpp"},
  root_markers = {
    "compile_commands.json",
    "build/compile_commands.json",
    "compile_flags.txt",
    ".git"
  }
}
