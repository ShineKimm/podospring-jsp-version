package podo.podospring.common;

public class ReturnException extends Exception{
    private static final long serialVersionUID = 1L;
    final Object value;

    public ReturnException(Object value, String message) {
            super(message);
            this.value = value;
    }
    public Object getValue() {
            return value;
    }
}
