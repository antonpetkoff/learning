package sequential.list;

import java.util.HashSet;
import java.util.Set;

public class SequentialList {
    private static final int INITIAL_SIZE = 2;
    private static final double SIZE_MULTIPLIER = 2;
    
    private int[] array;
    private int elementCount;
    
    public SequentialList() {
        this(INITIAL_SIZE);
    }
    
    public SequentialList(int initialSize) {
        this.array = new int[initialSize];
        this.elementCount = 0;
    }
    
    public void add(int element) {
        this.tryGrow();
        this.array[this.elementCount] = element;
        this.elementCount++;
    }
    
    public void insert(int element, int index) {
        if (index >= this.elementCount) {
            this.add(element);
            return;
        }
        this.tryGrow();
        for (int i = this.elementCount - 1; i >= index ; i--) {
            this.array[i + 1] = this.array[i]; 
        }
        this.array[index] = element;
        this.elementCount++;
    }
    
    public int get(int index)
    {
        return this.array[index];
    }
    
    public int size() {
        return this.elementCount;
    }
    
    public int indexOf(int element) {
        for (int i = 0; i < this.elementCount; i++) {
            if (this.array[i] == element)
                return i;
        }
        return -1;
    }
    
    private void tryGrow() {        
        if (this.elementCount >= this.array.length) {
            int[] newArray = new int[(int)(this.array.length * SIZE_MULTIPLIER)];
            for (int i = 0; i < this.array.length; i++) {
                newArray[i] = this.array[i];
            }
            this.array = newArray;
        }
    }
    
    public void print() {
        for (int i = 0; i < elementCount; ++i) {
            System.out.print(array[i] + " ");
        }
        System.out.println();
    }
    
    // Removes the element at the specified index. If @index is negative, 
    // it should remove the element at list.Length + index (in other words, count from the end).
    public void removeAt(int index) {
        index = index < 0 ? elementCount + index : index;
        for (int i = index; i < this.elementCount - 1; i++) {
            this.array[i] = this.array[i + 1]; 
        }
        this.elementCount--;
    }
    
    public boolean removeElement(int element) {
        int index = indexOf(element);
        if (index != -1) {
            removeAt(index);
            return true;
        }
        return false;
    }

    public SequentialList copy() {
        SequentialList list = new SequentialList((int) (elementCount * SIZE_MULTIPLIER));
        for (int i = 0; i < elementCount; ++i) {
            list.add(array[i]);
        }
        return list;
    }

    public SequentialList reverse() {
        SequentialList reversed = new SequentialList(array.length);
        for (int i = 0; i < elementCount; ++i) {
            reversed.add(array[elementCount - i - 1]);
        }
        return reversed;
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        
        if (obj instanceof SequentialList) {
            SequentialList other = (SequentialList) obj;
            
            if (elementCount != other.size()) {
                return false;
            }
            
            for (int i = 0; i < elementCount; ++i) {
                if (array[i] != other.get(i)) {
                    return false;
                }
            }
            
            return true;
        }
        
        return false;
    }
    
    public boolean isPalindrome() {
        for (int i = 0; i < elementCount / 2; ++i) {
            if (array[i] != array[elementCount - i - 1]) {
                return false;
            }
        }
        return true;
    }

    public SequentialList sortedMerge(SequentialList other) {
        SequentialList merged = new SequentialList(
                (int)((other.size() + elementCount) * SIZE_MULTIPLIER));
        
        int i = 0, j = 0;
        for (int k = 0; k < other.size() + elementCount; ++k) {
            if (i >= elementCount) {
                merged.add(other.get(j++));
            } else if (j >= other.size()) {
                merged.add(array[i++]);
            } else if (array[i] <= other.get(j)) {
                merged.add(array[i++]);
            } else {
                merged.add(other.get(j++));
            }
        }
        
        return merged;
    }

    public SequentialList removeDuplicates() {
        SequentialList noDuplicates = new SequentialList();
        Set<Integer> set = new HashSet<>();

        for (int i = 0; i < elementCount; ++i) {
            if (!set.contains(array[i])) {
                set.add(array[i]);
                noDuplicates.add(array[i]);
            }
        }
        
        return noDuplicates;
    }
    
}