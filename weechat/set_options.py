import sys
import codecs

import configparser


def main(base_path, custom_path, out_path):
    base_config = load_config(base_path)
    custom_config = load_config(custom_path)

    for section in custom_config.sections():
        # Ensure sections exist
        if not base_config.has_section(section):
            base_config.add_section(section)

        # Set options in base file
        for option, value in custom_config.items(section):
            base_config.set(section, option, value)

    write_config(base_config, out_path)


def load_config(path):
    config = configparser.ConfigParser(
        allow_no_value=True,
        delimiters=(' = ',)
    )
    config.optionxform = unicode
    config.read(path)
    return config


def write_config(config, path):
    config._delimiters = ('=',)
    with codecs.open(path, 'w', 'utf8') as f:
        config.write(f)


if __name__ == '__main__':
    sys.exit(main(*sys.argv[1:]))
