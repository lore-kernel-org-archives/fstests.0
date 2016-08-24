Received: from imap.thunk.org ([74.207.234.97]:34672 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751789AbcHXVBl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 24 Aug 2016 17:01:41 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] Add punch, collapse, insert, zero test groups
Date: Wed, 24 Aug 2016 17:01:28 -0400
Message-Id: <20160824210128.27505-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Define test groups for those tests which have _require_xfs_io_command
for punch, collapse, insert, and zero.  This makes it easier to
exclude tests that use one of these fallocate commands.  Or if you
want to specifically test for those fallocate commands you can do
this.

This obviates an out-of-tree xfstests patch I maintain which used an
XFS_IO_AVOID environment variable to suppress running tests that use
punch, collapse, insert, etc.  This was rejected because of the claim
that it could be done using groups.  So this commit is in response to
those upstream comments.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/btrfs/group   |  2 +-
 tests/ext4/group    |  4 +--
 tests/generic/group | 88 ++++++++++++++++++++++++++---------------------------
 tests/xfs/group     | 22 +++++++-------
 4 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/tests/btrfs/group b/tests/btrfs/group
index 6b29c05..f3a7a4f 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -110,7 +110,7 @@
 105 auto quick send
 106 auto quick clone compress
 107 auto quick prealloc
-108 auto quick send clone
+108 auto quick send clone punch
 109 auto quick send clone compress
 110 auto quick send
 111 auto quick send
diff --git a/tests/ext4/group b/tests/ext4/group
index e0772ab..53fe03e 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -3,7 +3,7 @@
 # - do not start group names with a digit
 # - comment line before each group is "new" description
 #
-001 auto prealloc quick
+001 auto prealloc quick zero
 002 auto quick prealloc
 003 auto quick
 004 auto dump
@@ -17,7 +17,7 @@
 012 fuzzers
 013 fuzzers
 014 fuzzers
-015 fuzzers
+015 fuzzers punch
 016 fuzzers
 017 fuzzers
 018 fuzzers
diff --git a/tests/generic/group b/tests/generic/group
index ef38c35..c813c65 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -10,21 +10,21 @@
 005 dir udf auto quick
 006 dir udf auto quick
 007 dir udf auto quick
-008 auto quick prealloc
-009 auto quick prealloc
+008 auto quick prealloc zero
+009 auto quick prealloc zero
 010 other udf auto
 011 dir udf auto quick
-012 auto quick prealloc
+012 auto quick prealloc punch collapse
 013 other ioctl udf auto quick
 014 rw udf auto quick
 015 other auto quick enospc
-016 auto quick prealloc
-017 auto prealloc
+016 auto quick prealloc punch collapse
+017 auto prealloc collapse
 018 auto fsr quick
 019 aio dangerous enospc rw stress
 020 metadata attr udf auto quick
-021 auto quick prealloc
-022 auto quick prealloc
+021 auto quick prealloc punch collapse
+022 auto quick prealloc punch collapse
 023 auto quick
 024 auto quick
 025 auto quick
@@ -33,9 +33,9 @@
 028 auto quick
 029 auto quick rw
 030 auto quick rw
-031 auto quick prealloc rw
+031 auto quick prealloc rw collapse
 032 auto quick rw
-033 auto quick rw
+033 auto quick rw zero
 034 auto quick metadata log
 035 auto quick
 036 auto aio rw stress
@@ -44,7 +44,7 @@
 039 metadata auto quick
 040 metadata auto quick
 041 metadata auto quick
-042 rw
+042 rw punch zero
 043 metadata log auto
 044 metadata log auto
 045 metadata log auto
@@ -60,13 +60,13 @@
 055 log v2log auto quota stress
 056 metadata auto quick
 057 metadata auto quick
-058 auto quick prealloc
-059 metadata auto quick
-060 auto quick prealloc
-061 auto quick prealloc
+058 auto quick prealloc punch insert
+059 metadata auto quick punch
+060 auto quick prealloc punch insert
+061 auto quick prealloc punch insert
 062 attr udf auto quick
-063 auto quick prealloc
-064 auto quick prealloc
+063 auto quick prealloc punch insert
+064 auto quick prealloc collapse insert
 065 metadata auto quick
 066 metadata auto quick
 067 auto quick mount
@@ -74,7 +74,7 @@
 069 rw udf auto quick
 070 attr udf auto quick stress
 071 auto quick prealloc
-072 auto metadata stress
+072 auto metadata stress collapse
 073 metadata auto quick
 074 rw udf auto
 075 rw udf auto quick
@@ -98,7 +98,7 @@
 093 attr cap udf auto
 094 auto quick prealloc
 095 auto rw stress
-096 auto prealloc quick
+096 auto prealloc quick zero
 097 udf auto
 098 auto quick metadata
 099 udf auto
@@ -147,17 +147,17 @@
 142 auto quick clone
 143 auto quick clone
 144 auto quick clone
-145 auto quick clone
-146 auto quick clone
-147 auto quick clone
+145 auto quick clone collapse
+146 auto quick clone punch
+147 auto quick clone insert
 148 auto quick clone
