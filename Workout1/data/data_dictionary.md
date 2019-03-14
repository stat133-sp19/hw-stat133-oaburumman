---
title: "Data Dictionary of NBA Data"
author: "Omar Aburumman"
date: "March 12, 2019"
output:
  html_document: default
  github_document: default
---

|   | A  | B                    | C                 | D                                                                                 |
|---|----|----------------------|-------------------|-----------------------------------------------------------------------------------|
|   | 1  | Name of the Variable | Group of Variable | Description/Meaning of the Variable                                               |
|   | 2  | Period               | Time              | Current Period of the Game, NBA games have 4                                      |
|   | 3  | Minutes_Remaining    | Time              | Minutes left in the current period                                                |
|   | 4  | Seconds_Remaining    | Time              | Seconds remaining in the period                                                   |
|   | 5  | Action_type          | Movement          | The type of movement or basketball move that got the Player to the basket         |
|   | 6  | Shot_Type            | Movement          | Whether the shot scored was worth 2 points or 3 points                            |
|   | 7  | Shot_distance        | Measurement       | How far away from the basket was the shot scored?                                 |
|   | 8  | Shot_made_flag       | Binary Selection  | If the shot was scored indicated with a Y, if shot was missed indicated with a N. |
|   | 9  | X                    | Measurement       | Paired with Y it's the court coordinate where the shot was scored                 |
|   | 10 | Y                    | Measurement       | Paired with X it's the court coordinate where the shot was scored                 |