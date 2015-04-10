Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45604 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932672AbbDJNCh (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 10 Apr 2015 09:02:37 -0400
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH 5/7] fstests: environments - create the environment directory
Date: Fri, 10 Apr 2015 15:02:27 +0200
Message-Id: <1428670949-17524-6-git-send-email-jtulak@redhat.com>
In-Reply-To: <1428670949-17524-1-git-send-email-jtulak@redhat.com>
References: <1428670949-17524-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

Add the environment directory and two environments used by
performance/001-readdir test.

 - empty-files checks ENV_FILES_NUMBER environment variable to know how many files it should create and creates them
 - overlayfs creates and mounts an overlayfs into a directory.

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 common/environments      |  64 ++++++++++++++++++++++
 environments/empty-files |  77 +++++++++++++++++++++++++++
 environments/overlayfs   | 136 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 277 insertions(+)
 create mode 100644 common/environments
 create mode 100644 environments/empty-files
 create mode 100644 environments/overlayfs

diff --git a/common/environments b/common/environments
new file mode 100644
index 0000000..a1aa3b5
--- /dev/null
+++ b/common/environments
@@ -0,0 +1,64 @@
+##/bin/bash
+#-----------------------------------------------------------------------
+#  Copyright (c) 2015 Red Hat, Inc.  All Rights Reserved.
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+#  USA
+#
+#-----------------------------------------------------------------------
+
+# see _usage()
+TARGET="$2"
+
+_usage()
+{
+	echo -e "Usage:\n"
+	"$0 OPTION TARGET_DIR\n"
+	"Where OPTION is one (and only one) of the following:\n"
+	"	prepare, clean"
+}
+
+_init_env()
+{
+	action="$1"
+
+	# arguments...
+	if [ $# -ne 2 ];then
+		_usage
+		return 1
+	fi
+
+	while [ $# -gt 0 ]; do
+		case "$action" in
+			prepare)
+				#echo "# ENVIROMENT $THIS_ENV PREPARE START"
+				touch "$TARGET/.env-prepared-$THIS_ENV"
+				prepare "$2"
+				#echo "# ENVIROMENT $THIS_ENV PREPARE END"
+				shift ;;
+			clean)
+				# clean only if the environment is there
+				if [ -f "$TARGET/.env-prepared-$THIS_ENV" ]; then
+					clean "$2";
+					rm "$TARGET/.env-prepared-$THIS_ENV"
+				fi
+				shift ;;
+			*) usage ; return 1 ;;
+		esac
+		shift
+	done
+
+	return 0
+}
+
diff --git a/environments/empty-files b/environments/empty-files
new file mode 100644
index 0000000..0afa875
--- /dev/null
+++ b/environments/empty-files
@@ -0,0 +1,77 @@
+#!/bin/bash
+# FS QA Environment setup
+#
+# Create directories with lots of empty files. Name the dirs with
+# amount of the files inside. No whitheouts.
+#
+#-----------------------------------------------------------------------
+# Copyright 2015 (C) Red Hat, Inc., Jan Tulak <jtulak@redhat.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+#-----------------------------------------------------------------------
+#
+# arguments: prepare, clean
+# env variables: ENV_FILES_NUMBER
+THIS_ENV="$(basename "$BASH_SOURCE")"
+. $here/common/environments
+
+# --------------------------------------
+# Put here any custom functions or whatever you need
+
+# default value
+if [ "" = "$ENV_FILES_NUMBER" ];then
+	ENV_FILES_NUMBER=1000
+fi
+
+NR_FILES=$ENV_FILES_NUMBER
+
+
+
+
+
+make_dir(){
+	local path=$1
+	local num=$2
+	local i=0
+	# make files
+	time while [ "$i" -lt "$num" ]; do
+		touch "$path/$THIS_ENV-file-$i"
+		let i+=1
+	done
+}
+
+# --------------------------------------
+# The prepare() and clean() functions are mandatory
+# and are called automaticaly.
+# Use them as your entry points.
+
+
+# This function will prepare the environment.
+prepare()
+{
+	echo "Creating $NR_FILES files in $TARGET."
+	make_dir "$TARGET" $NR_FILES
+}
+
+# This function should clean files created by prepare()
+clean()
+{
+	rm "$TARGET/$THIS_ENV-"*
+}
+
+
+# This is needed for really running this script.
+_init_env "$@"
+exit $?
diff --git a/environments/overlayfs b/environments/overlayfs
new file mode 100644
index 0000000..4e823ff
--- /dev/null
+++ b/environments/overlayfs
@@ -0,0 +1,136 @@
+#!/bin/bash
+# FS QA Environment setup
+#
+# Prepare overlayfs in given directory and mount it into
+# $ENV_MERGED
+#
+# You can specify directories for use by exporting
+# $ENV_LOWERDIR, $ENV_UPPERDIR, $ENV_WORKDIR
+#
+# Note, if you pass your own pathes for overlayfs to use
+# as upper/lower/workdir, then they are not cleaned!
+#
+#-----------------------------------------------------------------------
+# Copyright 2015 (C) Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+#-----------------------------------------------------------------------
+#
+# arguments: prepare, clean
+# env variables: ENV_FILES_NUMBER
+THIS_ENV="$(basename "$BASH_SOURCE")"
+. $here/common/environments
+
+
+# --------------------------------------
+# Put here any custom functions or whatever you need
+
+if [ "" = "$ENV_MERGED" ];then
+	2>&1 echo "Can't run $THIS_ENV environment without ENV_MERGED variable set."
+	exit 1
+elif [ ! -d "$ENV_MERGED" ]; then
+	2>&1 echo "Provided ENV_MERGED does not exists!"
+	exit 1
+fi
+
+# default values
+if [ "" = "$ENV_LOWERDIR" ]; then
+	ENV_LOWERDIR="$TARGET/"
+	env_lower_default="yes"
+elif [ ! -d "$ENV_LOWERDIR" ]; then
+	2>&1 echo "Provided ENV_LOWERDIR does not exists: " $ENV_LOWERDIR
+	exit 1
+fi
+if [ "" = "$ENV_UPPERDIR" ]; then
+	ENV_UPPERDIR="$TARGET/upperdir"
+	env_upper_default="yes"
+elif [ ! -d "$ENV_UPPERDIR" ]; then
+	2>&1 echo "Provided ENV_UPPERDIR does not exists: " $ENV_UPPERDIR
+	exit 1
+fi
+if [ "" = "$ENV_WORKDIR" ];then
+	ENV_WORKDIR="$TARGET/workdir"
+	env_work_default="yes"
+elif [ ! -d "$ENV_WORKDIR" ]; then
+	2>&1 echo "Provided ENV_WORKDIR does not exists: " $ENV_WORKDIR
+	exit 1
+fi
+
+create_default_dirs()
+{
+	# lowerdir is by default set to TARGET, so don't create it
+
+	if [ "$env_upper_default" = "yes" ]; then
+		mkdir -p "$ENV_UPPERDIR"
+	fi
+	if [ "$env_work_default" = "yes" ]; then
+		mkdir -p "$ENV_WORKDIR"
+	fi
+}
+
+clean_default_dirs()
+{
+	if [ "$env_upper_default" = "yes" ]; then
+		rm -rf "$ENV_UPPERDIR"
+	fi
+	if [ "$env_work_default" = "yes" ]; then
+		rm -rf "$ENV_WORKDIR"
+	fi
+}
+
+
+mount_overlayfs()
+{
+	# We make lowerdir the root dir, because at least for the test dev,
+	# it stands a chance of having content, making overlayfs a bit more
+	# interesting
+	mount -t overlay none \
+		-o lowerdir="$ENV_LOWERDIR" \
+		-o upperdir="$ENV_UPPERDIR" \
+		-o workdir="$ENV_WORKDIR" \
+		"$ENV_MERGED"
+}
+
+umount_overlayfs()
+{
+	umount "$ENV_MERGED"
+}
+
+
+
+# --------------------------------------
+# The prepare() and clean() functions are mandatory
+# and are called automaticaly.
+# Use them as your entry points.
+
+
+# This function will prepare the environment.
+prepare()
+{
+	create_default_dirs
+	mount_overlayfs
+}
+
+# This function should clean files created by prepare()
+clean()
+{
+	umount_overlayfs
+	clean_default_dirs
+}
+
+
+# This is needed for really running this script.
+_init_env "$@"
+exit $?
-- 
2.1.0

