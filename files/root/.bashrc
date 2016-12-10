source ~/.phpbrew/bashrc
phpbrew use 7.1

# Support for GitHub access tokens
if [ ! -z "$GITHUB_ACCESS_TOKEN" ]; then
    composer config -g github-oauth.github.com $GITHUB_ACCESS_TOKEN
fi;
