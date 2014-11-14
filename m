Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56841 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933794AbaKNN3L (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 14 Nov 2014 08:29:11 -0500
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH 1/7] Create environment setup files
Date: Fri, 14 Nov 2014 14:27:41 +0100
Message-Id: <1415971667-16873-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>, lczerner@redhat.com, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

First from a batch of patches for adding an environment support.  This
description is rather long, as it describes the goal of all set, so a
TLDR version at first:

- Allows to separate preparation of the environment (full fs,
  damaged fs, ...) from a test itself. So multiple tests can use
  exactly the same conditions.
- A single test can be run in multiple environments.
- Disabled by default for backward compatibility (it changes output).
- I expect it will cause some debate. It is my first bigger patch
  at all. :-)

Long version:

The goal of this set is to allow a single test to be run in different
sitations, for example on empty filesystem, full fs, or damaged fs.
It provides an interface for scripts that can prepare the requested
environments and takes care of starting the test for each one.

Currently, this functionality needs to be enabled explicitely by a
flag -e. It changes output slightly, so I saw this as neccessity.  The
output change is because one test can be run multiple times in
different environments, to note the combination. So when enabled,
[env-name] is added: "xfs/001 [some-environment] 123s ... 456s"

If the test is not aware of this new functionality, nothing changes
for it, the test will run as usuall.

This is a part of my work on performance tests (they needs this sort
of functionality), but is independent on them, so I'm proposing it
now.

Of the seven patches, first three creates new files. Patches four to
six modifies ./check script, but keeps the changes out of existing
code as much as possible (patch four is only exception).  Patch seven
is integrating it all together and is enabling the functionality.

To sum how it works:
New file "environment", similar to "group" file, is created in each
test category. It uses similar syntax, but it ortogonal to groups. In
this file, each test can have specified one or more environments. When
environments are enabled (./check -e ), list of tests is compiled as
before (so -g, -x and other arguments works as usually) and for the
enabled tests, environments are found.

If one test has multiple environments (and the selection is not
limited for only some env.), the test is duplicated for each specified
environment. Each run is then reported independently, as a combination
of the test and the environment. When the test is not found in the
file, it is added implicitly with "none" environment. The none
environment do nothing and can be stated explicitly in the file also.

The tests has to be aware of this. The same way as test requires
TEST_DIR or SCRATCH_DIR, it also needs to require environment setup
for one of these dirs. Some example is:

_require_test
_require_environment $TEST_DIR

If the test is not aware of environments, it runs just as before.

It is possible to share the environment between multiple tests.  For
some longer-running setups (like filling the filesystem with lots of
data), it is usefull to be able to keep the created files.  So in the
environment file, prefixing an environment with underscore switches
between this persistent environment and a "prepare it always from
scratch" mode. Right now, the default is to "prepare once, run
multiple times." That is good for the performance testing that will
follow, but I can change it if it would help to other tests.

For now, did not edited existing tests to make them environment-aware.
In existing tests, as opossed to performance testing, there is not
much places where this is useful, as they checks for specific things
in specific conditions. So these patches are primary infrastructure
preparation work for perfromance tests.

So an example of how to run tests with environments is:
./check -e -g performance
for running all tests in performance group with all environments 
assigned in an environment file. Text arguments of -eo/-ex can be
used to explicitly select just test/environment combinations with
or without given environment.

Further details are in each patch.

THIS PATCH SPECIFIC DESCRIPTION:
>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8

