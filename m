Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F493911C9
	for <fstests@vger.kernel.org>; Tue, 12 May 2026 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592363; cv=none; b=kPtrqnHELMvScxCeQigNigVrNiK++2k0uQy45juQuHp5S9pJCZ3e5fh0nZ+43Y1OyK7a12XFWXUjQCNdGGeU36BNy/EZGcJJLDrVrp/cGwtOIfmuRpiHWwYlpfHAAVkHHTpwXPlp1+KzGtKMSNVNyr/D9rhx31blSLysrhqXezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592363; c=relaxed/simple;
	bh=MWSgXHvIM0YTVISw3f+YB8xbA2QHGVCrl2iKigi0npo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXr3cTDPa8h5FDDQtgfETS7W7HpUf6IiW3hs4HIgc0SVtFMNrRO8VPllwTdru0f9vls6PVMHtWy8vPmKcBLp4v6iVMaN/HuqQUMXmu53TYia2lAy2yzE9DTF4SpnWENOTt8m6rmVAO9N3kDNwBrZv9UlsHobnHE37VcLLfp79IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4OHKJ/O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4OHKJ/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8E6C2BCF5;
	Tue, 12 May 2026 13:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778592363;
	bh=MWSgXHvIM0YTVISw3f+YB8xbA2QHGVCrl2iKigi0npo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I4OHKJ/OQ53gEry3kGgHQqVkHMHKGRqNmOBQcHdsF7gLmpuFiQyzE8A0W9F1K45TD
	 C7ZK2QIvehyWZUauiDNrwTakdw2WrF51xX0lsUMBT0KXu/fkAdcKODg9ixXooKgVJv
	 bY6kntxPcrN0xzSTSlZqUOEA1T+OIsQCgPL2X+m4ltqdudUy8VJ/6/X9GYc7fYxahY
	 e/7YBaTYNswEysNs5Uw58BD9tvo0w9zJE0OnOMqUWSMAc7w9nYJiWYmBtvW/0GPD4U
	 wVKw3B8mC1krA6hTGywesCldRLFZehdXVe2HCA5LvGyaIr6T8hHltgLToX4Ze8HHt5
	 hCgnimxIkydBw==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
Subject: [RFC PATCH 2/4] check: update usage and README to reflect new argument parsing
Date: Tue, 12 May 2026 21:25:37 +0800
Message-ID: <20260512132539.931482-3-zlang@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512132539.931482-1-zlang@kernel.org>
References: <20260512132539.931482-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update usage() function, README.* files and some comments to match
the new argument parsing method.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 README         | 10 +++---
 README.overlay | 18 +++++------
 check          | 85 ++++++++++++++++++++++++++------------------------
 common/config  |  8 ++---
 common/rc      |  2 +-
 5 files changed, 63 insertions(+), 60 deletions(-)

diff --git a/README b/README
index e0cee43a..8644f163 100644
--- a/README
+++ b/README
@@ -386,7 +386,7 @@ Misc:
  - Set DIFF_LENGTH to "number of diff lines to print from a failed test",
    by default 10, set to 0 to print the full diff
  - set IDMAPPED_MOUNTS=true to run all tests on top of idmapped mounts. While
-   this option is supported for all filesystems currently only -overlay is
+   this option is supported for all filesystems currently only `--fs overlay` is
    expected to run without issues. For other filesystems additional patches
    and fixes to the test suite might be needed.
  - Set REPORT_VARS_FILE to a file containing colon-separated name-value pairs
@@ -417,10 +417,10 @@ Running tests:
     - To randomize test order: ./check -r [test(s)]
     - You can explicitly specify NFS/AFS/CIFS/OVERLAY, otherwise
       the filesystem type will be autodetected from $TEST_DEV:
-        - for running nfs tests: ./check -nfs [test(s)]
-        - for running afs tests: ./check -afs [test(s)]
-        - for running cifs/smb3 tests: ./check -cifs [test(s)]
-        - for overlay tests: ./check -overlay [test(s)]
+        - for running nfs tests: ./check --fs nfs [test(s)]
+        - for running afs tests: ./check --fs afs [test(s)]
+        - for running cifs/smb3 tests: ./check --fs cifs [test(s)]
+        - for overlay tests: ./check --fs overlay [test(s)]
           The TEST and SCRATCH partitions should be pre-formatted
           with another base fs, where the overlay dirs will be created
 
diff --git a/README.overlay b/README.overlay
index 3093bf8c..52bcd332 100644
--- a/README.overlay
+++ b/README.overlay
@@ -1,5 +1,5 @@
 To run xfstest on overlayfs, configure the variables of TEST and SCRATCH
