Received: from mail-pf0-f194.google.com ([209.85.192.194]:33358 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdEFAVS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 May 2017 20:21:18 -0400
Received: by mail-pf0-f194.google.com with SMTP id b23so2407077pfc.0
        for <fstests@vger.kernel.org>; Fri, 05 May 2017 17:21:18 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 2/2] common/config: implement set_prog_path() using 'type -P'
Date: Fri,  5 May 2017 17:19:33 -0700
Message-Id: <20170506001933.49582-2-ebiggers3@gmail.com>
In-Reply-To: <20170506001933.49582-1-ebiggers3@gmail.com>
References: <20170506001933.49582-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Bash's 'type -P' builtin is equivalent to 'which', but it's more
efficient because it doesn't involve executing an external binary.
Because set_prog_path() is executed 60+ times in common/config, which is
sourced by common/rc, which in turn is sourced by every test, switching
to 'type -P' actually can make a noticeable performance improvement for
short-running or skipped tests.  For example:

Before:
    # time ./check generic/002
    ...
    Passed all 1 tests

    real    0m1.365s
    user    0m0.746s
    sys     0m0.644s

After:
    # time ./check generic/002
    ...
    Passed all 1 tests

    real    0m1.026s
    user    0m0.511s
    sys     0m0.470s

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/config | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/common/config b/common/config
index b29c0eb0..8211356c 100644
--- a/common/config
+++ b/common/config
@@ -96,12 +96,7 @@ export RECREATE_TEST_DEV=false
 # $1 = prog to look for
 set_prog_path()
 {
-    p=`which $1 2> /dev/null`
-    if [ -n "$p" -a -x "$p" ]; then
-        echo $p
-        return 0
-    fi
-    return 1
+	type -P $1
 }
 
 # Handle mkfs.btrfs which does (or does not) require -f to overwrite
-- 
2.13.0.rc1.294.g07d810a77f-goog

