import { Component } from '@nestjs/common'

@Component()
export class Box {

	private letter = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

    constructor() {}

    public getListBox(size: number) {
    	let boxs = [];
    	for (let i = 0; i < size; ++i) {
    		for (var j = 0; j < size; ++j) {
    			boxs.push(this.letter[i] + (j + 1));
    		}
    	}
    	return boxs;
    }
}