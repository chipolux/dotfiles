#!/bin/bash
set -e

function join-by { local IFS="$1"; shift; echo "$*"; }

echo -n SASL Password:
read -s password

interface_cmds=$(join-by ";" \
    "/set xfer.file.auto_accept_files on" \
    "/set weechat.startup.display_logo off" \
    "/set weechat.startup.display_version off" \
    "/set weechat.look.mouse on" \
    "/set weechat.look.buffer_notify_default message" \
    "/set weechat.look.color_inactive_buffer off" \
    "/set weechat.look.color_inactive_window off" \
    "/set weechat.look.prefix_align_max 13" \
    "/set weechat.look.prefix_same_nick ' '" \
    "/set weechat.bar.nicklist.size_max 15" \
    "/set weechat.bar.status.color_bg black" \
    "/set weechat.bar.title.color_bg black" \
    "/set weechat.color.chat 179" \
    "/set weechat.color.chat_highlight_bg 227" \
    "/set weechat.bar.input.color_fg 48" \
    "/set fset.color.line_selected_bg1 237" \
    "/set aspell.check.default_dict en" \
    "/set aspell.check.enabled on" \
    "/set aspell.check.suggestions 3" \
    "/set weechat.bar.status.items '[time],[buffer_plugin],buffer_number+:+buffer_name+(buffer_modes)+{buffer_nicklist_count}+buffer_zoom+buffer_filter,scroll,[lag],completion,[aspell_suggest]'")

buflist_cmds=$(join-by ";" \
    "/set irc.look.server_buffer independent" \
    "/set buflist.format.buffer '\\\${format_number}\\\${indent}\\\${eval:\\\${format_name}}\\\${format_hotlist} \\\${color:31}\\\${buffer.local_variables.filter}\\\${buffer.local_variables.buflist}'" \
    "/set buflist.format.buffer_current \\\${if:\\\${type}==server?\\\${color:*white,31}:\\\${color:*white}}\\\${hide:>,\\\${buffer[last_gui_buffer].number}} \\\${indent}\\\${if:\\\${type}==server&&\\\${info:irc_server_isupport_value,\\\${name},NETWORK}?\\\${info:irc_server_isupport_value,\\\${name},NETWORK}:\\\${name}} \\\${color:31}\\\${buffer.local_variables.filter}\\\${buffer.local_variables.buflist}" \
    "/set buflist.format.hotlist ' \\\${color:239}\\\${hotlist}\\\${color:239}'" \
    "/set buflist.format.hotlist_highlight '\\\${color:163}'" \
    "/set buflist.format.hotlist_message '\\\${color:229}'" \
    "/set buflist.format.hotlist_private '\\\${color:121}'" \
    "/set buflist.format.indent '\\\${if:\\\${type}==channel&&\\\${buffer.name}=~fr\\\$||\\\${info:aspell_dict,\\\${buffer.full_name}}=~fr?\\\${color:blue}f :  }\\\${color:*white}'" \
    "/set buflist.format.name '\\\${if:\\\${type}==server?\\\${color:white}:\\\${color_hotlist}}\\\${if:\\\${type}==server||\\\${type}==channel||\\\${type}==private?\\\${if:\\\${cutscr:16,+,\\\${name}}!=\\\${name}?\\\${cutscr:16,\\\${color:\\\${weechat.color.chat_prefix_more}}+,\\\${if:\\\${type}==server&&\\\${info:irc_server_isupport_value,\\\${name},NETWORK}?\\\${info:irc_server_isupport_value,\\\${name},NETWORK}:\\\${name}}}:\\\${cutscr:16, ,\\\${if:\\\${type}==server&&\\\${info:irc_server_isupport_value,\\\${name},NETWORK}?\\\${info:irc_server_isupport_value,\\\${name},NETWORK}                              :\\\${name}                              }}}:\\\${name}}'" \
    "/set buflist.format.number '\\\${if:\\\${type}==server?\\\${color:black,24}:\\\${color:242}}\\\${number}\\\${if:\\\${number_displayed}?.: }'" \
    "/set weechat.bar.buflist.size 26" \
    "/set weechat.bar.buflist.size_max 26")

server_cmds=$(join-by ";" \
    "/set irc.look.smart_filter on" \
    "/filter add irc_smart * irc_smart_filter *" \
    "/filter add joinquit * irc_join,irc_part,irc_quit *" \
    "/set irc.server_default.msg_part ''" \
    "/set irc.server_default.msg_quit ''" \
    "/set irc.server_default.nicks 'chipolux,chip'" \
    "/set irc.server_default.username 'chipolux'" \
    "/set irc.server_default.realname 'nakyle'" \
    "/server add afternet irc.afternet.org/6697 -ssl" \
    "/set irc.server.afternet.autoconnect yes" \
    "/set irc.server.afternet.autojoin #gamedev,#ludumdare" \
    "/server add espernet irc.esper.net/6697 -ssl" \
    "/set irc.server.espernet.autoconnect yes" \
    "/set irc.server.espernet.sasl_mechanism plain" \
    "/set irc.server.espernet.sasl_username chipolux" \
    "/set irc.server.espernet.sasl_password $password" \
    "/set irc.server.espernet.autojoin #tigirc,#factorio" \
    "/server add freenode chat.freenode.net/6697 -ssl" \
    "/set irc.server.freenode.autoconnect yes" \
    "/set irc.server.freenode.sasl_mechanism plain" \
    "/set irc.server.freenode.sasl_username chipolux" \
    "/set irc.server.freenode.sasl_password $password" \
    "/set irc.server.freenode.autojoin #1gam,#godotengine,#lisp,#lispcafe,#lispgames,#powershell,##proggit,#python,#reddit-anime,#reddit-gamedev,#stardewvalley" \
    "/server add rizon irc.rizon.net/6697 -ssl" \
    "/set irc.server.rizon.autoconnect yes" \
    "/set irc.server.rizon.sasl_mechanism plain" \
    "/set irc.server.rizon.sasl_username chipolux" \
    "/set irc.server.rizon.sasl_password $password" \
    "/set irc.server.rizon.autojoin #/g/sicp,#/g/technology,#horriblesubs,#r/a/dio" \
    "/server add scenep2p irc.scenep2p.net/6667" \
    "/set irc.server.scenep2p.autojoin #THE.SOURCE" \
    "/server add abjects irc.abjects.net/6667" \
    "/set irc.server.abjects.autojoin #mg-chat,#moviegods,#beast-xdcc" \
    "/server add criten irc.criten.net/6667" \
    "/set irc.server.criten.autojoin #elitewarez")

weechat_cmds=$(join-by ";" "$interface_cmds" "$buflist_cmds" "$server_cmds" "/quit")

weechat -a -r "$weechat_cmds"
