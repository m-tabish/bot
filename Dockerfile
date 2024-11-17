# Use the Python 3.9 Slim Docker image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Create and activate a virtual environment named "rag-bot-v9"
RUN python -m venv rag-bot-v9
RUN . rag-bot-v9/bin/activate

# Install nano or any other text editor
RUN apt-get update && apt-get install -y vim

# Install dependencies if you have a requirements.txt file
RUN rag-bot-v9/bin/pip install -r requirements.txt  # Uncomment if using requirements.txt
RUN pip install --quiet --upgrade langchain langchain-community langchain-chroma PyPDF2 langchain_google_genai streamlit langchain_huggingface langchain_text_splitters python-dotenv

#Expose the port the app runs on
EXPOSE 8501
# Default command to keep the container running
CMD ["streamlit", "run", "main.py", "--server.port=8501", "--server.address=0.0.0.0"]
