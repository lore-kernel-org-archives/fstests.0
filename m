Received: from mail.kernel.org ([198.145.29.99]:44722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbeJ0R3O (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 27 Oct 2018 13:29:14 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 448732075D
        for <fstests@vger.kernel.org>; Sat, 27 Oct 2018 08:49:00 +0000 (UTC)
From: fdmanana@kernel.org
Subject: [PATCH 2/2] fstests: add some tests to the 'log' group that use dmflakey
Date: Sat, 27 Oct 2018 09:48:58 +0100
Message-Id: <20181027084858.1953-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Some tests that use dmflakey to test filesystem consistency after a power
failure are in the 'log' group while others are not. So fix the
incosistency and put them all under the 'log' group.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/group   | 14 +++++++-------
 tests/generic/group | 48 ++++++++++++++++++++++++------------------------
 tests/shared/group  |  2 +-
 3 files changed, 32 insertions(+), 32 deletions(-)
 mode change 100644 => 100755 tests/btrfs/group
 mode change 100644 => 100755 tests/generic/group

diff --git a/tests/btrfs/group b/tests/btrfs/group
old mode 100644
new mode 100755
index 3ea84b1c..a490d7eb
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -58,7 +58,7 @@
 053 auto quick send
 054 auto quick send
 055 auto quick clone
-056 auto quick clone
+056 auto quick clone log
 057 auto quick
 058 auto quick send snapshot
 059 auto quick
@@ -97,10 +97,10 @@
 092 auto quick send
 093 auto quick clone
 094 auto quick send
-095 auto quick metadata
+095 auto quick metadata log
 096 auto quick clone
 097 auto quick send clone
-098 auto quick metadata clone
+098 auto quick metadata clone log
 099 auto quick qgroup limit
 100 auto replace volume
 101 auto replace volume
@@ -120,9 +120,9 @@
 115 auto qgroup
 116 auto quick metadata
 117 auto quick send clone
-118 auto quick snapshot metadata
-119 auto quick snapshot metadata qgroup
-120 auto quick snapshot metadata
+118 auto quick snapshot metadata log
+119 auto quick snapshot metadata qgroup log
+120 auto quick snapshot metadata log
 121 auto quick snapshot qgroup
 122 auto quick snapshot qgroup
 123 auto quick qgroup
@@ -161,7 +161,7 @@
 156 auto quick trim
 157 auto quick raid
 158 auto quick raid scrub
-159 auto quick punch
+159 auto quick punch log
 160 auto quick
 161 auto quick volume
 162 auto quick volume
diff --git a/tests/generic/group b/tests/generic/group
old mode 100644
new mode 100755
index d17a0248..920230af
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -41,9 +41,9 @@
 036 auto aio rw stress
 037 metadata auto quick
 038 auto stress
-039 metadata auto quick
-040 metadata auto quick
-041 metadata auto quick
+039 metadata auto quick log
+040 metadata auto quick log
+041 metadata auto quick log
 042 shutdown rw punch zero
 043 shutdown metadata log auto
 044 shutdown metadata log auto
@@ -58,24 +58,24 @@
 053 acl repair auto quick
 054 shutdown log v2log auto
 055 shutdown log v2log auto quota stress
-056 metadata auto quick
-057 metadata auto quick
+056 metadata auto quick log
+057 metadata auto quick log
 058 auto quick prealloc punch insert
-059 metadata auto quick punch
+059 metadata auto quick punch log
 060 auto quick prealloc punch insert
 061 auto quick prealloc punch insert
 062 attr udf auto quick
 063 auto quick prealloc punch insert
 064 auto quick prealloc collapse insert
-065 metadata auto quick
-066 metadata auto quick
+065 metadata auto quick log
+066 metadata auto quick log
 067 auto quick mount
 068 other auto freeze stress
 069 rw udf auto quick
 070 attr udf auto quick stress
 071 auto quick prealloc
 072 auto metadata stress collapse
-073 metadata auto quick
+073 metadata auto quick log
 074 rw udf auto
 075 rw udf auto quick
 076 metadata rw udf auto quick stress
@@ -92,7 +92,7 @@
 087 perms auto quick
 088 perms auto quick
 089 metadata auto
-090 metadata auto quick
+090 metadata auto quick log
 091 rw auto quick
 092 auto quick prealloc
 093 attr cap auto
@@ -103,13 +103,13 @@
 098 auto quick metadata
 099 acl auto quick
 100 udf auto
-101 auto quick metadata
+101 auto quick metadata log
 102 auto rw
 103 auto enospc quick
-104 auto quick metadata
+104 auto quick metadata log
 105 acl auto quick
-106 auto quick metadata
-107 auto quick metadata
+106 auto quick metadata log
+107 auto quick metadata log
 108 auto quick rw
 109 auto metadata dir
 110 auto quick clone
@@ -179,7 +179,7 @@
 174 auto quick clone
 175 auto clone
 176 auto clone
-177 auto quick prealloc metadata punch
+177 auto quick prealloc metadata punch log
 178 auto quick clone punch
 179 auto quick clone punch
 180 auto quick clone zero
@@ -337,15 +337,15 @@
 332 auto quick clone
 333 auto clone
 334 auto clone
-335 auto quick metadata
-336 auto quick metadata
+335 auto quick metadata log
+336 auto quick metadata log
 337 auto quick metadata
 338 auto quick rw
 339 auto dir
 340 auto
-341 auto quick metadata
-342 auto quick metadata
-343 auto quick metadata
+341 auto quick metadata log
+342 auto quick metadata log
+343 auto quick metadata log
 344 auto
 345 auto
 346 auto quick rw
@@ -378,7 +378,7 @@
 373 auto quick clone
 374 auto quick clone dedupe
 375 auto quick acl
-376 auto quick metadata
+376 auto quick metadata log
 377 attr auto quick metadata
 378 auto quick metadata
 379 quota auto quick
@@ -481,8 +481,8 @@
 476 auto rw
 477 auto quick exportfs
 478 auto quick
-479 auto quick metadata
-480 auto quick metadata
+479 auto quick metadata log
+480 auto quick metadata log
 481 auto quick log metadata
 482 auto metadata replay
 483 auto quick log metadata
@@ -491,7 +491,7 @@
 486 auto quick attr
 487 auto quick
 488 auto quick
-489 auto quick attr
+489 auto quick attr log
 490 auto quick rw
 491 auto quick freeze mount
 492 auto quick
diff --git a/tests/shared/group b/tests/shared/group
index 094da27d..bc33f18f 100644
--- a/tests/shared/group
+++ b/tests/shared/group
@@ -4,7 +4,7 @@
 # - comment line before each group is "new" description
 #
 001 auto quick
-002 auto metadata quick
+002 auto metadata quick log
 003 auto quick
 004 auto quick
 005 dangerous_fuzzers
-- 
2.11.0
