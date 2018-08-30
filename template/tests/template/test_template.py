:%s!FILE_NAME!\=expand('%:t:r:s?test_??:gs?\%(^\|_\)\(.\)?\U\1?')!
from unittest import TestCase, main


class FILE_NAMETestCase(TestCase):
    def test_foo(self):
        self.assertEqual(2, 1 + 1)


if __name__ == '__main__':
    main()
