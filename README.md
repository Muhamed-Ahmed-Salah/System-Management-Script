# 🕒 Task Scheduler Script 🛠️💻

## 📖 Overview 📖
This 🖥️ Bash script provides a task scheduler with two modes: Admin Mode 🛑 and User Mode 👤. It allows users to retrieve system information, control device settings, and manage network configurations 🌍. The script logs all actions to a designated log file 📜.

## ✨ Features ✨
- **Admin Mode:**
  - View 🖥️ system information (🧠 CPU, 🏗️ RAM, 📀 Disk usage)
  - View device information (Change ⚙️ CPU policy, Set 🔋 battery threshold, Control 💡 LED indicators)
  - View network information 🌐
  - Reboot 🔄 or shutdown ⏻ the system
  - View kernel logs 📜

- **User Mode:**
  - View 🖥️ system information
  - View network information 🌍
  - View kernel logs 📜

## ⚙️ Prerequisites ⚙️
- 🐧 Linux-based system
- 🖥️ Bash shell
- 🔑 Root privileges (for Admin Mode operations)

## 📥 Installation 📥
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/System-Management-Script.git
   ```
2. Navigate to the script directory:
   ```sh
   cd System-Management-Script
   ```
3. Grant execution permission:
   ```sh
   chmod +x script.sh
   ```

## 🚀 Usage 🚀
Run the script:
```sh
./script.sh
```
- If run as root, Admin Mode 🛑 will be activated.
- If run as a regular user, User Mode 👤 will be activated.

## 📝 Logging 📝
- Actions are logged in `/home/log.txt`. 🗂️

## 🤝 Contributing 🤝
1. Fork 🍴 the repository.
2. Create a new branch 🌿: `git checkout -b feature-branch`
3. Make your changes ✏️ and commit 💾: `git commit -m 'Add new feature'`
4. Push the changes 📤: `git push origin feature-branch`
5. Open a Pull Request 🔄.



