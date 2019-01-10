Received: from mx2.suse.de ([195.135.220.15]:59786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfAJGO2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 10 Jan 2019 01:14:28 -0500
From: Qu Wenruo <wqu@suse.com>
Subject: [PATCH 1/2] fstests: btrfs: Make seed device test cases into their own group
Date: Thu, 10 Jan 2019 14:14:14 +0800
Message-Id: <20190110061415.32045-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

btrfs/16[123] are all seed device related test cases, make them into
'seed' group.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/group | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/group b/tests/btrfs/group
index b78ed37fd9f1..04c0254aa4bf 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -163,9 +163,9 @@
 158 auto quick raid scrub
 159 auto quick punch log
 160 auto quick
-161 auto quick volume
-162 auto quick volume
-163 auto quick volume
+161 auto quick volume seed
+162 auto quick volume seed
+163 auto quick volume seed
 164 auto quick volume
 165 auto quick subvol
 166 auto quick qgroup
-- 
2.20.1
