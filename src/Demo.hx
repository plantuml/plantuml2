interface Demo01<T> {
	public function get():T;
}

class Demo implements Demo01<String> {
	public function get():String {
		return "ok";
	}
}
