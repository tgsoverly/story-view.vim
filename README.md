[![Actions Status](https://github.com/tgsoverly/watupdoc.vim/workflows/CI/badge.svg)](https://github.com/tgsoverly/watupdoc.vim/actions)

# Wat (is) up (with my external) doc(umentation)

## What is it?

Plugin that will `hightlight` lines in your code that have `links` to them in external systems.
You can then read the link description and open them in an external browser.

Here is a demo:

![watupdoc](https://user-images.githubusercontent.com/482572/94562513-6cfc6500-0233-11eb-9a2e-0d62e608cf43.gif)

What I am doing:

1. Opening a file that has a link to it in clubhouse.io
2. `:w` the file to trigger the plugin.
3. Moving the cursor over the lines to show the information at the bottom of the screen.
4. `C-W` on the line to open that external reference in a browser.

## What problem is being solved?

You have discussions around nice to have features and you say something like "Next time we change this code we should update this method."  Now you have another problem: how do you track that work?  This plugin is an attempt to solve that problem.

## How to use

All you need to do is store a link to the line of code in a `Supported URL Format` in a `Supported External System`.

### Supported URL Formats

* Github

### Supported External Systems

* Clubhouse.io

### Prerequisites

1. `curl` installed.
1. File must be in a `git` repo.

### Tested Systems

1. OS X

### Tested VIM

1. neovim

## Thanks

1. I was new to vimscript and http://bling.github.io/blog/2013/08/16/modularizing-vimscript/ helped me strcture code.
1. I have used the Ale plugin to learn how to do some stuff: https://github.com/dense-analysis/ale
