[![Actions Status](https://github.com/tgsoverly/watupdoc.vim/workflows/CI/badge.svg)](https://github.com/tgsoverly/watupdoc.vim/actions)

# Wat (is) up (with my external) doc(umentation)

## What is it?

A vim plugin to indicate that code is referenced in external systems.

1. It highlights lines that are referenced in external systems.
1. It gives you information on the lines referenced when the cursor is on those lines.
1. It allows you open the referenced system an external browser.

## Installation:

### Plug

```
Plug 'tgsoverly/watupdoc.vim'
```

### Configuration

1. Map the command to open in an external browser
```
nmap <silent> <LocalLeader>od <Plug>(WatupdocOpen)
```

### Prerequisites

1. `curl` installed.
1. File must be in a `git` repo.

### Tested Systems

1. OS X

### Tested VIM

1. neovim

## Demo

![watupdoc](https://user-images.githubusercontent.com/482572/94562513-6cfc6500-0233-11eb-9a2e-0d62e608cf43.gif)

What I am doing:

1. Opening a file that has a link to it in clubhouse.io
2. `:w` the file to trigger the plugin.
3. Moving the cursor over the lines to show the information at the bottom of the screen.
4. `\od` on the line to open that external reference in a browser.

## What problem is being solved?

You have discussions around nice to have features and you say something like "Next time we change this code we should update this method."  Now you have another problem: how do you track that work?  This plugin is an attempt to solve that problem.

## How to use

1. Setup the desired `Supported External System`s
1. Store a link to the line of code in a `Supported URL Format` in a `Supported External System`.

### Supported URL Formats

* Github

### Supported External Systems

* Clubhouse.io

1. Get an API token from your clubhouse user profile.
1. Set the following environment variable in your profile: `WATUPDOC_CLUBHOUSE_API_TOKEN`

* Stack Overlow (for Teams)

1. Follow the instructions to set up an OAUTH app here: https://www.stackoverflow.help/support/solutions/articles/36000154987-stack-overflow-for-teams-api
1. Set the following environment variables in your profile: `WATUPDOC_STACK_OVERFLOW_ACCESS_TOKEN`, `WATUPDOC_STACK_OVERFLOW_TEAM`, and `WATUPDOC_STACK_OVERFLOW_KEY`

## Thanks

1. I was new to vimscript and http://bling.github.io/blog/2013/08/16/modularizing-vimscript/ helped me strcture code.
1. I have used the Ale plugin to learn how to do some stuff: https://github.com/dense-analysis/ale
