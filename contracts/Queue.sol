pragma solidity ^0.4.15;

/**
 * @title Queue
 * @dev Data structure contract used in `Crowdsale.sol`
 * Allows buyers to line up on a first-in-first-out basis
 * See this example: http://interactivepython.org/courselib/static/pythonds/BasicDS/ImplementingaQueueinPython.html
 */

contract Queue {
	/* State variables */
	uint8 size = 5;
	uint numInside;

	bool isFull;
	bool isEmpty;
    
    
    uint8 first;
    uint8 lastFilled;
    uint8 nextFree;

    uint256 duration;
    
    mapping (address => uint8) addr2place;
    mapping (uint8 => address) place2addr;
    
    
	/* Add events */
	event timeEject();



	/* Add constructor */
	function Queue(uint256 _buytime) {
        duration = _buytime;
        numInside = 0;
    }

	/* Returns the number of people waiting in line */
	function qsize() constant returns(uint8) {
		return numInside;
	}

	/* Returns whether the queue is empty or not */
	function empty() constant returns(bool) {
		return isEmpty;
	}
	
	/* Returns the address of the person in the front of the queue */
	function getFirst() constant returns(address) {
		return place2addr[0];
	}
	
	/* Allows `msg.sender` to check their position in the queue */
	function checkPlace() constant returns(uint8) {
        if (addr2place[msg.sender] == 0) {
        	if (place2addr[0] != msg.sender) {
        		return 6;
        	}
        	else {
        		return 0;        		
        	}
        }
        return q[msg.sender];
	}
	
	/* Allows anyone to expel the first person in line if their time
	 * limit is up
	 */
	function checkTime() {
		// YOUR CODE HERE
	}
	
	/* Removes the first person in line; either when their time is up or when
	 * they are done with their purchase
	 */
	function dequeue() {
		address firstInLine = getFirst();
		firstPlace = addr2place[firstInLine];
		delete addr2place[firstInLine];
		delete place2addr[firstPlace];
		first = (first + 1) % size;
		numInside-=1;

		if (numInside == 0) {
			isEmpty = true;

		}
	}

	/* Places `addr` in the first empty position in the queue */
	function enqueue(address addr) {
		if (isFull) {
			revert();

		}
		
		addr2place[addr] = nextFree;
		place2addr[nextFree] = addr;
		lastFilled = nextFree;
		nextFree = (lastFilled+1) % size;
		numInside+=1;

		if (nextFree >= first) {
			isFull = true;
		}

	}    


}
