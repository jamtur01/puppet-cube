puppet-cube
=============

Description
-----------

A Puppet report handler for sending log events to
[Cube](https://github.com/square/cube).

It sends an event called `puppet_log` to Cube with data including the
host name of the Puppet client and contents of the log entry:

        data = { host: hostname, output: log_entry }
  
Requirements
------------

* `rest-client`
* `json`

Installation & Usage
--------------------

1.  Install the `rest-client` and `json` gems on your Puppet master

        $ sudo gem install rest-client json

2.  Install puppet-cube as a module in your Puppet master's module
    path.

3.  Update the `host` and `port` variables in the `cube.yaml` file with
    your Cube host and port.

4.  Copy `cube.yaml` to `/etc/puppet`.

5.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = cube
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

6.  Run the Puppet client and sync the report as a plugin

Author
------

James Turnbull <james@lovedthanlost.net>

License
-------

    Author:: James Turnbull (<james@lovedthanlost.net>)
    Copyright:: Copyright (c) 2012 James Turnbull
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
