import logging
import os

from dotenv import load_dotenv

from msg import print_message

load_dotenv()

SECRET = os.getenv("SECRET", "123456")


def main():
    logging.info("Hello from logging")
    print_message("Hello World from Docker!")
    print_message(f"Secret value: {SECRET}")


if __name__ == "__main__":
    main()
