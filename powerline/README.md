# Initial Setup of the powerline git status

from "https://github.com/jaspernbrouwer/powerline-gitstatus.git" i have added the two folders colorschemes and themes to the "~/.config/powerline" and the files under them.

based on the link "https://devpro.media/install-powerline-ubuntu/#edit-your-powerline-configuration" do the following things:

1. edit "/usr/lib/python3.8/site-packages/powerline/config_files/config.json": under shell change the theme from default to default_leftonly.

2. edit "/usr/lib/python3.8/site-packages/powerline/config_files/themes/shell/default_leftonly.json": under "function": "powerline.segments.common.vcs.branch" add "args": { "status_colors": true }

Note: if you can't see the changes try and check if the following command work or not:

"$ powerline-daemon --replace"
