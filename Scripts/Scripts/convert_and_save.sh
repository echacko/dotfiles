#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 input_zip_file output_directory"
    exit 1
fi

input_zip_file="$1"
output_directory="$2"

# List all DOCX files in the ZIP archive
mapfile -t docx_files < <(unzip -Z -1 "$input_zip_file" "*.docx")

# Check the number of DOCX files
num_files="${#docx_files[@]}"

if [ "$num_files" -eq 0 ]; then
    echo "No DOCX files found in the ZIP archive."
    exit 1
elif [ "$num_files" -eq 1 ]; then
    selected_docx="${docx_files[0]}"
else
    echo "Select the DOCX file to convert:"
    for ((i=0; i<num_files; i++)); do
        echo "$i. ${docx_files[$i]}"
    done

    read -p "Enter the number: " selection

    if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 0 ] || [ "$selection" -ge "$num_files" ]; then
        echo "Invalid selection."
        exit 1
    fi

    selected_docx="${docx_files[$selection]}"
fi

# Extract the selected DOCX file from the ZIP archive
unzip -o "$input_zip_file" "$selected_docx"

# Convert DOCX to PDF using libreoffice
pdf_file="${selected_docx%.docx}.pdf"
pdf_file="${pdf_file##*/}"
libreoffice --headless --convert-to pdf "$selected_docx"

# Move the PDF to the specified output directory
mv "$pdf_file" "$output_directory"

# Clean up extracted DOCX file
rm -f "$output_directory/$selected_docx"

echo "Conversion complete: $pdf_file saved in $output_directory"

