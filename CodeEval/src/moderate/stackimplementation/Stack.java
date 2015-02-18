package moderate.stackimplementation;

import java.util.ArrayList;
import java.util.EmptyStackException;

public class Stack<T> {
	ArrayList<T> stack;
	public Stack() {
		stack = new ArrayList<T>();
	}
	
	/**
	 * 
	 * @param item the item to be pushed onto the stack 
	 * @return the item argument
	 */
	public void push(T item) {
		stack.add(0,item);
	}
	
	/**
	 * 
	 * @return The object at the top of this stack (the last item of the Vector object).
	 * @throws EmptyStackException - if the stack is empty
	 */
	public T pop() throws EmptyStackException {
		if(stack.size() == 0) {
			throw new EmptyStackException();
		}
		else {
			T item = stack.get(0);
			stack.remove(0);
			return item;
		}
	}
	
	/**
	 * 
	 * @return the size of the stack
	 */
	public int size() {
		return stack.size();
	}
	
	/**
	 * 
	 * @return the object at the top of the stack
	 * @throws EmptyStackException
	 */
	public T peek() throws EmptyStackException {
		if(stack.size() == 0) {
			throw new EmptyStackException();
		}
		else {
			return stack.get(0);
		}
	}
	
	/**
	 * 
	 * @return true if and only if stack size is 0; false otherwise
	 */
	public boolean isEmpty() {
		return stack.size()==0;
	}
}