-149 auto quick clone
+149 auto quick clone zero
 150 auto quick clone
 151 auto quick clone
-152 auto quick clone
-153 auto quick clone
+152 auto quick clone punch
+153 auto quick clone collapse
 154 auto quick clone
-155 auto quick clone
+155 auto quick clone zero
 156 auto quick clone
 157 auto quick clone
 158 auto quick clone dedupe
@@ -179,17 +179,17 @@
 174 auto quick clone
 175 auto clone
 176 auto clone
-177 auto quick prealloc metadata
-178 auto quick clone
-179 auto quick clone
-180 auto quick clone
+177 auto quick prealloc metadata punch
+178 auto quick clone punch
+179 auto quick clone punch
+180 auto quick clone zero
 181 auto quick clone
 182 auto quick clone dedupe
 183 auto quick clone
 184 metadata auto quick
 185 auto quick clone
-186 auto clone
-187 auto clone
+186 auto clone punch
+187 auto clone punch
 188 auto quick clone
 189 auto quick clone
 190 auto quick clone
@@ -201,8 +201,8 @@
 196 auto quick clone
 197 auto quick clone
 198 auto aio quick
-199 auto quick clone
-200 auto quick clone
+199 auto quick clone punch
+200 auto quick clone punch
 201 auto quick clone
 202 auto quick clone
 203 auto quick clone
@@ -256,15 +256,15 @@
 251 ioctl trim
 252 auto quick prealloc rw
 253 auto quick clone
-254 auto quick clone
-255 auto quick prealloc
-256 auto quick
+254 auto quick clone punch
+255 auto quick prealloc punch
+256 auto quick punch
 257 dir auto quick
 258 auto quick
-259 auto quick clone
+259 auto quick clone zero
 260 auto quick trim
-261 auto quick clone
-262 auto quick clone
+261 auto quick clone collapse
+262 auto quick clone insert
 263 rw auto quick
 264 auto quick clone
 265 auto quick clone
@@ -302,7 +302,7 @@
 297 auto clone
 298 auto clone
 299 auto aio enospc rw stress
-300 auto aio enospc preallocrw stress
+300 auto aio enospc preallocrw stress punch
 301 auto quick clone
 302 auto quick clone
 303 auto quick clone
@@ -318,7 +318,7 @@
 313 auto quick
 314 auto quick acl
 315 auto quick rw prealloc
-316 auto quick
+316 auto quick punch
 317 auto metadata quick
 318 acl attr auto quick
 319 acl auto quick
@@ -351,9 +351,9 @@
 346 auto quick rw
 347 auto quick rw thin
 348 auto quick metadata
-349 blockdev quick rw
-350 blockdev quick rw
-351 blockdev quick rw
+349 blockdev quick rw zero
+350 blockdev quick rw punch
+351 blockdev quick rw punch collapse insert zero
 352 auto clone
 353 auto quick clone
 354 auto
diff --git a/tests/xfs/group b/tests/xfs/group
index 6905a62..cf64768 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -73,14 +73,14 @@
 073 copy auto
 074 quick auto prealloc rw
 075 auto quick mount
-076 auto enospc
+076 auto enospc punch
 077 auto quick copy
 078 growfs auto quick
 079 auto log quick
 080 rw ioctl
 081 deprecated # log logprint quota
 082 deprecated # log logprint v2log
-083 dangerous_fuzzers
+083 dangerous_fuzzers punch
 084 ioctl rw auto
 085 fuzzers
 086 fuzzers
@@ -225,22 +225,22 @@
 225 auto quick clone
 226 auto quick clone
 227 auto fsr
-228 auto quick clone
+228 auto quick clone punch
 229 auto rw
-230 auto quick clone
+230 auto quick clone punch
 231 auto quick clone
 232 auto quick clone
 233 auto quick rmap
-234 auto quick rmap
+234 auto quick rmap punch
 235 fuzzers rmap
-236 auto rmap
+236 auto rmap punch
 237 auto quick clone
 238 auto quick metadata ioctl
 239 auto quick clone
 240 auto quick clone
 241 auto quick clone
-242 auto quick prealloc
-243 auto quick clone
+242 auto quick prealloc zero
+243 auto quick clone punch
 244 auto quota quick
 245 auto quick clone
 246 auto quick clone
@@ -249,7 +249,7 @@
 249 auto quick clone
 250 auto quick rw prealloc metadata
 251 auto quick clone
-252 auto quick prealloc
+252 auto quick prealloc punch
 253 auto quick
 254 auto quick clone
 255 auto quick clone
@@ -271,7 +271,7 @@
 282 dump ioctl auto quick
 283 dump ioctl auto quick
 287 auto dump quota quick
-290 auto rw prealloc quick ioctl
+290 auto rw prealloc quick ioctl zero
 291 auto repair
 292 auto mkfs quick
 293 auto quick
@@ -286,7 +286,7 @@
 303 auto quick quota
 304 auto quick quota
 305 auto quota
-306 auto dangerous quick
+306 auto dangerous quick punch
 307 auto quick clone
 308 auto quick clone
 309 auto clone
-- 
2.9.0.243.g5c589a7.dirty

