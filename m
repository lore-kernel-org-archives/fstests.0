Received: from mail.kernel.org ([198.145.29.99]:44638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbeJ0R24 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 27 Oct 2018 13:28:56 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D2B32075D
        for <fstests@vger.kernel.org>; Sat, 27 Oct 2018 08:48:42 +0000 (UTC)
From: fdmanana@kernel.org
Subject: [PATCH 1/2] btrfs: fix classification of a couple btrfs tests
Date: Sat, 27 Oct 2018 09:48:38 +0100
Message-Id: <20181027084838.1903-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test btrfs/108 does not test collapse, in fact btrfs does not even support
the fallocate collapse operation, so remove it.
Test btrfs/159 does not test collapse either, it tests hole punching, so
replace the collapse group with the punch group.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/group | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/group b/tests/btrfs/group
index 45782565..3ea84b1c 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -110,7 +110,7 @@
 105 auto quick send
 106 auto quick clone compress
 107 auto quick prealloc
-108 auto quick send clone punch collapse
+108 auto quick send clone punch
 109 auto quick send clone compress
 110 auto quick send
 111 auto quick send
@@ -161,7 +161,7 @@
 156 auto quick trim
 157 auto quick raid
 158 auto quick raid scrub
-159 auto quick collapse
+159 auto quick punch
 160 auto quick
 161 auto quick volume
 162 auto quick volume
-- 
2.11.0
