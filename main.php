<?php
const PORT = 'port';
function _get_cli_params($cli_params, $default_port='9000-9001-9008-9010'){
	$params = [];
	if(count($cli_params) <= 1){
		$params[PORT] = $default_port;
		return $params;
	}
	foreach($cli_params as $item){
		if(strpos($item, '=') !== false){
			list($key, $val) = explode('=', trim($item, '-'));
			$params[$key] = $val;
		}
	}
	return $params;
}
function main(){
	global $argv;
	$params = _get_cli_params($argv);
	$ports = array_filter(explode(',', $params[PORT]));
	$cmd = sprintf("php-start.bat '%s'", implode('-', $ports));
	// echo $cmd;
	// exit;
	system($cmd);
}

main();

