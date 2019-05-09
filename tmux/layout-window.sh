# Calculate right panel width as 1/3rd of window width min 80
FULL_WIDTH=$(tmux display -p '#{window_width}')
WIDTH=$(expr $FULL_WIDTH / 3)
WIDTH=$((WIDTH > 80 ? WIDTH : 80))

# Layout and resize panes
tmux select-layout main-vertical
tmux resize-pane -t 0 -x $(expr $FULL_WIDTH - $WIDTH)
