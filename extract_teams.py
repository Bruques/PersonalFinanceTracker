#!/usr/bin/env python3
import subprocess
import re
import os

def get_xcode_team_info():
    # Expand ~ in the path to get the full path to the plist file
    plist_path = os.path.expanduser("~/Library/Preferences/com.apple.dt.Xcode.plist")

    try:
        # Run the 'defaults read' command to get provisioning teams from the plist
        result = subprocess.run(
            ["defaults", "read", plist_path, "IDEProvisioningTeams"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            check=True,
            text=True
        )
        return result.stdout
    except subprocess.CalledProcessError as e:
        # If an error occurs while reading the plist, print the error message
        print("❌ Failed to read Xcode provisioning teams:")
        print(e.stderr.strip())
        return None

def parse_teams(data):
    # Combined regex pattern to capture both teamID and teamName at once
    combined_pattern = re.compile(r'''
        teamID\s*=\s*([A-Za-z0-9]+);    # Match 'teamID' followed by an alphanumeric string and a semicolon
        \s*                             # Match any optional whitespace
        teamName\s*=\s*"([^"]+)"        # Match 'teamName' followed by the team name in quotes
    ''', re.VERBOSE)

    # Use the regex to find all matching teamID and teamName pairs
    teams = combined_pattern.findall(data)
    return teams

def main():
    # Get the raw data from the 'defaults read' command
    raw_data = get_xcode_team_info()
    if not raw_data:
        return

    # Parse the data to extract team information
    teams = parse_teams(raw_data)
    if not teams:
        print("⚠️  No teams found in Xcode settings.")
        return

    # Output the extracted team information
    print("📦 Found Provisioning Teams:\n")
    for team_id, team_name in teams:
        print(f"Team ID:   {team_id}")
        print(f"Team Name: {team_name}")
        print()

if __name__ == "__main__":
    main()
