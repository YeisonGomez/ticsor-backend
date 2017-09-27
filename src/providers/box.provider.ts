import { Component } from '@nestjs/common'

@Component()
export class Box {

	public static letter = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

    constructor() {}

    public getListBox(size: number) {
    	let boxs = [];
    	for (let i = 0; i < size; ++i) {
    		for (var j = 0; j < size; ++j) {
    			boxs.push(Box.letter[i] + (j + 1));
    		}
    	}
    	return boxs;
    }

    public findUserById(users, id){
        for (var i = 0; i < users.length; ++i) {
            if(users[i].id == id){
                return i;
            }
        }
        return -1;
    }

    public validateFinish(box: string, color: string, boxEnd: string){
        let columnFinish = parseInt(boxEnd.substring(1, boxEnd.length));
        let column = parseInt(box.substring(1, box.length));
        return (column == columnFinish && color == 'white') || (column == 1 && color == 'black');
    }

    public getPositionInitial(posEnd: string){
        let postions = { white: [], black: [] };
        let columns = parseInt(posEnd.substring(1, posEnd.length))
        let letter = posEnd.substring(0, 1);
        let letterEnd = Box.letter[(Box.letter.indexOf(letter) - 1)]

        let i = 0;
        while(i < Box.letter.indexOf(letter) + 1){
            postions.white.push(Box.letter[i] + 2);
            postions.black.push(Box.letter[i] + (columns - 1));
            i++;
        }
        return postions;
    }

    public nextPosition(boxName: string, movimiento: number, letterEnd: string, color: number){
        let letter = boxName.substring(0, 1);
        let column = parseInt(boxName.substring(1, boxName.length));
        if(movimiento == 1){
            return letter + ((color == 0)? (column + 1): (column - 1));
        } else if(movimiento == 2){
            if(letter == 'A'){
                return 'STATIC';
            }
            return Box.letter[(Box.letter.indexOf(letter) - 1)] + ((color == 0)? (column + 1): (column - 1));
        } else if(movimiento == 3){
            if(letter == letterEnd){
                return 'STATIC';
            }
            return Box.letter[(Box.letter.indexOf(letter) + 1)] + ((color == 0)? (column + 1): (column - 1));
        }

        return boxName;
    }
}