-partitions to be used as the "base fs" and run './check -overlay'.
+partitions to be used as the "base fs" and run './check --fs overlay'.
 
 For example, the following config file can be used to run tests on
 xfs test/scratch partitions:
@@ -10,24 +10,24 @@ xfs test/scratch partitions:
  SCRATCH_MNT=/mnt/scratch
  FSTYP=xfs
 
-Using the same config file, but executing './check -overlay' will
+Using the same config file, but executing './check --fs overlay' will
 use the same partitions as base fs for overlayfs directories
 and set TEST_DIR/SCRATCH_MNT values to overlay mount points, i.e.:
 /mnt/test/ovl-mnt and /mnt/scratch/ovl-mnt, for the context of
 individual tests.
 
-'./check -overlay' does not support mkfs and fsck on the base fs, so
-the base fs should be pre-formatted before starting the -overlay run.
+'./check --fs overlay' does not support mkfs and fsck on the base fs, so
+the base fs should be pre-formatted before starting the --fs overlay run.
 An easy way to accomplish this is by running './check <some test>' once,
-before running './check -overlay'.
+before running './check --fs overlay'.
 
-'./check -overlay' support check overlay test and scratch dirs,
+'./check --fs overlay' support check overlay test and scratch dirs,
 OVERLAY_FSCK_OPTIONS should be set instead of FSCK_OPTIONS if fsck
 options need to given directly.
 
 Because of the lack of mkfs support, multi-section config files are only
-partly supported with './check -overlay'. Only multi-section files that
-do not change FSTYP and MKFS_OPTIONS can be safely used with -overlay.
+partly supported with './check --fs overlay'. Only multi-section files that
+do not change FSTYP and MKFS_OPTIONS can be safely used with --fs overlay.
 
 For example, the following multi-section config file can be used to
 run overlay tests on the same base fs, but with different mount options, and on
@@ -66,7 +66,7 @@ To enable running unionmount testsuite, clone the git repository from:
 under the xfstests src directory, or set the environment variable
 UNIONMOUNT_TESTSUITE to the local path where the repository was cloned.
 
-Run './check -overlay -g overlay/union' to execute all the unionmount testsuite
+Run './check --fs overlay -g overlay/union' to execute all the unionmount testsuite
 test cases.
 
 
