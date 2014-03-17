# run vagrant up
echo "Running `Vagrant Up`"
vagrant up

# run rsync auto
echo "Starting Rsync Synchronisation"
vagrant rsync-auto
