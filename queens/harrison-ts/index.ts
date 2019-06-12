import readline from "readline";
import play from "./Game";

let boardSize: number = 0;
let positions: number[][] = [];

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
});

rl.on("line", (line) => {
    if (boardSize === 0) {
        boardSize = parseInt(line);
    } else {
        const stringPositions = line.split(" ");
        const xPosition = parseInt(stringPositions[0]);
        const yPosition = parseInt(stringPositions[1]);

        positions.push([xPosition, yPosition]);
    }

    if (positions.length === boardSize) {
        console.log(play(positions));
        boardSize = 0;
        positions = [];
    }
});