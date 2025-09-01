#!/bin/bash

# Get list of all sinks
sinks=($(pactl list short sinks | awk '{print $2}'))

# Check if exactly two sinks are available
if [ ${#sinks[@]} -ne 2 ]; then
    echo "Exactly two sinks are required. Found ${#sinks[@]}."
    exit 1
fi

# Get the current default sink
current_sink=$(pactl info | grep "Default Sink" | awk '{print $3}')

# Determine the new sink (the one that's not currently default)
if [ "$current_sink" = "${sinks[0]}" ]; then
    new_sink=${sinks[1]}
else
    new_sink=${sinks[0]}
fi

# Set the new default sink
pactl set-default-sink "$new_sink"
# echo "Switched default sink to: $new_sink"
notify-send "Switched Default Sink to: $new_sink"

# Move all sink inputs to the new default sink
sink_inputs=$(pactl list short sink-inputs | awk '{print $1}')

for input in $sink_inputs; do
    pactl move-sink-input "$input" "$new_sink"
    echo "Moved sink input $input to $new_sink"
done
