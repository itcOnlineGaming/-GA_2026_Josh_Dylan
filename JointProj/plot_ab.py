import pandas as pd
import matplotlib.pyplot as plt

file_path = r"C:\Users\gameuser\Desktop\-GA_2026_Josh_Dylan\JointProj\ab_test_results.csv"

df = pd.read_csv(file_path)

# Group by condition and calculate mean survival time
grouped = df.groupby("condition")["survival_time"].mean()

# Plot
plt.figure()
grouped.plot(kind="bar")
plt.title("Average Survival Time by Teleport Cooldown Condition")
plt.xlabel("Condition")
plt.ylabel("Average Survival Time (seconds)")
plt.tight_layout()
plt.show()
