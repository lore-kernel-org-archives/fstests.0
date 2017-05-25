Received: from mail-pf0-f195.google.com ([209.85.192.195]:36615 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036547AbdEYT1A (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 May 2017 15:27:00 -0400
Received: by mail-pf0-f195.google.com with SMTP id n23so41012597pfb.3
        for <fstests@vger.kernel.org>; Thu, 25 May 2017 12:26:59 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 2/7] get-all: check out correct commits in already-cloned repositories
Date: Thu, 25 May 2017 12:25:44 -0700
Message-Id: <20170525192549.138518-3-ebiggers3@gmail.com>
In-Reply-To: <20170525192549.138518-1-ebiggers3@gmail.com>
References: <20170525192549.138518-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Update the get-all script to check out the requested commit in each git
repository, even if the repository has already been cloned.  Previously,
the repositories would become outdated if the config file was changed.

It was also possible for local changes (even uncommitted changes) to be
included in the build --- maybe intentionally, maybe unintentionally.
But there is a clear way to express the difference now: just comment out
${REPO_NAME}_COMMIT in config.custom if it's desired to manage a
repository manually and do the builds from whatever happens to be in the
working tree rather than from a specific commit.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/building-xfstests.md | 32 +++++++++++---------
 get-all                            | 62 +++++++++++++++++++++++++++++++++-----
 2 files changed, 72 insertions(+), 22 deletions(-)

diff --git a/Documentation/building-xfstests.md b/Documentation/building-xfstests.md
index 3697838..4ec3042 100644
--- a/Documentation/building-xfstests.md
+++ b/Documentation/building-xfstests.md
@@ -14,21 +14,23 @@ The xfstests-bld package depends on a number of external git trees:
 * fio
 * quota
 
-The location of these files are specified in the top-level config
-file, but you can copy the config file to config.custom and then make
-changes if desired.
-
-The first time you run "make", the scripts will automatically fetch
-these git trees from the locations specified in the top-level config
-file.  You can also manually run the "get-all" script which will
-actually do the dirty deed.
-
-There may be updates in some or any of these git trees for these
-subcomponents.  You can use "git pull" or "git fetch" as necessary to
-update them.  (Please take care before updating the fio repository;
-some updates to the fio tree have caused test regressions in the past,
-so it may be preferable to let things be as far as the fio repo is
-concerned.)
+The first time you run "make", the build system will clone these
+repositories by running ./get-all.  Their remote URLs are set in the
+top-level "config" file.  If you wish to make changes, copy "config"
+to "config.custom" and make changes there.
+
+The config file can also specify the commit to use for each
+repository.  If a commit is specified, the build system will check it
+out after cloning the repository.  The commit will also be checked out
+each time a new build is done, in case the config file was changed to
+specify a different commit.  Note that this will override any local
+changes.  If, on the other hand, no commit is specified, then the
+repository will simply start out at the latest "master", and you will
+be free to make local changes or update it with "git pull" as desired.
+
+(Please take care before updating the fio repository; some updates to
+the fio tree have caused test regressions in the past, so it may be
+preferable to let things be as far as the fio repo is concerned.)
 
 ## Installing the necessary packages to build xfstests
 
diff --git a/get-all b/get-all
index 67a54b4..a0f0d05 100755
--- a/get-all
+++ b/get-all
@@ -6,6 +6,55 @@ else
 	. config
 fi
 
+have_commit()
+{
+    git rev-parse --verify --quiet "$1^{commit}" >/dev/null
+}
+
+checkout_commit()
+{
+    local repo_name="$1"
+    local repo_url="$2"
+    local commit_variable="$3"
+    local commit="${!3}"
+    local old_url
+
+    # Make sure there are no uncommitted changes.
+    if ! git diff-index --quiet HEAD --; then
+	cat 1>&2 <<EOF
+ERROR: $repo_name has uncommitted changes.
+
+If you want to build from the (dirty) working tree of $repo_name,
+remove $commit_variable from config.custom.
+EOF
+	exit 1
+    fi
+
+    # If we don't have the needed commit, try fetching from the remote.
+    if ! have_commit "$commit"; then
+	old_url="$(git remote get-url origin)"
+	if [ "$old_url" != "$repo_url" ]; then
+	    echo "$repo_name URL changed to $repo_url (previously was $old_url)"
+	    git remote set-url origin "$repo_url"
+	fi
+	if ! git fetch origin; then
+	    echo 1>&2 "ERROR: unable to fetch from $repo_url"
+	    exit 1
+	fi
+	if ! have_commit "$commit"; then
+	    echo 1>&2 "ERROR: commit $commit does not exist in $repo_url"
+	    exit 1
+	fi
+    fi
+
+    # Check out the commit.
+    if [ "$(git rev-parse HEAD)" != "$(git rev-parse "$commit^{commit}")" ]
+    then
+	echo "Checking out $repo_name $commit (previously was $(git describe --always HEAD))"
+    fi
+    git checkout --quiet "$commit"
+}
+
 setup_repo()
 {
     local repo_name="$1"
@@ -30,14 +79,13 @@ setup_repo()
 	    echo 1>&2 "Failed to clone $repo_name from $repo_url"
 	    exit 1
 	fi
+    fi
 
-	# If a specific commit was specified, check it out.
-	if [ -n "$commit" ]; then
-	    ( cd "$repo_name";
-	      git branch xfstests-bld "$commit";
-	      git checkout xfstests-bld;
-	    )
-	fi
+    # If a specific commit was specified, check it out.
+    if [ -n "$commit" ]; then
+	( cd "$repo_name";
+	  checkout_commit "$repo_name" "$repo_url" "$commit_variable";
+	)
     fi
 }
 
-- 
2.13.0.219.gdb65acc882-goog

