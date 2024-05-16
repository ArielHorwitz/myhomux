------------------------------- Plugins ---------------------------------------

local config = require "core.config"


-- Builtin plugins
config.plugins.autocomplete.max_height = 15
config.plugins.autocomplete.min_len = 0
config.plugins.autoreload.always_show_nagview = true
config.plugins.bracketmatch.line_size = 4
config.plugins.drawwhitespace = { enabled = true, show_leading = false, show_middle_min = 2 }
config.plugins.lineguide.width = 2
config.plugins.lineguide.enabled = true
config.plugins.lineguide.rulers = { [1] = 80, [2] = 100, [3] = 120 }
config.plugins.linenumbers.relative = true
config.plugins.linewrapping.enable_by_default = true
config.plugins.linewrapping.mode = "word"
config.plugins.lsp.mouse_hover_delay = 750
config.plugins.lsp.more_yielding = true
config.plugins.nerdicons.draw_tab_icons = true
config.plugins.nerdicons.draw_treeview_icons = true

local snippets = require 'plugins.snippets'

snippets.add {
    trigger  = 'cb',
    info     = 'codeblock',
    desc     = 'Codeblock for markdown',
    format   = 'lsp',
    template = [[
```${0:markdown}
```
]]
}

snippets.add {
    trigger  = 'sf',
    info     = 'Shell function',
    desc     = 'A function for bash',
    scope    = 'source.bash',
    format   = 'lsp',
    template = [[
${0:shell_function}() {
    set -e
}]]
}

snippets.add {
    trigger  = 'sif',
    info     = 'Shell if statement',
    desc     = 'If statement for bash',
    scope    = 'source.bash',
    format   = 'lsp',
    template = [=[
if [[ -n \$${1:arg} ]]; then
    $0
fi
]=]
}

snippets.add {
    trigger  = 'ppf',
    info     = 'Python f-string',
    desc     = 'Python print f-string',
    scope    = 'source.python',
    format   = 'lsp',
    template = [[print(f'{${0:expression}=}')]]
}

snippets.add {
    trigger  = 'doc',
    info     = 'Python docstring',
    desc     = 'Python docstring',
    scope    = 'source.python',
    format   = 'lsp',
    template = [["""${0:DOCSTRING_PLACEHOLDER}"""]]
}

snippets.add {
    trigger  = 'ifname',
    info     = 'if name main',
    desc     = 'Boilerplate for python main script file',
    scope    = 'source.python',
    format   = 'lsp',
    template = [[

def main():
    ${0:pass}

if __name__ == "__main__":
    main()]]
}
