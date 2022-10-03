import numpy as np


# North, East, West, South
error_percent = np.array([0.8, 0.1, 0.1, 0])
survival_reward = 0.1
goal_list = np.array([[3, 3, 1], [3, 2, -1]])

# Create Grid World
# The places which is not goal
grid_world = np.zeros(
    (
        3,
        3,
    )
)
grid_world[1, 2] = 1
grid_world[0, 2] = -1
