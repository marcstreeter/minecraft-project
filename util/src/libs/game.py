from datetime import datetime as dt
import os

from git import (
    Repo,
    Actor,
)


def save():
    """git commit utility."""
    git_email = _env('GIT_COMMITTER_EMAIL')
    git_name = _env('GIT_COMMITTER_NAME')
    git_repo = _env('MINECRAFT_SERVER_PATH')

    repo = Repo(git_repo)
    origin = repo.remote('origin')

    if not origin.exists():
        print("Unable to push up to non-existent origin")
        return
    
    if not repo.is_dirty():  # short circuit non-changed server
        print("Nothing has happened yet, skipping")
        return
    
    try:
        ts = dt.now().isoformat()
        repo.index.add(['*'])
        message = f'save point {ts}'
        committer = Actor(name=git_name, email=git_email)
        repo.index.commit(message, author=committer, committer=committer)
        origin.pull()
        origin.push()
    except Exception as e:
        print(f"failed to commit: {e}")
    else:
        print(f'successfully committed: {message}')


def _env(name: str, default: str = '') -> str:
    return os.environ.get(name) or default

