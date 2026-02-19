# nu-config #

A pre-canned deployment of nushell for RHEL family of OS with all my preferences

* Installs supplied core plugins (somehow this isn't automatic)
* Installs carapace completions
* Login setting to run fastfetch
* My hypervisor tools for switching between KVM hosts
* Simple shell prompt (you may want to replace with Starship)
* A heap of aliases for git ... etc

## Install ##

```
$ git clone https://github.com/mcgarrigle/nu-config.git

$ cd nu-config

$ ./install  # set repos and install all dependencies

$ ./setup    # copy config and script files, configure plugins and carapace integration
```

## Notes ##

The caprapace integration writes the start script to ``~/.cache/nushell/carapace.nu``. The start config in ``~/.config/nushell/autoload/carapace.nu`` will ``source`` it if it exists. This pattern decouples changes in carapace from this project.

Tested with nushell 0.110.0 and Rocky Linux 9 and 10