This patch creates four example scripts for setting up an environment
in "environments" directory. Except an empty template and two dummy
files (used for a demonstration of how "more environments for one
test"), there is "fill90-dvd script, which fills a target dir
(TEST_DIR/SCRATCH_DIR) from 90 percents with files of a DVD size
(4 GiB).

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 environments/_template  | 100 +++++++++++++++++++++++++++++++++++++++++
 environments/dummy1     |  99 +++++++++++++++++++++++++++++++++++++++++
 environments/dummy2     |  99 +++++++++++++++++++++++++++++++++++++++++
 environments/fill90-dvd | 115 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 413 insertions(+)
 create mode 100644 environments/_template
 create mode 100644 environments/dummy1
 create mode 100644 environments/dummy2
 create mode 100644 environments/fill90-dvd

diff --git a/environments/_template b/environments/_template
new file mode 100644
index 0000000..937bf7d
--- /dev/null
+++ b/environments/_template
@@ -0,0 +1,100 @@
+#!/bin/bash
+# FS QA Environment setup
+#-----------------------------------------------------------------------
+# Copyright 2014 (C) Red Hat, Inc., Jan Tulak <jtulak@redhat.com>
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
+# arguments: prepare-once, prepare-always, clean
+
+
+THIS_ENVIRONMENT="$(basename $BASH_SOURCE)"
+
+
+# This function should prepare the environment
+prepare()
+{
+	target="$1"
+	echo "ENV ---- Really preparing test directory '$target'."
+}
+
+# This function should clean files created by prepare()
+clean()
+{
+	target="$1"
+	echo "ENV ---- cleaning '$target'"
+}
+
+
+
+
+# ----------------------------------------------------------------------
+# The following code usually don't need any changes for your environment
+# ----------------------------------------------------------------------
+
+prepare_once()
+{
+	target="$1"
+	# check if this environment is already created (was the last one
+	# running)
+	if [ "$env_last" != "$THIS_ENVIRONMENT" ];then
+		echo "ENV ---- There was some other environment, so lets do something in $target. ($THIS_ENVIRONMENT)"
+		prepare "$target"
+	else
+		echo "ENV ---- Stop there, I'm already prepared! ($THIS_ENVIRONMENT)"
+	fi
+
+}
+
+prepare_always()
+{
+	target="$1"
+	# We still need to check the previous environment,
+	# because if it is the same as now, it wasn't cleaned yet!
+	if [ "$env_last" = "$THIS_ENVIRONMENT" ];then
+		echo "ENV ---- I'm preparing again... but I need to clean!"
+		clean "$target"
+	else
+		echo "ENV ---- I'm preparing 'again'... but I wasn't run yet."
+	fi
+	prepare "$target"
+}
+
+usage()
+{
+echo "Usage: 
+$0 OPTION TARGET_DIR
+Where OPTION is one (and only one) of the following:
+    prepare-once, prepare-always, clean"
+}
+
+# arguments...
+if [ $# -ne 2 ];then
+	usage
+#	exit 1
+fi
+
+while [ $# -gt 0 ]; do
+	case "$1" in
+		prepare-once) prepare_once "$2"; shift ;;
+		prepare-always) prepare_always "$2"; shift ;;
+		clean) unset ENVIRONMENT_LAST; clean "$2"; shift ;;
+		*) usage ; exit 1 ;;
+	esac
+	shift
+done
+
+exit 0
diff --git a/environments/dummy1 b/environments/dummy1
new file mode 100644
index 0000000..de6dcf0
--- /dev/null
+++ b/environments/dummy1
@@ -0,0 +1,99 @@
+#!/bin/bash
+# FS QA Environment setup - a dummy file, does nothing
+#-----------------------------------------------------------------------
+# Copyright 2014 (C) Red Hat, Inc., Jan Tulak <jtulak@redhat.com>
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
+# arguments: prepare-once, prepare-always, clean
+
+THIS_ENVIRONMENT="$(basename $BASH_SOURCE)"
+
+
+# This function should prepare the environment
+prepare()
+{
+	target="$1"
+#	echo "ENV ---- Really preparing test directory '$target'."
+}
+
+# This function should clean files created by prepare()
+clean()
+{
+	target="$1"
+#	echo "ENV ---- cleaning '$target'"
+}
+
+
+
+
+# ----------------------------------------------------------------------
+# The following code usually don't need any changes for your environment
+# ----------------------------------------------------------------------
+
+prepare_once()
+{
+	target="$1"
+	# check if this environment is already created (was the last one
+	# running)
+	if [ "$env_last" != "$THIS_ENVIRONMENT" ];then
+#		echo "ENV ---- There was some other environment, so lets do something in $target. ($THIS_ENVIRONMENT)"
+		prepare "$target"
+#	else
+#		echo "ENV ---- Stop there, I'm already prepared! ($THIS_ENVIRONMENT)"
+	fi
+
+}
+
+prepare_always()
+{
+	target="$1"
+	# We still need to check the previous environment,
+	# because if it is the same as now, it wasn't cleaned yet!
+	if [ "$env_last" = "$THIS_ENVIRONMENT" ];then
+#		echo "ENV ---- I'm preparing again... but I need to clean!"
+		clean "$target"
+#	else
+#		echo "ENV ---- I'm preparing 'again'... but I wasn't run yet."
+	fi
+	prepare "$target"
+}
+
+usage()
+{
+echo "Usage: 
+$0 OPTION TARGET_DIR
+Where OPTION is one (and only one) of the following:
+    prepare-once, prepare-always, clean"
+}
+
+# arguments...
+if [ $# -ne 2 ];then
+	usage
+#	exit 1
+fi
+
+while [ $# -gt 0 ]; do
+	case "$1" in
+		prepare-once) prepare_once "$2"; shift ;;
+		prepare-always) prepare_always "$2"; shift ;;
+		clean) unset ENVIRONMENT_LAST; clean "$2"; shift ;;
+		*) usage ; exit 1 ;;
+	esac
+	shift
+done
+
+exit 0
diff --git a/environments/dummy2 b/environments/dummy2
new file mode 100644
index 0000000..de6dcf0
--- /dev/null
+++ b/environments/dummy2
@@ -0,0 +1,99 @@
+#!/bin/bash
+# FS QA Environment setup - a dummy file, does nothing
+#-----------------------------------------------------------------------
+# Copyright 2014 (C) Red Hat, Inc., Jan Tulak <jtulak@redhat.com>
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
+# arguments: prepare-once, prepare-always, clean
+
+THIS_ENVIRONMENT="$(basename $BASH_SOURCE)"
+
+
+# This function should prepare the environment
+prepare()
+{
+	target="$1"
+#	echo "ENV ---- Really preparing test directory '$target'."
+}
+
+# This function should clean files created by prepare()
+clean()
+{
+	target="$1"
+#	echo "ENV ---- cleaning '$target'"
+}
+
+
+
+
+# ----------------------------------------------------------------------
+# The following code usually don't need any changes for your environment
+# ----------------------------------------------------------------------
+
+prepare_once()
+{
+	target="$1"
+	# check if this environment is already created (was the last one
+	# running)
+	if [ "$env_last" != "$THIS_ENVIRONMENT" ];then
+#		echo "ENV ---- There was some other environment, so lets do something in $target. ($THIS_ENVIRONMENT)"
+		prepare "$target"
+#	else
+#		echo "ENV ---- Stop there, I'm already prepared! ($THIS_ENVIRONMENT)"
+	fi
+
+}
+
+prepare_always()
+{
+	target="$1"
+	# We still need to check the previous environment,
+	# because if it is the same as now, it wasn't cleaned yet!
+	if [ "$env_last" = "$THIS_ENVIRONMENT" ];then
+#		echo "ENV ---- I'm preparing again... but I need to clean!"
+		clean "$target"
+#	else
+#		echo "ENV ---- I'm preparing 'again'... but I wasn't run yet."
+	fi
+	prepare "$target"
+}
+
+usage()
+{
+echo "Usage: 
+$0 OPTION TARGET_DIR
+Where OPTION is one (and only one) of the following:
+    prepare-once, prepare-always, clean"
+}
+
+# arguments...
+if [ $# -ne 2 ];then
+	usage
+#	exit 1
+fi
+
+while [ $# -gt 0 ]; do
+	case "$1" in
+		prepare-once) prepare_once "$2"; shift ;;
+		prepare-always) prepare_always "$2"; shift ;;
+		clean) unset ENVIRONMENT_LAST; clean "$2"; shift ;;
+		*) usage ; exit 1 ;;
+	esac
+	shift
+done
+
+exit 0
diff --git a/environments/fill90-dvd b/environments/fill90-dvd
new file mode 100644
index 0000000..cc3286f
--- /dev/null
+++ b/environments/fill90-dvd
@@ -0,0 +1,115 @@
+#!/bin/bash
+# FS QA Environment setup
+# This environment fills the target device from 90 percents 
+# with dvd-sized files.
+#-----------------------------------------------------------------------
+# Copyright 2014 (C) Red Hat, Inc., Jan Tulak <jtulak@redhat.com>
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
+# arguments: prepare-once, prepare-always, clean
+
+
+THIS_ENVIRONMENT="$(basename $BASH_SOURCE)"
+
+files_prefix="env_dummy_"
+# maximum size of a file in kiB
+file_size=4194304 # 4 GiB
+
+# This function should prepare the environment
+prepare()
+{
+	target="$1"
+
+	available=$(df -P "$target"|tail -n1 |awk '{print $4}')
+	available=$(printf "%.0f" $(echo "$available*0.9"|bc )) # get 90 percent size
+
+	full_files=$((available / file_size)) # number of full-size files
+	last_file=$((available - (full_files * file_size) ))
+
+	for i in $(seq $full_files );do
+		f="$target/$files_prefix$i"
+		dd if=/dev/zero of="$f" count=$file_size bs=1024 &>/dev/null
+	done	
+
+	# last file to fill size smaller than $file_size
+	f="$target/$files_prefix""0"
+	dd if=/dev/zero of="$f" count=$last_file bs=1024 &>/dev/null
+}
+
+# This function should clean files created by prepare()
+clean()
+{
+	target="$1"
+	for f in $(ls "$target"|grep -E "^$files_prefix");do
+		rm "$target/$f"
+	done
+}
+
+
+
+
+# ----------------------------------------------------------------------
+# The following code usually don't need any changes for your environment
+# ----------------------------------------------------------------------
+
+prepare_once()
+{
+	target="$1"
+	# check if this environment is already created (was the last one
+	# running)
+	if [ "$env_last" != "$THIS_ENVIRONMENT" ];then
+		prepare "$target"
+	fi
+
+}
+
+prepare_always()
+{
+	target="$1"
+	# We still need to check the previous environment,
+	# because if it is the same as now, it wasn't cleaned yet!
+	if [ "$env_last" = "$THIS_ENVIRONMENT" ];then
+		clean "$target"
+	fi
+	prepare "$target"
+}
+
+usage()
+{
+echo "Usage: 
+$0 OPTION TARGET_DIR
+Where OPTION is one (and only one) of the following:
+    prepare-once, prepare-always, clean"
+}
+
+# arguments...
+if [ $# -ne 2 ];then
+	usage
+#	exit 1
+fi
+
+while [ $# -gt 0 ]; do
+	case "$1" in
+		prepare-once) prepare_once "$2"; shift ;;
+		prepare-always) prepare_always "$2"; shift ;;
+		clean) unset ENVIRONMENT_LAST; clean "$2"; shift ;;
+		*) usage ; exit 1 ;;
+	esac
+	shift
+done
+
+exit 0
-- 
1.9.3

