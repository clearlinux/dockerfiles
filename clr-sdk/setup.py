#!/usr/bin/python3

import argparse
import subprocess
import os
import sys
import pathlib

parser = argparse.ArgumentParser()
parser.add_argument('-d','--mixdir',
                    help='The directory where you intend to make your mix. '
                         'This will be the active directory once the container '
                         'is running. In the abscence of the "id" argument, '
                         'the owner uid and gid of the mixdir will be used for '
                         'the user in the container.')

parser.add_argument("--id",
                    help='UID and GID to use for the user inside the '
                         'container. It should be in the form UID:GID.')

args = parser.parse_args()

mixdir = args.mixdir if args.mixdir else "/home/clr/mix"


# Get UID and GID for user
uid,gid = (None, None)
if args.id:
	try:
		uid,gid = args.id.split(":")
		uid = int(uid)
		gid = int(gid)
	except ValueError:
		sys.stderr.write("Invalid id: Must be of form UID:GID\n")
		sys.exit(1)
elif args.mixdir:
	# Use owner of mixdir
	try:
		stat = os.stat(args.mixdir)
		uid,gid = (stat.st_uid, stat.st_gid)
	except FileNotFoundError:
		# This implies the --mixdir flag was passed, but to a
		# directory that doesn't exist. It will get created below.
		pass

if not uid or not gid:
	# Use default
	uid,gid = (1000, 1000)
elif uid == 0 or gid == 0:
	sys.stderr.write("UID and GID must both be non-zero.\n")
	sys.exit(1)

user = "clr"

# Create the group and user
try:
	cmd = "groupadd -o -g {} {}".format(gid,user)
	subprocess.run(cmd.split(),stdout=subprocess.PIPE,stderr=subprocess.STDOUT,check=True)
	# Note: adding user to mock group for access to running mock
	cmd = "useradd -Nmo -g {} -G mock -u {} {}".format(gid,uid,user)
	subprocess.run(cmd.split(),stdout=subprocess.PIPE,stderr=subprocess.STDOUT,check=True)
	os.chown("/home/{}".format(user),uid,gid)
except subprocess.SubprocessError:
	sys.stderr.write("Error creating user.\n")
	sys.exit(1)

# Create the mix directory if it doesn't exist.
# Note: we catch FileExistsError rather than using exist_ok=True so 
# that we only chown the directory if we're the one that created it.
try:
	pathlib.Path(mixdir).mkdir(parents=True)
	os.chown(mixdir,uid,gid)
except FileExistsError:
	pass

# Move to mixdir and start bash as new user
os.chdir(mixdir)
cmd = "sudo -H -u {} bash -i".format(user).split()
os.execvp(cmd[0], cmd)

