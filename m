Received: from mail-pg0-f67.google.com ([74.125.83.67]:33601 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbdB1Uz1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Feb 2017 15:55:27 -0500
Received: by mail-pg0-f67.google.com with SMTP id x17so2923260pgi.0
        for <fstests@vger.kernel.org>; Tue, 28 Feb 2017 12:54:05 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] [xfstests-bld] test-appliance: yet another file permissions fix
Date: Tue, 28 Feb 2017 12:46:43 -0800
Message-Id: <20170228204643.37016-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Several directories in the kvm-xfstests appliance were still not being
given the correct file permissions, since they were rsync'ed directly
into the mounted root filesystem with the '-a' option.  Unfortunately it
seems we can't express "go+u-w" with rsync options (it's not accepted by
--chmod), but we can copy the files through 'tar' instead, similar to
what is done elsewhere.

(I didn't notice this earlier because it is kvm-xfstests specific, and
it only broke a couple tests such as generic/128.)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/gen-image | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kvm-xfstests/test-appliance/gen-image b/kvm-xfstests/test-appliance/gen-image
index 67f8c6b..dbd9b84 100755
--- a/kvm-xfstests/test-appliance/gen-image
+++ b/kvm-xfstests/test-appliance/gen-image
@@ -111,7 +111,8 @@ fi
 update_xfstests()
 {
    tar -C $ROOTDIR/root -xf ../../xfstests.tar.gz
-   rsync --exclude-from kvm-exclude-files -avH files/* $ROOTDIR
+   tar -X kvm-exclude-files -C files \
+	--owner=root --group=root --mode=go+u-w -c . | tar -C $ROOTDIR -x
    rsync -avH ../../xfstests/git-versions $ROOTDIR/root/xfstests
    chown -R root:root $ROOTDIR/root
    chmod -R go+u-w $ROOTDIR/root
-- 
2.11.0.483.g087da7b7c-goog

