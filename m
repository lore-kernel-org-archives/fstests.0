Received: from mail-pf0-f194.google.com ([209.85.192.194]:41944 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbeDKXrn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Apr 2018 19:47:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id a2so2017839pff.8
        for <fstests@vger.kernel.org>; Wed, 11 Apr 2018 16:47:43 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 2/2] generic/427: used mixed mode for Btrfs
Date: Wed, 11 Apr 2018 16:47:30 -0700
Message-Id: <5273be80b04afae67e5ff2137e713924c7bfc0ff.1523490276.git.osandov@fb.com>
In-Reply-To: <d928f86c748db034ca4efd849e01c5c2bf805199.1523490276.git.osandov@fb.com>
References: <d928f86c748db034ca4efd849e01c5c2bf805199.1523490276.git.osandov@fb.com>
In-Reply-To: <d928f86c748db034ca4efd849e01c5c2bf805199.1523490276.git.osandov@fb.com>
References: <d928f86c748db034ca4efd849e01c5c2bf805199.1523490276.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

This test creates a 256 MB filesystem and then writes a 200 MB file.
With separate data and metadata, Btrfs will run out of data space since
it needs to allocate some metadata space. Use mixed mode, which is the
recommendation for smaller filesystems.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/generic/427 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/generic/427 b/tests/generic/427
index 9cde5f50..b2cb4526 100755
--- a/tests/generic/427
+++ b/tests/generic/427
@@ -55,6 +55,8 @@ _require_test_program "feature"
 _require_aiodio aio-dio-eof-race
 
 # limit the filesystem size, to save the time of filling filesystem
+# Btrfs needs to use mixed mode for such a small filesystem
+[ "$FSTYP" = "btrfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -M"
 _scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
 
-- 
2.17.0

