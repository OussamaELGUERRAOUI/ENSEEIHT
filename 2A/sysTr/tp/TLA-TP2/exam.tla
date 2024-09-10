-------------- MODULE xySystem --------------
EXTENDS Naturals, TLC

VARIABLES x, y

Init ==
    /\ x \in {0, 1}
    /\ y = x

action1 ==
    /\ x = y
    /\ x' = 0
    /\ y' = 1

action2 ==
    /\ x = y
    /\ x' = 1
    /\ y' = 0

action3 ==
    /\ x + y = 1
    /\ x' = y
    /\ UNCHANGED y

action4 ==
    /\ x /= y
    /\ x' = 0
    /\ y' = 2

Next ==
    \/ action1
    \/ action2
    \/ action3
    \/ action4

Fairness ==
    /\ WF_<<x,y>> (action1)
              /\ WF_<<x,y>> (action4)

Spec ==
   /\ Init /\ [] [Next]_<<x, y>> /\ Fairness
