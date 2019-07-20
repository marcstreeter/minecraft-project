from datetime import datetime as dt
from pathlib import Path

import click
from git import (Repo, Actor)
from mcstatus.server import MinecraftServer


@click.command()
@click.argument('git-email', envvar='GIT_COMMITTER_EMAIL')
@click.argument('git-name', envvar='GIT_COMMITTER_NAME')
@click.argument('server', envvar='MINECRAFT_SERVER_ADDRESS')
@click.option('-r', '--git-repo', default='.')
def commit(git_email, git_name, server, git_repo):
    """git commit utility."""
    # check to see if users are online
    server = MinecraftServer.lookup(server)
    response = server.status()
    players = response.players.online

    if not players: # short circuit empty server
        print("Nobody's around, skipping")
        return
    
    repo = Repo(git_repo)
    origin = repo.remote('origin')

    if not origin.exists():
        print("Unable to push up to non-existent origin")
        return
    
    if not repo.is_dirty(): # short circuit non-changed server
        print("Nothing has happened yet, skipping")
        return
    
    try:
        ts = dt.now().isoformat()
        repo.index.add(['*'])
        message = f'snapshot for {players} players at {ts}'
        committer = Actor(name=git_name, email=git_email)
        repo.index.commit(message, author=committer, committer=committer)
        origin.pull()
        origin.push()
    except Exception as e:
        print(f"failed to commit: {e}")
    else:
        print(f'successfully committed: {message}')

if __name__ == '__main__':
    commit()