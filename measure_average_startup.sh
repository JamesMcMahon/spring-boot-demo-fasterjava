#!/usr/bin/env bash
set -e  # Exit on error

# Initialize variables for total and count
total_time=0
count=0

# Run the script multiple times
for _ in {1..20}; do
    # Run the measure_startup.sh script and capture the output
    startup_time=$(./docker-startup-time.sh | grep "Application Startup Time" | awk '{print $4}')

    # Add the captured startup time to the total
    total_time=$(echo "$total_time + $startup_time" | bc)

    # Increment the count
    count=$((count + 1))
done

# Calculate the average startup time
average_time=$(echo "scale=2; ($total_time / $count) * 1000" | bc)

# Output the average startup time
echo "Average Startup Time: $average_time ms"