diff --git a/check b/check
index 11bdf81b..5fe35e8e 100755
--- a/check
+++ b/check
@@ -56,43 +56,47 @@ export SRC_DIR="tests"
 
 usage()
 {
-    echo "Usage: $0 [options] [testlist]"'
-
-check options
-    -nfs		test NFS
-    -afs		test AFS
-    -glusterfs		test GlusterFS
-    -cifs		test CIFS
-    -9p			test 9p
-    -fuse		test fuse
-    -virtiofs		test virtiofs
-    -overlay		test overlay
-    -pvfs2		test PVFS2
-    -tmpfs		test TMPFS
-    -ubifs		test ubifs
-    -l			line mode diff
-    -udiff		show unified diff (default)
-    -n			show me, do not run tests
-    -T			output timestamps
-    -r			randomize test order
-    --exact-order	run tests in the exact order specified
-    -i <n>		iterate the test list <n> times
-    -I <n>		iterate the test list <n> times, but stops iterating further in case of any test failure
-    -d			dump test output to stdout
-    -b			brief test summary
-    -R fmt[,fmt]	generate report in formats specified. Supported formats: xunit, xunit-quiet
-    --large-fs		optimise scratch device for large filesystems
-    -s section		run only specified section from config file
-    -S section		exclude the specified section from the config file
-    -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
-
-testlist options
-    -g group[,group...]	include tests from these groups
-    -x group[,group...]	exclude tests from these groups
-    -X exclude_file	exclude individual tests
-    -e testlist         exclude a specific list of tests
-    -E external_file	exclude individual tests
-    [testlist]		include tests matching names in testlist
+	echo "Usage: $0 [options] [testlist]"'
+
+General options:
+    -b                      brief test summary
+    -d                      dump test output to stdout
+    -h, --help              show this help message
+    -i <n>                  iterate the test list <n> times
+    -I <n>                  iterate the test list <n> times, but stops
+                              iterating further in case of any test failure
+    -l                      line mode diff
+    -L <n>                  loop tests <n> times following a failure, measuring
+                              aggregate pass/fail metrics
+    -n                      show me, do not run tests
+    -r                      randomize test order
+    -s section              run only specified section from config file
+    -S section              exclude the specified section from the config file
+    -T                      output timestamps
+    -R fmt[,fmt]            generate report in formats specified. Supported
+                              formats: xunit, xunit-quiet
+    --exact-order           run tests in the exact order specified
+    --extra-space <size>    require minimum free space on scratch device
+    --fs <type>             test the given FSTYP; valid types include:
+                              nfs, afs, glusterfs, cifs, 9p, fuse, virtiofs,
+                              overlay, pvfs2, tmpfs, ubifs
+    --large-fs              optimise scratch device for large filesystems
+    --udiff                 show unified diff (default)
+
+Test selection options:
+    -e testlist             exclude a specific list of tests
+    -E external_file        exclude tests listed in the given file
+    -g group[,group...]     include tests from these groups
+    -x group[,group...]     exclude tests from these groups
+    -X exclude_file         exclude individual tests
+    [testlist]              include tests matching names in testlist
+
+Backward-compatible options:
+    For compatibility, old options are still accepted (but deprecated):
+    --fs <nfs|afs|glusterfs|...> is equivalent to:
+        -nfs, -afs, -glusterfs, -cifs, -9p, -fuse, -virtiofs, -overlay,
+        -pvfs2, -tmpfs, -ubifs
+    -udiff is equivalent to --udiff.
 
 testlist argument is a list of tests in the form of <test dir>/<test name>.
 
@@ -109,7 +113,7 @@ If you want to run all the tests in the test suite, use "-g all" to specify all
 groups.
 
 exclude_file argument refers to a name of a file inside each test directory.
-for every test dir where this file is found, the listed test names are
+For every test dir where this file is found, the listed test names are
 excluded from the list of tests to run from that test dir.
 
 external_file argument is a path to a single file containing a list of tests
@@ -117,15 +121,14 @@ to exclude in the form of <test dir>/<test name>.
 
 examples:
  check xfs/001
- check -g quick
+ check --fs overlay -g quick
  check -g xfs/quick
  check -x stress xfs/*
  check -X .exclude -g auto
  check -E ~/.xfstests.exclude
 '
-	    _fatal
+	_fatal
 }
-
 get_sub_group_list()
 {
 	local d=$1
diff --git a/common/config b/common/config
index d5299d5b..69e5d833 100644
--- a/common/config
+++ b/common/config
@@ -692,7 +692,7 @@ _canonicalize_devices()
 	fi
 }
 
-# On check -overlay, for the non multi section config case, this
+# On check --fs overlay, for the non multi section config case, this
 # function is called on every test, before init_rc().
 # When SCRATCH/TEST_* vars are defined in config file, config file
 # is sourced on every test and this function overrides the vars
@@ -714,7 +714,7 @@ _overlay_config_override()
 	[ ! -d "$TEST_DEV" ] || export OVL_BASE_TEST_DIR="$TEST_DEV"
 	[ ! -d "$SCRATCH_DEV" ] || export OVL_BASE_SCRATCH_MNT="$SCRATCH_DEV"
 
-	# Config file may specify base fs type, but we obay -overlay flag
+	# Config file may specify base fs type, but we obay --fs overlay flag
 	[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
 	export FSTYP=overlay
 
@@ -895,7 +895,7 @@ get_next_config() {
 		_check_device SCRATCH_LOGDEV optional $SCRATCH_LOGDEV
 	fi
 
-	# Override FSTYP from config when running ./check -overlay
+	# Override FSTYP from config when running ./check --fs overlay
 	# and maybe override base fs TEST/SCRATCH_DEV with overlay base dirs.
 	# We need to do this *after* default mount options are set by base FSTYP
 	# and *after* SCRATCH_DEV is deduced from SCRATCH_DEV_POOL
@@ -930,7 +930,7 @@ else
 	export TEST_DIR=`_canonicalize_mountpoint TEST_DIR $TEST_DIR`
 	export SCRATCH_MNT=`_canonicalize_mountpoint SCRATCH_MNT $SCRATCH_MNT`
 
-	# Override FSTYP from config when running ./check -overlay
+	# Override FSTYP from config when running ./check --fs overlay
 	# and maybe override base fs TEST/SCRATCH_DEV with overlay base dirs
 	if [ "$OVERLAY" == "true" -o "$FSTYP" == "overlay" ]; then
 		_overlay_config_override
diff --git a/common/rc b/common/rc
index 26db5bbd..39d24ef0 100644
--- a/common/rc
+++ b/common/rc
@@ -4340,7 +4340,7 @@ _has_metadata_journaling()
 		;;
 	overlay)
 		# metadata journaling check is based on base filesystem configurations
-		# and  because -overlay option saves those configurations to OVL_BASE_*,
+		# and  because --fs overlay option saves those configurations to OVL_BASE_*,
 		# adding restore/override the configurations before/after the check.
 		if [ ! -z $OVL_BASE_FSTYP -a $OVL_BASE_FSTYP != "overlay" ]; then
 			local ret
-- 
2.54.0

