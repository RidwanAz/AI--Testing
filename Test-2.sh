#!/bin/bash


read number



read choice


generate_full_table() {
    for i in {1..10}; do
        echo "$number x $i = $((number * i))"
   
}

generate_partial_table() 
   
    read start_range
    echo "Enter the ending range
    read end_range

   
    if [[ $start_range -lt 1  || $end_range -lt 1 || $end_range -gt 10; then
        echo "Invalid range. Please enter a valid range between 1 and 10."
    else
        for ((i=$start_range; i<=$end_range; i++)); do
            echo "$number x $i = $((number * i))"
        done
    fi
}


if [ "$choice" = "f" ]; then
    generate_full_table
elif [ "$choice" = "p" ]; then
    generate_partial_table
else
    echo "Invalid choice. Please restart the script and choose 'f' for full or 'p' for partial."
fi
