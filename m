Received: from userp2120.oracle.com ([156.151.31.85]:49286 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754449AbeE2Fxf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 May 2018 01:53:35 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] fstests: introduce btrfs/volume group
Date: Tue, 29 May 2018 13:56:12 +0800
Message-Id: <20180529055612.24576-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The btrfs/volume group represent a set of btrfs test-cases, which
shall intend to verify the relevant btrfs volume operations.

Under this new group all the existing btrfs/replace group would
come under, and also the device operations test cases which does
not have any group as of now. This group is helpful to verify
the btrfs volume related changes.

Run as
  ./check -g btrfs/volume

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/group | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tests/btrfs/group b/tests/btrfs/group
index d3639ba8dbfe..03de3d11cfa1 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -5,15 +5,15 @@
 #
 001 auto quick subvol snapshot
 002 auto snapshot
-003 auto replace
+003 auto replace volume
 004 auto rw metadata
 005 auto defrag
-006 auto quick
+006 auto quick volume
 007 auto quick rw metadata send
 008 auto quick send
 009 auto quick subvol
 010 auto
-011 auto replace
+011 auto replace volume
 012 auto convert
 013 auto quick balance
 014 auto balance
@@ -22,14 +22,14 @@
 017 auto quick qgroup
 018 auto quick subvol
 019 auto quick send
-020 auto quick replace
+020 auto quick replace volume
 021 auto quick balance defrag
 022 auto qgroup limit
 023 auto
 024 auto quick compress
 025 auto quick send clone
 026 auto quick compress prealloc
-027 auto replace
+027 auto replace volume
 028 auto qgroup balance
 029 auto quick clone
 030 auto quick send
@@ -66,14 +66,14 @@
 061 auto balance scrub
 062 auto balance defrag compress
 063 auto balance remount compress
-064 auto balance replace
-065 auto subvol replace
+064 auto balance replace volume
+065 auto subvol replace volume
 066 auto subvol scrub
 067 auto subvol defrag compress
 068 auto subvol remount compress
-069 auto replace scrub
-070 auto replace defrag compress
-071 auto replace remount compress
+069 auto replace scrub volume
+070 auto replace defrag compress volume
+071 auto replace remount compress volume
 072 auto scrub defrag compress
 073 auto scrub remount compress
 074 auto defrag remount compress
@@ -102,8 +102,8 @@
 097 auto quick send clone
 098 auto quick metadata clone
 099 auto quick qgroup limit
-100 auto replace
-101 auto replace
+100 auto replace volume
+101 auto replace volume
 102 auto quick metadata enospc
 103 auto quick clone compress
 104 auto qgroup
@@ -126,8 +126,8 @@
 121 auto quick snapshot qgroup
 122 auto quick snapshot qgroup
 123 auto quick qgroup
-124 auto replace
-125 auto replace
+124 auto replace volume
+125 auto replace volume
 126 auto quick qgroup limit
 127 auto quick send
 128 auto quick send
@@ -153,17 +153,17 @@
 148 auto quick rw
 149 auto quick send compress
 150 auto quick dangerous
-151 auto quick
+151 auto quick volume
 152 auto quick metadata qgroup send
 153 auto quick qgroup limit
-154 auto quick
+154 auto quick volume
 155 auto quick send
 156 auto quick trim
 157 auto quick raid
 158 auto quick raid scrub
 159 auto quick
 160 auto quick
-161 auto quick
-162 auto quick
-163 auto quick
-164 auto quick
+161 auto quick volume
+162 auto quick volume
+163 auto quick volume
+164 auto quick volume
-- 
2.15.0

