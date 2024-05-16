# #!/bin/bash

# # Store the list of untracked files
# untracked_files=$(git ls-files --others --exclude-standard)

# # Initialize a counter
# count=0

# # Initialize a flag to check if there are .jpg files to commit
# jpg_files_found=false

# # Loop through the untracked files and process .jpg files
# for file in $untracked_files; 
# do
#     if [[ $file == *.jpg ]]; then
#         # Add the .jpg file to the staging area
#         git add "$file"
#         jpg_files_found=true
#         count=$((count + 1))
        
#         # Break the loop after adding 10 files
#         if [ $count -ge 15 ]; then
#             break
#         fi
#     fi
# done

# # Commit and push if there are .jpg files
# if [ "$jpg_files_found" = true ]; then
#     # Commit the changes with a message
#     git commit -m "Add untracked .jpg files"

#     # Push the changes to the remote repository
#     git push origin main
# else
#     echo "No untracked .jpg files found."
# fi



#!/bin/bash

process_batch() {
    # Store the list of untracked .jpg files
    untracked_files=$(git ls-files --others --exclude-standard | grep '\.jpg$')

    # Initialize a counter
    count=0

    # Initialize a flag to check if there are .jpg files to commit
    jpg_files_found=false

    # Loop through the untracked files and process up to 10 .jpg files
    for file in $untracked_files; 
    do
        # Add the .jpg file to the staging area
        git add "$file"
        jpg_files_found=true
        count=$((count + 1))

        # Stop after adding 10 files
        if [ $count -ge 20 ]; then
            break
        fi
    done

    # Commit and push if there are .jpg files
    if [ "$jpg_files_found" = true ]; then
        # Commit the changes with a message
        git commit -m "Add untracked .jpg files"

        # Push the changes to the remote repository
        git push origin main
    else
        echo "No untracked .jpg files found."
        return 1
    fi
    return 0
}

# Keep processing batches until no more untracked .jpg files are found
while true; do
    process_batch
    if [ $? -ne 0 ]; then
        break
    fi
done
