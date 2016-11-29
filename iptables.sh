#!/bin/bash


iptables -t nat -A POSTROUTING -o enp3s0 -j MASQUERADE

