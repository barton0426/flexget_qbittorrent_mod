from typing import Final

from ..base.reseed import ReseedPasskey
from ..schema.nexusphp import Visit


class MainClass(Visit, ReseedPasskey):
    URL: Final = 'https://pt.eastgame.org/'
    USER_CLASSES: Final = {
        'downloaded': [805306368000, 3298534883328],
        'share_ratio': [5.05, 8.55],
        'days': [280, 385]
    }
