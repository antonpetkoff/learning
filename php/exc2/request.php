<pre>
<?php

class Request {
    protected $server;

    public function __construct($server) {
        $this->server = $server;
    }

    public function getMethod() {
        return strtolower($this->server['REQUEST_METHOD']);
    }

    public function getPath() {
        return $this->server['PHP_SELF'];
    }

    public function getURL() {
        return $this->server['REQUEST_URI'];
    }

    public function getUserAgent() {
        return $this->server['HTTP_USER_AGENT'];
    }
}

class GetRequest extends Request {
    public function __construct($server) {
        parent::__construct($server);
    }

    public function getData() {
        parse_str($this->server['QUERY_STRING'], $parsed_array);
        return json_encode($parsed_array);
    }
}

$request = new Request($_SERVER);
echo $request->getMethod() . "\n";
echo $request->getPath() . "\n";

$getRequest = new GetRequest($_SERVER);
echo $getRequest->getURL() . "\n";
echo $getRequest->getUserAgent() . "\n";
echo $getRequest->getData() . "\n";

?>
</pre>