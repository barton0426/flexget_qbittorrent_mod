from ..schema.nexusphp import VisitHR
from ..utils import net_utils


class MainClass(VisitHR):
    URL = 'https://ptsbao.club/'
    USER_CLASSES = {
        'downloaded': [805306368000, 3298534883328],
        'share_ratio': [3.05, 4.55],
        'days': [112, 364]
    }

    def build_selector(self):
        selector = super(MainClass, self).build_selector()
        net_utils.dict_merge(selector, {
            'details': {
                'points': {
                    'regex': '魔力值.*?：([\\d,.]+)'
                }
            }
        })
        return selector
