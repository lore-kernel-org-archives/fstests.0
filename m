Received: from mail-pf0-f179.google.com ([209.85.192.179]:36837 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752445AbcKPBlm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Nov 2016 20:41:42 -0500
Received: by mail-pf0-f179.google.com with SMTP id 189so39354507pfz.3
        for <fstests@vger.kernel.org>; Tue, 15 Nov 2016 17:41:42 -0800 (PST)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH] kvm-xfstests, gce-xfstests: correct file permissions with --update-files
Date: Tue, 15 Nov 2016 17:40:56 -0800
Message-Id: <1479260456-6723-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

The xfstests-bld repository may have been cloned with a umask that
masked out the other bits.  When using --update-files in this situation,
the VM ended up in a state where non-root users were unable to execute
anything, which made all tests using the fsgqa user get skipped.  Fix
this by copying the r and x group bits to the other bits when creating
files.tar.gz.  Also set the owner and group to root while we're at it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/gce-xfstests | 3 ++-
 kvm-xfstests/kvm-xfstests | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kvm-xfstests/gce-xfstests b/kvm-xfstests/gce-xfstests
index 04eee78..8839ea2 100755
--- a/kvm-xfstests/gce-xfstests
+++ b/kvm-xfstests/gce-xfstests
@@ -471,7 +471,8 @@ then
 	exit 1
     fi
     (cd "$DIR/test-appliance"; \
-     tar -X gce-exclude-files --exclude=etc -C files -cf - . | \
+     tar -X gce-exclude-files --exclude=etc -C files \
+		--owner=root --group=root --mode=o+g-w -cf - . | \
 	 gzip -9n > $LOCAL_FILES)
     get_local_hash "$LOCAL_FILES"
     get_remote_hash "$GS_FILES"
diff --git a/kvm-xfstests/kvm-xfstests b/kvm-xfstests/kvm-xfstests
index fbdae7a..bcada9e 100755
--- a/kvm-xfstests/kvm-xfstests
+++ b/kvm-xfstests/kvm-xfstests
@@ -75,7 +75,8 @@ then
 	exit 1
     fi
     (cd "$DIR/test-appliance"; \
-     tar -X kvm-exclude-files -C files -cf - . | \
+     tar -X kvm-exclude-files -C files \
+		--owner=root --group=root --mode=o+g-w -cf - . | \
 	 gzip -9n > "$TDIR/files.tar.gz")
     tar -r -f $VDH -C "$TDIR" files.tar.gz
     rm -rf "$TDIR"
-- 
2.8.0.rc3.226.g39d4020

