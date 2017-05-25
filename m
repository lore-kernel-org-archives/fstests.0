Received: from mail-pf0-f196.google.com ([209.85.192.196]:35438 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033459AbdEYT06 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 May 2017 15:26:58 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so41060257pfd.2
        for <fstests@vger.kernel.org>; Thu, 25 May 2017 12:26:57 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 1/7] get-all: use helper function to clone repositories
Date: Thu, 25 May 2017 12:25:43 -0700
Message-Id: <20170525192549.138518-2-ebiggers3@gmail.com>
In-Reply-To: <20170525192549.138518-1-ebiggers3@gmail.com>
References: <20170525192549.138518-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Add a function which handles cloning a repository and optionally
checking out a specific commit, then use it for all the repositories.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 get-all | 119 ++++++++++++++++++++++------------------------------------------
 1 file changed, 40 insertions(+), 79 deletions(-)

diff --git a/get-all b/get-all
index fc4dc2d..67a54b4 100755
--- a/get-all
+++ b/get-all
@@ -6,88 +6,49 @@ else
 	. config
 fi
 
-if test ! -d xfsprogs-dev
-then
-	if test -z "$XFSPROGS_GIT"; then
-		echo "XFSPROGS_GIT not set; check your config file!"
-		exit 1
-        fi
-	if ! git clone $XFSPROGS_GIT xfsprogs-dev; then
-		echo "Failed to get xfsprogs-dev from $XFSPROGS_GIT"
-                exit 1
-	fi
-	if test -n "$XFSPROGS_COMMIT"; then
-		cd xfsprogs-dev
-		git branch xfstests-bld $XFSPROGS_COMMIT
-		git checkout xfstests-bld
-		cd ..
-	fi
-fi
-if test ! -d xfstests-dev
-then
-	if test -z "$XFSTESTS_GIT"; then
-		echo "XFSTESTS_GIT not set; check your config file!"
-		exit 1
-        fi
-	if ! git clone $XFSTESTS_GIT xfstests-dev; then
-		echo "Failed to get xfstests-dev from $XFSTESTS_GIT"
-                exit 1
-	fi
-	if test -n "$XFSTESTS_COMMIT"; then
-		cd xfstests-dev
-		git branch xfstests-bld $XFSTESTS_COMMIT
-		git checkout xfstests-bld
-		cd ..
-	fi
-fi
-if test ! -d fio
-then
-	if test -z "$FIO_GIT"; then
-		echo "FIO_GIT not set; check your config file!"
-		exit 1
-        fi
-	if ! git clone $FIO_GIT fio; then
-		echo "Failed to get fio from $FIO_GIT"
-                exit 1
-	fi
-	if test -n "$FIO_COMMIT"; then
-		cd fio
-		git branch xfstests-bld $FIO_COMMIT
-		git checkout xfstests-bld
-		cd ..
-	fi
-fi
-if test ! -d quota
-then
-	if test -z "$QUOTA_GIT"; then
-		echo "QUOTA_GIT not set; check your config file!"
-		exit 1
-        fi
-	if ! git clone $QUOTA_GIT quota; then
-		echo "Failed to get quota from $QUOTA_GIT"
-                exit 1
-	fi
-	if test -n "$QUOTA_COMMIT"; then
-		cd quota
-		git branch xfstests-bld $QUOTA_COMMIT
-		git checkout xfstests-bld
-		cd ..
-	fi
-fi
+setup_repo()
+{
+    local repo_name="$1"
+    local repo_url_variable="$2"
+    local repo_url="${!2}"
+    local commit_variable="$3"
+    local commit="${!3}"
+    local required="$4"
 
-if test ! -d stress-ng -a -n "$STRESS_NG_GIT"
-then
-	if ! git clone $STRESS_NG_GIT stress-ng; then
-		echo "Failed to get stress-ng from $STRESS_NG_GIT"
-                exit 1
+    # Clone the repository if needed.
+    if [ ! -d "$repo_name" ]; then
+	if [ -z "$repo_url" ]; then
+	    if ! $required; then
+		return
+	    fi
+	    echo 1>&2 "$repo_url_variable not set; check your config file!"
+	    exit 1
 	fi
-	if test -n "$STRESS_NG_COMMIT"; then
-		cd stress-ng
-		git branch xfstests-bld $STRESS_NG_COMMIT
-		git checkout xfstests-bld
-		cd ..
+
+	echo
+	if ! git clone "$repo_url" "$repo_name"; then
+	    echo 1>&2 "Failed to clone $repo_name from $repo_url"
+	    exit 1
 	fi
-fi
+
+	# If a specific commit was specified, check it out.
+	if [ -n "$commit" ]; then
+	    ( cd "$repo_name";
+	      git branch xfstests-bld "$commit";
+	      git checkout xfstests-bld;
+	    )
+	fi
+    fi
+}
+
+# required repositories
+setup_repo fio			FIO_GIT		FIO_COMMIT		true
+setup_repo quota		QUOTA_GIT	QUOTA_COMMIT		true
+setup_repo xfsprogs-dev		XFSPROGS_GIT	XFSPROGS_COMMIT		true
+setup_repo xfstests-dev		XFSTESTS_GIT	XFSTESTS_COMMIT		true
+
+# optional repositories
+setup_repo stress-ng		STRESS_NG_GIT	STRESS_NG_COMMIT	false
 
 # Make sure acl doesn't try regenerate these files because of the
 # vagrancies of the timestamps when they were checked out
-- 
2.13.0.219.gdb65acc882-goog

