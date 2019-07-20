from setuptools import setup

setup(
    name='Refresher',
    version='1.0',
    py_modules=['app'],
    install_requires=[
        'Click',
        'GitPython',
        'mcstatus',
    ],
    entry_points='''
        [console_scripts]
        commit=app:commit
    '''
)