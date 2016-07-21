Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:37138 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753133AbcGUCGq (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Jul 2016 22:06:46 -0400
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH] btrfs: Update quick and auto tag for btrfs group
Date: Thu, 21 Jul 2016 10:06:07 +0800
Message-Id: <20160721020607.28258-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Update the following quick/auto tag based on their execution time
007
011
050
100
101

Two systems are used to determine their execution time.
One is backed by an SATA spinning rust, whose maximum R/W speed is
about 100MB/s, modern desktop performance. (VM1)

Another one is a VM inside a openstack pool, with stronger CPU and
memory performance along with high latency storage.
Maximum R/W speed is around 150MB/s, latency is much higher than normal
HDD though. (VM2)

The 'quick' standard is a little more restrict, only when both systems
pass the test within 30s(+/- 10%), while 'auto' is less restrict, any
system can pass within 5min(+/- 10%) will still stay in 'auto' group.

Other test cases don't fit both standards on both systems will not be
modified.

Execution time result: (Unit: seconds)
------------------------------------------------------
Test case No. | VM1        | VM2      | Modification |
------------------------------------------------------
007           | 4          | 2        | +quick       |
011           | 669        | 1748     | -auto        |
050           | 4          | 13       | +quick       |
100           | 57         | 151      | -quick       |
101           | 45         | 59       | -quick       |
------------------------------------------------------

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 tests/btrfs/group | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/btrfs/group b/tests/btrfs/group
index a21a80a..b4f1334 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -9,11 +9,11 @@
 004 auto rw metadata
 005 auto defrag
 006 auto quick
-007 auto rw metadata send
+007 auto quick rw metadata send
 008 auto quick send
 009 auto quick subvol
 010 auto quick defrag
-011 auto replace
+011 replace
 012 auto convert
 013 auto quick balance
 014 auto balance
@@ -52,7 +52,7 @@
 047 auto quick send
 048 auto quick
 049 auto quick
-050 auto send
+050 auto quick send
 051 auto quick send
 052 auto quick clone
 053 auto quick send
@@ -102,8 +102,8 @@
 097 auto quick send clone
 098 auto quick metadata clone
 099 auto quick qgroup
-100 auto quick replace
-101 auto quick replace
+100 auto replace
+101 auto replace
 102 auto quick metadata enospc
 103 auto quick clone compress
 104 auto qgroup
-- 
2.9.0



