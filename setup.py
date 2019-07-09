import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="watchman",
    version="0.1.10",
    license="MIT",
    author="Ewerton Carlos Assis",
    author_email="earaujoassis@gmail.com",
    description="Watchman helps keep track of GitHub projects; a tiny continuous deployment service",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/earaujoassis/watchman",
    packages=setuptools.find_packages(exclude=['apps', 'bin', 'db', 'lib', 'node_modules', 'public', 'spec', 'web']),
    install_requires=[
        'Mako',
        'argparse',
        'requests',
    ],
    python_requires='>=2.7, <4',
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    package_data={
        'agents': ['templates/*'],
    },
    entry_points={
        'console_scripts': [
            'agent=agents:main',
        ],
    },
    project_urls={
        'Source': 'https://github.com/earaujoassis/watchman',
        'Tracker': 'https://github.com/earaujoassis/watchman/issues',
    },
)
