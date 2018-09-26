# packer-windows

## Requirements

Requires [Packer](https://packer.io/) & [Virtualbox](https://www.virtualbox.org/) to be installed. 

The output is a box file to be used with [Vagrant](https://www.vagrantup.com/)

## Usage

Clone the repo

    git clone https://github.com/MrNimmy/packer-windows.git


Open `templates/vbox-windows_2012_r2/vbox-windows_2012_r2_1_base.json` and edit the `iso_url` under variables to point to your 2012 R2 ISO. 

Run the build script to build the box. 

    ./build_windows_2012_r2.sh

You can then import the box into vagrant with 

    vagrant box add ./output/boxes/vbox-win2012_r2.box --name server_2012_r2
    
