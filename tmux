set -g default-terminal "tmux-256color"
set-option -sa terminal-overrides ",xterm*:Tc"
set -ga terminal-overrides ",*256col*:Tc"
set -sg escape-time 0
set-option -g status-style bg=default
set-option -g renumber-windows on
set -g base-index 1
bind -T copy-mode-vi v send -X begin-selection
bind j copy-mode
setw -g pane-base-index 1
set -g mode-keys vi
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-yank'
bind -T copy-mode    C-c send -X copy-pipe-no-clear "xsel -i --clipboard"
bind -T copy-mode-vi C-c send -X copy-pipe-no-clear "xsel -i --clipboard"
set -g status-right '#(gitmux "#{pane_current_path}")'
set-option -g history-limit 30000
# be sure to see note* below
set -g window-status-format '#I:#(pwd="#{pane_current_path}"; echo ${pwd####*/})#F'
set -g window-status-current-format '#I:#(pwd="#{pane_current_path}"; echo ${pwd####*/})#F'

# status bar updates every 15s by default**, change to 1s here
# (this step is optional - a lower latency might have negative battery/cpu usage impacts)
set -g status-interval 1
# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
