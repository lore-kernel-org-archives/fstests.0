Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CD3C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 17:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbiETRTG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 May 2022 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352107AbiETRTG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 May 2022 13:19:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D407818629B
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 10:19:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 0E8951F41DCF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653067141;
        bh=Hl37aXpBO8PwUuxZNqvpbAJzF7yWT2P1oqDr0H/W0sU=;
        h=From:To:Cc:Subject:Date:From;
        b=d7hzaeOo0BpaoqyOunRBLhhBWhoyb23Y4a60yB8hioffGGWRyQPHyQ1ZUr0VexYUU
         Y5aWvUaf3zzS8ENdSpVHMeV7X+wkl7RcNLDuIKuslio/cQWxoqkK4PZ+veLHbpP0qn
         3Vv/QuWK3AqNeBXFg1dsvOQe3n0AmoYjUjoZqj3F2TkUUTBgjttiiIV0Kg9MlKAOG5
         0LIPiXGGgSeeTKE0co4TazJ+Z7GXj3r62OTIqsCgEvVMXvNzpZ6xK3XmDCJ+F2HY1V
         xixnUU+cu2so4F4mvCfaeANYIdy2GK39qMOS3cBsqW5buIIoLfVLAVvNSYMsYskSIn
         cG8wXLSh4LMkg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     zlang@redhat.com
Cc:     fstests@vger.kernel.org, ebiggers@kernel.org, djwong@kernel.org,
        tytso@mit.edu, Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v3] generic/556: Filter touch error message
Date:   Fri, 20 May 2022 13:18:52 -0400
Message-Id: <20220520171852.33924-1-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Coreutils commit d435cfc0bc55 ("touch: fix wrong
diagnostic (Bug#48106)"), released in coreutils v9.0, changed the error
reported by the tool when openat() fails with EINVAL.  Instead of
reporting a generic message for the failure of either openat() or the
following utimensat(), it now differentiates both failures with
different messages.

This change breaks generic/556, which relied on the parsing of that
message.  This test was originally developed by me on a Debian
Buster (coreutils v8.x), so I used the generic error message.  Now that
I tried to run it on a more modern distro, it reports a different error
message, which fails the test, as shown below:

  output mismatch (see /tmp/results/generic/556.out.bad)
      --- tests/generic/556.out	2022-05-20 13:15:00.447525770 -0400
      +++ /tmp/results/generic/556.out.bad	2022-05-20 13:15:24.988167427 -0400
      @@ -12,5 +12,5 @@
       # file: SCRATCH_MNT/xattrs/x/f1
       user.foo="bar"

      -touch: setting times of 'SCRATCH_MNT/strict/corac'$'\314\247\303': Invalid argument
      -touch: setting times of 'SCRATCH_MNT/strict/cora'$'\303\247\303': Invalid argument
      +touch: cannot touch 'SCRATCH_MNT/strict/corac'$'\314\247\303': Invalid argument
      +touch: cannot touch 'SCRATCH_MNT/strict/cora'$'\303\247\303': Invalid argument
      ...

The fix filters out the touch-specific parts of the touch error
messages, to prevent breakage from future changes, but preserves the
return code information, which is actually useful (and more stable).

There is no change in behavior on the kernel side, just a broken test.
On both older and new distros, the kernel correctly rejects this invalid
sequence with -EINVAL, as shown in the strace hunk below:

  [...]
  openat(AT_FDCWD, "/scratch_mnt/strict/corac\314\247\303", ...) = -1 EINVAL
  utimensat(AT_FDCWD, "/scratch_mnt/strict/corac\314\247\303", ...) = -1 EINVAL
  [...]

Tested on Debian sid (coreutils v8.32) and Fedora (coreutils 9.0).

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Add failed test output
Changes since v1:
  - Dont break on older distros
---
 common/filter         | 8 ++++++++
 tests/generic/556     | 9 +++++++--
 tests/generic/556.out | 4 ++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/common/filter b/common/filter
index 5b20e848c9b9..a6a42b7a6ad2 100644
--- a/common/filter
+++ b/common/filter
@@ -478,6 +478,14 @@ _filter_stat()
 	sed -e "s/\<cannot stat\>/cannot statx/"
 }
 
+# touch v9.0+ modified part of the message printed on error.  Filter the
+# generic part out, but preserve the strerror() part, which is
+# actually useful for debugging and usually stable.
+_filter_touch()
+{
+	sed -e "s/.* '\(.*\)':\(.*\)/touch: '\1':\2/"
+}
+
 _filter_lostfound()
 {
 	sed -e '/^lost+found$/d'
diff --git a/tests/generic/556 b/tests/generic/556
index 7ef2f6f4106b..1296e241552c 100755
--- a/tests/generic/556
+++ b/tests/generic/556
@@ -44,6 +44,11 @@ jp_file2=$(echo -e "japanese_\xe3\x82\xb1\xe3\x82\x99.txt")
 blob_file1=$(echo -e "corac\xcc\xa7\xc3")
 blob_file2=$(echo -e "coraç\xc3")
 
+filter_touch()
+{
+    _filter_touch | _filter_scratch
+}
+
 # Test helpers
 basic_create_lookup()
 {
@@ -456,8 +461,8 @@ test_strict_mode_invalid_filename()
 
 	# These creation commands should fail, since we are on strict
 	# mode.
-	touch "${basedir}/${blob_file1}" 2>&1 | _filter_scratch
-	touch "${basedir}/${blob_file2}" 2>&1 | _filter_scratch
+	touch "${basedir}/${blob_file1}" 2>&1 | filter_touch
+	touch "${basedir}/${blob_file2}" 2>&1 | filter_touch
 }
 
 #############
diff --git a/tests/generic/556.out b/tests/generic/556.out
index f9dd9542fb12..a689a3e2311c 100644
--- a/tests/generic/556.out
+++ b/tests/generic/556.out
@@ -12,5 +12,5 @@ user.foo="bar"
 # file: SCRATCH_MNT/xattrs/x/f1
 user.foo="bar"
 
-touch: setting times of 'SCRATCH_MNT/strict/corac'$'\314\247\303': Invalid argument
-touch: setting times of 'SCRATCH_MNT/strict/cora'$'\303\247\303': Invalid argument
+touch: 'SCRATCH_MNT/strict/corac'$'\314\247\303': Invalid argument
+touch: 'SCRATCH_MNT/strict/cora'$'\303\247\303': Invalid argument
-- 
2.36.1

