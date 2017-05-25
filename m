Received: from mail-pf0-f194.google.com ([209.85.192.194]:34275 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036608AbdEYT1D (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 May 2017 15:27:03 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so41051385pfk.1
        for <fstests@vger.kernel.org>; Thu, 25 May 2017 12:27:02 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 3/7] get-all: fail if optional repositories have been deconfigured
Date: Thu, 25 May 2017 12:25:45 -0700
Message-Id: <20170525192549.138518-4-ebiggers3@gmail.com>
In-Reply-To: <20170525192549.138518-1-ebiggers3@gmail.com>
References: <20170525192549.138518-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

If an optional repository is enabled and then later disabled, require
that the corresponding directory manually be removed; otherwise, it
would still be included in the build.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 get-all | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/get-all b/get-all
index a0f0d05..fa27229 100755
--- a/get-all
+++ b/get-all
@@ -81,6 +81,15 @@ setup_repo()
 	fi
     fi
 
+    if [ -z "$repo_url" ] && ! $required; then
+	cat 1>&2 <<EOF
+ERROR: $repo_url_variable has been removed from the config file,
+but the $repo_name directory still exists.  Remove it if you don't
+want it to be built.
+EOF
+	exit 1
+    fi
+
     # If a specific commit was specified, check it out.
     if [ -n "$commit" ]; then
 	( cd "$repo_name";
-- 
2.13.0.219.gdb65acc882-goog

