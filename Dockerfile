# Use an official MySQL runtime as a parent image
FROM mysql:latest

# Copy the database dump script into the container at /usr/local/bin
COPY mysqldump.sh /usr/local/bin/mysqldump.sh

# Ensure the script is executable
RUN chmod +x /usr/local/bin/mysqldump.sh

# Run the database dump script when the container launches
CMD ["/usr/local/bin/mysqldump.sh"]
