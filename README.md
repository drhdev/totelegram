# totelegram

`totelgram` is a versatile Bash script designed to enhance communication by automating the sending of files or file contents as messages directly to a Telegram chat. Utilizing a Telegram bot, this script is perfect for anyone looking to automate alerts, share logs, or send documents and updates within a Telegram chat environment. Its features include detailed logging, cron job support for scheduled sending, and a verbose output option for real-time operation monitoring, all wrapped in a user-friendly interface.

## Features

- **Send Files as Attachments:** Directly send any file as an attachment to your designated Telegram chat.
- **Send Text Content as Messages:** Automatically send the text content of files as Telegram messages, ideal for logs and text updates.
- **Comprehensive Logging:** Maintains detailed logs for every action performed by the script, ensuring traceability and accountability.
- **Cron Job Support:** Facilitates easy integration with cron for scheduling, making it perfect for regular updates or backups.
- **Verbose Output:** Offers an optional verbose output mode for detailed insights into the script's operations, while maintaining a silent mode ideal for background tasks.
- **Configurable for Your Needs:** Easily set up with your specific Telegram Bot token and Chat ID for personalized use.

## Getting Started

### Prerequisites

Ensure you have `curl` installed on your system, as it's required for the script to communicate with the Telegram API.

### Installation

1. Clone the repository:

```sh
git clone https://github.com/drhdev/totelegram.git
```

2. Navigate to the script directory:

```sh
cd totelegram
```

3. Make the script executable:

```sh
chmod +x totelegram.sh
```

4. Edit `totelgram.sh` to include your Telegram bot's token and the target Chat ID. These are clearly marked near the beginning of the script.

## Usage

The script offers flexibility with two primary functions: sending files as attachments and sending file contents as messages.

### Send a File as an Attachment

```sh
./totelgram.sh -file <path_to_file> [--verbose]
```

### Send File Content as a Message

```sh
./totelgram.sh -message <path_to_file> [--verbose]
```

### Help and Options

For a detailed list of options:

```sh
./totelgram.sh -help
```

### Scheduling with Cron

To run the script at scheduled times (e.g., daily at 2 AM), add it to your crontab:

```crontab
0 2 * * * /absolute/path/to/totelgram.sh -file <file_path> >> /var/log/totelgram/cron.log 2>&1
```

Adjust the command according to your needs and filepath.

## Logging

Logs are generated at `/var/log/totelegram/totelgram.log`, providing detailed information on each operation, including file names, timestamps, and the Telegram chat ID involved.

## Contributing

Contributions are very welcome! Whether you have enhancements, bug fixes, or suggestions, please feel free to fork the repository, make your changes, and submit a pull request.

## License

This project is licensed under the GNU Public License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions, please don't hesitate to open an issue on the [GitHub issue tracker](https://github.com/drhdev/totelegram/issues).
