# Calculate right panel width as 1/3rd of window width min 100
WIDTH=$(expr $(tmux display -p '#{window_width}') / 3)
WIDTH=$((WIDTH > 100 ? WIDTH : 100))

# Layout and resize panes
tmux select-layout main-vertical
tmux resize-pane -t 1 -x $WIDTH
