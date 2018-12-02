#!/usr/bin/bash

sudo echo -n "0000:0a:00.0" | tee /sys/bus/pci/drivers/xhci_hcd/unbind
sudo echo -n "0000:0a:00.0" | tee /sys/bus/pci/drivers/xhci_hcd/bind
sudo echo -n "0000:00:14.0" | tee /sys/bus/pci/drivers/xhci_hcd/unbind
sudo echo -n "0000:00:14.0" | tee /sys/bus/pci/drivers/xhci_hcd/bind

