#!/bin/bash
packer build --force ./templates/vbox-windows_2012_r2/vbox-windows_2012_r2_1_base.json
packer build --force ./templates/vbox-windows_2012_r2/vbox-windows_2012_r2_2_updated.json
packer build --force ./templates/vbox-windows_2012_r2/vbox-windows_2012_r2_3_final.json