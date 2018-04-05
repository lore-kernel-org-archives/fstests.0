Received: from mail-pl0-f67.google.com ([209.85.160.67]:37079 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeDEVWE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Apr 2018 17:22:04 -0400
Received: by mail-pl0-f67.google.com with SMTP id v5-v6so19086702plo.4
        for <fstests@vger.kernel.org>; Thu, 05 Apr 2018 14:22:04 -0700 (PDT)
From: Eric Biggers <ebiggers@google.com>
Subject: [xfstests-bld PATCH] util/get-config: stop sourcing deprecated config files
Date: Thu,  5 Apr 2018 14:20:10 -0700
Message-Id: <20180405212010.132258-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Stop sourcing configs from the deprecated locations $KVM_CONFIG or
kvm-xfstests/config.custom, in preference to the locations in
~/.config/.  kvm-xfstests and gce-xfstests have been warning when
sourcing from the deprecated locations for almost a year now, so it's
unlikely that anyone is using them anymore.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/util/get-config | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/kvm-xfstests/util/get-config b/kvm-xfstests/util/get-config
index 4baf494..894bf3b 100644
--- a/kvm-xfstests/util/get-config
+++ b/kvm-xfstests/util/get-config
@@ -48,21 +48,6 @@ then
 	rm "$tmpfile"
 	unset tmpfile
 fi
-
 if test -n "$GCE_ACCOUNT" -a -f "$DIR/config-$GCE_ACCOUNT" ; then
     . "$DIR/config-$GCE_ACCOUNT"
-elif test -f $DIR/config.custom ; then
-# Else, source kvm-xfstests/config.custom if present (deprecated)
-    echo -e 1>&2 "Warning: use of kvm-xfstests/config.custom is deprecated." \
-	    "Move your settings\n         into ~/.config/kvm-xfstests," \
-	    "~/.config/gce-xfstests,\n         ~/.config/android-xfstests," \
-	    "and/or ~/.config/xfstests-common"
-    . $DIR/config.custom
-fi
-
-# Source $KVM_CONFIG if present (deprecated)
-if test -n "$KVM_CONFIG" -a -f "$KVM_CONFIG"; then
-    echo -e 1>&2 "Warning: use of \$KVM_CONFIG is deprecated." \
-	    "Move your settings into\n         ~/.config/kvm-xfstests"
-    . $KVM_CONFIG
 fi
-- 
2.17.0.484.g0c8726318c-goog

