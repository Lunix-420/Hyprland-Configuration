package main

import (
	"bufio"
	"bytes"
	"encoding/json"
	"flag"
	"fmt"
	"io/ioutil"
	"net"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"time"

	"github.com/hugolgst/rich-go/client"
)

type ActiveWindow struct {
	Address   string      `json:"address"`
	Workspace interface{} `json:"workspace"`
	Title     string      `json:"initialTitle"`
	Class     string      `json:"class"`
	PID       int         `json:"pid"`
}

var (
	debounceTimer *time.Timer
	useStream     bool
	startTime     time.Time
)

func init() {
	// Parse command-line flags
	flag.BoolVar(&useStream, "use-stream-window", false, "Enable real-time window tracking")
	flag.Parse()

	startTime = time.Now()
}

func getDistName() (string, error) {
	data, err := ioutil.ReadFile("/etc/os-release")
	if err != nil {
		return "", fmt.Errorf("failed to read /etc/os-release: %w", err)
	}

	for _, line := range strings.Split(string(data), "\n") {
		if strings.HasPrefix(line, "NAME=") {
			return strings.Trim(line[len("NAME="):], `"`), nil
		}
	}

	return "Unknown", fmt.Errorf("distribution name not found in /etc/os-release")
}

func getHyprlandSocketPath() string {
	runtimeDir := os.Getenv("XDG_RUNTIME_DIR")
	if runtimeDir == "" {
		runtimeDir = fmt.Sprintf("/run/user/%d", os.Getuid())
	}

	hyprDir := filepath.Join(runtimeDir, "hypr")

	files, err := ioutil.ReadDir(hyprDir)
	if err != nil || len(files) == 0 {
		fmt.Println("Error: No Hyprland instance found in", hyprDir)
		os.Exit(1)
	}

	instanceSignature := files[0].Name()
	return filepath.Join(hyprDir, instanceSignature, ".socket2.sock")
}

func getActiveWindowTitle(title, class string) string {
	if title != "" {
		return fmt.Sprintf("Opening %s", title)
	}
	if class != "" {
		return fmt.Sprintf("Opening %s", class)
	}
	return "No window opened"
}

func getActiveWindowDetails() (*ActiveWindow, error) {
	cmd := exec.Command("hyprctl", "activewindow", "-j")
	var out bytes.Buffer
	cmd.Stdout = &out

	err := cmd.Run()
	if err != nil {
		return nil, fmt.Errorf("failed to run hyprctl: %w", err)
	}

	var window ActiveWindow
	if err := json.Unmarshal(out.Bytes(), &window); err != nil {
		return nil, fmt.Errorf("failed to parse JSON: %w", err)
	}

	return &window, nil
}

func updateDiscordPresence(activeWindow, distName string) {
	err := client.SetActivity(client.Activity{
		State:      activeWindow,
		Details:    fmt.Sprintf("Using Hyprland on %s", distName),
		LargeImage: "hyprland-dark",
		LargeText:  "Hyprland",
		Timestamps: &client.Timestamps{
			Start: &startTime,
		},
	})
	if err != nil {
		fmt.Println("Failed to update Discord presence:", err)
	}
}

func debounceUpdate(activeWindow, distName string) {
	if debounceTimer != nil {
		debounceTimer.Stop()
	}
	debounceTimer = time.AfterFunc(2000*time.Millisecond, func() {
		updateDiscordPresence(activeWindow, distName)
	})
}

func listenForActiveWindowChanges() {
	socketPath := getHyprlandSocketPath()

	conn, err := net.Dial("unix", socketPath)
	if err != nil {
		fmt.Println("Failed to connect to Hyprland socket:", err)
		return
	}
	defer conn.Close()

	_, err = conn.Write([]byte("subactivewindow\n"))
	if err != nil {
		fmt.Println("Failed to send subscription request:", err)
		return
	}

	fmt.Println("Listening for active window changes...")

	scanner := bufio.NewScanner(conn)
	for scanner.Scan() {
		window, err := getActiveWindowDetails()
		if err != nil {
			fmt.Println("Error fetching active window details:", err)
			continue
		}

		activeWindow := getActiveWindowTitle(window.Title, window.Class)

		distName, err := getDistName()
		if err != nil {
			fmt.Println("Error detecting distribution:", err)
			distName = "Unknown"
		}

		debounceUpdate(activeWindow, distName)
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error reading from socket:", err)
	}
}

func main() {
	err := client.Login("1346300274087559259")
	if err != nil {
		fmt.Println("Failed to connect to Discord:", err)
		return
	}

	if useStream {
		listenForActiveWindowChanges()
	} else {
		distName, err := getDistName()
		if err != nil {
			fmt.Println("Error detecting distribution:", err)
			distName = "Unknown"
		}
		updateDiscordPresence("Working on something great", distName)
		select {} // Keep the program running
	}
}
