#!/bin/sh

[ -x /usr/sbin/vtund ] || exit 1

[ -n "$INCLUDE_ONLY" ] || {
	. /lib/functions.sh
	. /lib/functions/network.sh
	. ../netifd-proto.sh
	init_proto "$@"
}

proto_vtun_init_config() {
	available=1
	no_device=1
	proto_config_add_string "ifname"
	proto_config_add_defaults
}

proto_vtun_setup() {
	local cfg="$1"
	local iface="$2"

	proto_run_command "$cfg" /usr/sbin/vtund -n \ 
		-f "/var/run/vtund-${cfg}" \
		"$nodeconfig" \
		"$server" 

proto_vtun_teardown() {
	local cfg="$1"
	proto_kill_command "$cfg"
}

probe_vtun_serverlist() {
	# todo
	local cfg="$1"
	local rand
	local count 
	rand=$(tr -dc '1-65000' </dev/urandom | head -c 1)
	rand=$(expr $rand % $count + 1)

}

generate_vtun_conf() {
	local cfg="$1"
	local nodenumber="$2"

cat <<- EOF > /var/run/vtun-${cfg}.conf
	Node${nodenumber} {
		passwd ff;
		type ether;	
		persist yes;
		}
	EOF
}

[ -n "$INCLUDE_ONLY" ] || {
	add_protocol vtun 
}
