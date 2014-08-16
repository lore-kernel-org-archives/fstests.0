Return-Path: <fstests-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.232.25]:46083 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbaHPNNc (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 16 Aug 2014 09:13:32 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 2/6] common: _scratch_mkfs_sized should inherent default block size from test_dev
Date: Sat, 16 Aug 2014 17:13:07 +0400
Message-Id: <1408194791-1797-2-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
References: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

Currently default block size is frozen to 4096 which is bad for
various reasons for example:
1) It ignores MKFS_OPT
2) Not works for architectures where PG_SIZE != 4096

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 common/rc |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/common/rc b/common/rc
index 84fef35..d149d1c 100644
--- a/common/rc
+++ b/common/rc
@@ -582,7 +582,7 @@ _scratch_mkfs_sized()
 {
     fssize=$1
     blocksize=$2
-    [ -z "$blocksize" ] && blocksize=4096
+    [ -z "$blocksize" ] && blocksize=`blockdev --getbsz $TEST_DEV`
 
     re='^[0-9]+$'
     if ! [[ $fssize =~ $re ]] ; then
-- 
1.7.1

