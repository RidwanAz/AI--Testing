#!/bin/bash

# Prompt the user for a number to generate a multiplication table
echo "Enter a number for the multiplication table:"
read number

# Ask the user if they want a full or partial multiplication table
echo "Do you want a full table (1 to 10) or a partial table?"
echo "Enter 'f' for full or 'p' for partial:"
read choice

# Function to generate a full multiplication table
generate_full_table() {
    for i in {1..10}; do
        echo "$number x $i = $((number * i))"
    done
}

# Function to generate a partial multiplication table
generate_partial_table() {
    echo "Enter the starting range (between 1 and 10):"
    read start_range
    echo "Enter the ending range (between 1 and 10):"
    read end_range

    # Validate the input range
    if [[ $start_range -lt 1 || $start_range -gt 10 || $end_range -lt 1 || $end_range -gt 10 || $start_range -gt $end_range ]]; then
        echo "Invalid range. Please enter a valid range between 1 and 10."
    else
        for ((i=$start_range; i<=$end_range; i++)); do
            echo "$number x $i = $((number * i))"
        done
    fi
}

# Decision making to call the appropriate function based on user choice
if [ "$choice" = "f" ]; then
    generate_full_table
elif [ "$choice" = "p" ]; then
    generate_partial_table
else
    echo "Invalid choice. Please restart the script and choose 'f' for full or 'p' for partial."
fi
