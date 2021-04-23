package exception;

public class DuplicateProductException extends Exception {
	private static final long serialVersionUID = 756505221459609425L;

	public DuplicateProductException(String msg) {
		super(msg);
	}
}