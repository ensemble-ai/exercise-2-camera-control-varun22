# Peer-Review for Programming Exercise 2

## Description

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.

## Due Date and Submission Information

See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.

# Solution Assessment

## Peer-reviewer Information

- _name:_ Siwei Tan
- _email:_ siwtan@ucdavis.edu

### Description

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect

    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great

    Minor flaws in one or two objectives.

#### Good

    Major flaw and some minor flaws.

#### Satisfactory

    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory

    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.

---

## Solution Assessment

### Stage 1

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification

stage 1 is perfect. The code is well written and the camera is right stick on the crosshair. Nice job!

---

### Stage 2

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification

Stage 2 is almost perfect. autoscroll_speed is implemented correctly and the camera is correctly push by the box edge.

One small flaws on the logics is that when checking the edge of the boarderbox, you used the central postion of the vessl' sprite instead of carefully useing the left/right/up/down edge of that circle sprite. this causes that the sprite of that vessel is not strictly inside the auto-scroll box.

---

### Stage 3

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification

Nice following machamism for the camera.

One flaw is that when sprite at the edge of then leash distance, the sprite of that vessel is shaking, which is not good for the game experience.

---

### Stage 4

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification

Same flas as stage 3, the sprite of the vessel is shaking when it is at the edge of the leash distance.

---

### Stage 5

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification

Write Justification here.

---

# Code Style

### Description

Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

- [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.

#### Style Guide Infractions

#### Style Guide Exemplars

---

#### Put style guide infractures

---

# Best Practices

### Description

If the student has followed best practices then feel free to point at these code segments as examplars.

If the student has breached the best practices and has done something that should be noted, please add the infraction.

This should be similar to the Code Style justification.

#### Best Practices Infractions

For stage 3, I think you can add a small buffer to the leash distance to avoid this OR not changing the speed of the camera but only the position of the camera.

#### Best Practices Exemplars
