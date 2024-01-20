#!/usr/bin/env python3

import sys

import yaml
from yaml.loader import SafeLoader

if __name__ == "__main__":

    label_key_pair = sys.argv[1].split(":")
    ansible_host_key_pair = sys.argv[2].split(":")
    hostname_key_pair = sys.argv[3].split(":")
    host_serial_key_pair = sys.argv[4].split(":")
    boat_name_key_pair = sys.argv[5].split(":")
    boat_name = ''
    with open(r'/home/software/iot-gateway/ansible/hosts.yml', 'r') as file:
        yaml_data = yaml.load(file, Loader=SafeLoader)

    for key in yaml_data['all']['children']['prod']['hosts']:
       boat_name = key

    yaml_data['all']['children']['prod']['hosts'][boat_name_key_pair[1]]= yaml_data['all']['children']['prod']['hosts'][boat_name]
    del yaml_data['all']['children']['prod']['hosts'][boat_name]

    with open('/home/software/iot-gateway/ansible/hosts.yml', 'w') as yaml_file:
        yaml_file.write( yaml.dump(yaml_data,sort_keys=False))

    for k, v in yaml_data['all']['children']['prod']['hosts'][boat_name_key_pair[1]].items():
        if k == 'host_serial' :
            yaml_data['all']['children']['prod']['hosts'][boat_name_key_pair[1]] ['host_serial']= host_serial_key_pair[1]
        if k == 'hostname' :
            yaml_data['all']['children']['prod']['hosts'][boat_name_key_pair[1]] ['hostname']= hostname_key_pair[1]
        if k == 'ansible_host' :
            yaml_data['all']['children']['prod']['hosts'][boat_name_key_pair[1]] ['ansible_host']= ansible_host_key_pair[1]
        if k == 'label' :
            yaml_data['all']['children']['prod']['hosts'][boat_name_key_pair[1]] ['label']= label_key_pair[1]

    with open('/home/software/iot-gateway/ansible/hosts.yml', 'w') as yaml_file:
        yaml_file.write( yaml.dump(yaml_data,sort_keys=False))