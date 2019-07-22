import readline from "readline";
import { buildBoard, play } from "./Game";

let rows: number = 0;
let cols: number = 0;
let data: number[][] = [];
let hasRun: boolean = false;

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
});

rl.on("line", (line) => {
    if (!hasRun) {
        const [rowsString, colsString] = line.split(" ");
        rows = parseInt(rowsString, 10);
        cols = parseInt(colsString, 10);
        hasRun = true;
    } else {
        data.push(
            line.split("")
                .map((positionString) => {
                    return parseInt(positionString, 10);
        }));
    }

    if (data.length === rows) {
        const graph = buildBoard(data, rows, cols);

        console.log(play(graph, rows, cols));

        hasRun = false;
        data = [];
    }
});
