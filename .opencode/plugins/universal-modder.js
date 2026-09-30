import { delimiter, join } from "node:path"

export const UniversalModderPlugin = async ({ worktree, directory }) => {
  const root = worktree ?? directory
  const binDir = join(root, "bin")
  return {
    "shell.env": async (_input, output) => {
      const current = output.env.PATH ?? process.env.PATH ?? ""
      output.env.PATH = current ? `${binDir}${delimiter}${current}` : binDir
      output.env.UNIVERSAL_MODDER_ROOT = root
    },
  }
}
