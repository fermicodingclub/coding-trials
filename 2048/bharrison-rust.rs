use std::iter::FromIterator;

fn play(slice: &str) -> String {
    let mut result = String::new();
    let mut direction = 99;
    let mut col = 0;
    let mut row = 0;
    let mut board = vec![vec![0; 4]; 4];
    let game_state: Vec<u16> = Vec::from_iter(slice
                                            .split_whitespace()
                                            .map(|c| c.parse().unwrap()));
    for cell_value in game_state {
        if col > 3 {
            col = 0;
            row += 1;
        };
        if row == 4 {
            direction = cell_value;
            break;
        };

        board[row][col] = cell_value;

        if col == 3 {
            println!("{:#?}", board[row]);
            let mut new_vec = vec![0; 4];
            let mut prev_value = 0;
            let mut index = 0;
            for value in &board[row] {
                let mut collapse = false;
                let mut new_value = 0;
                if *value == prev_value || *value == 0 {
                    collapse = true;
                    new_value = *value * 2;
                }

                if *value != 0 {
                    if collapse {
                        new_vec[index - 1] = new_value;
                        prev_value = new_value;
                    } else {
                        new_vec[index] = *value;
                        prev_value = *value;
                        index += 1;
                    }
                }
            }

            board[row] = new_vec;
        }

        col += 1;
    }

    for row in board {
        for cell in row {
            result.push_str(&cell.to_string());
            result.push_str(" ");
        }
        result = result.trim().to_string();
        result.push_str("\n");
    }
    println!("{:#?}", result);
    result
}

fn main() {
    println!("Hello, world!");
}

#[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;

    // 0 - left
    // 1 - up
    // 2 - right
    // 3 - down

    #[test]
    fn test_left() {
        assert_eq!(
            play("2 0 0 2\n\
                  4 16 8 2\n\
                  2 64 32 4\n\
                  1024 1024 64 0\n\
                  0\n"),
                 String::from("4 0 0 0\n\
                  4 16 8 2\n\
                  2 64 32 4\n\
                  2048 64 0 0\n"),
                "move left"
        );
    }

    #[test]
    #[ignore]
    fn test_up() {
        assert_eq!(
            play("2 0 0 2\n\
                  4 16 8 2\n\
                  2 64 32 4\n\
                  1024 1024 64 0\n\
                  1\n"),
                 "2 16 8 4\n\
                  4 64 32 4\n\
                  2 1024 64 0\n\
                  1024 0 0 0\n",
                "up"
        );
    }

    #[test]
    #[ignore]
    fn test_right() {
        assert_eq!(
            play("2 0 0 2\n\
                  4 16 8 2\n\
                  2 64 32 4\n\
                  1024 1024 64 0\n\
                  2\n"),
                 "0 0 0 4\n\
                  4 16 8 2\n\
                  2 64 32 4\n\
                  0 0 2048 64",
                "right"
        );
    }

    #[test]
    #[ignore]
    fn test_down() {
        assert_eq!(
            play("2 0 0 2\n\
                  4 16 8 2\n\
                  2 64 32 4\n\
                  1024 1024 64 0\n\
                  3\n"),
                 "2 0 0 0\n\
                  4 16 8 0\n\
                  2 64 32 4\n\
                  1024 1024 64 4\n",
                "down"
        );
    }
}