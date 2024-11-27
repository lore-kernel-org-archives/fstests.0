Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D759454
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 05:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683616; cv=none; b=TmoOcKrWb5PKt5LXif46MwYxMC9yGF5hBtXrMRGwmfrmdmoTRohJcY7QtpD7BlV/5CckPO7I26iNOb96EEZmhDqVu42BS/2evJ6LGUibgCxElFpfsmogJBLdh0r3g7LeQv19SdpTtVFpuj0BRif6SUAnapz3AfZ/dzmXV6knzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683616; c=relaxed/simple;
	bh=VYHnI+EQ8RX3UxtqJmZ0XnEY8+UR8gb5bvTutYchgkw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtbT7+/DHPiSl9ww2oeotNoNBSclSG1T+twN+9Q3v8LJ4A3dwksiMYKIP8HcLrrJw2Eg1rrLDNXGiLNUQ70aPYcYThDvRRrzWrVXK3Zs2HUQPcjWKpkvpyqYnVRSlKRQxVmoL5PN50k4f8SbFHLUXme7Q8B/hBMxqRq4irPlclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KNdx9kbj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KNdx9kbj"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cf3e36a76so59957315ad.0
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 21:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683614; x=1733288414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLMrktuCNGmFEoDqthJfXJDfe+SFyatGfYRpl7kApyQ=;
        b=KNdx9kbjhceEt/+LK5JqsBeVOdhqOpphTqKc2UCbVHMflWa1XtV7sy7ps7pt76tZIO
         cVmGuFSf8a9Yh3rKYEUVH40I038BkcY1hH0PAuUu+QJgRnuGJFCs/P1XRAXtR1UKZwic
         HK9x3MeI9ADCh9omFUqT683OPSowd2JtHdxGBXus7FAlZEvusyLoVfPHgiOO97MPNoWq
         4hOcJFuogmdBGNEQvcyt3Os8AtTnRQNMfUVbCJLK9OaqFwEVXq4IW5rh7BxUxq84rJdN
         5LDbFiHauFm+z6fvE18RtDhzke3CfBAV2ntDsQjgMX3Ut/uoE9a42z8I09hizVFbY28i
         d0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683614; x=1733288414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLMrktuCNGmFEoDqthJfXJDfe+SFyatGfYRpl7kApyQ=;
        b=oGQRLVp234byrW1ge4TY3SNwrfW0jMPMF3Dbsg3LhJIZ+mGiE7rR08GtC9hCbFbPp6
         LqgHDw5NdWXkwbQJcrwtoeCO1ajRF69y7TREuXqhv/3NbS12mDst8JeYqiKzRUX3OW7s
         1XHZD1Ya95eaN09iF+k3fem8Ctq+V8lRcdkSDiwJpxS742keDOFuGIjsjR2FB3+KZzv/
         iqiu7j5BCONOB1LhFCu3Wr6GpeJHdjvRQZtcAOXFhzJg8VfQdBvAnCAt6N+GnofseLUJ
         ZfBAtftplbkIurO2fE1h0xwRcBHKNyrU/gW0NugorlMk/p6lZwL5ZtvGLt3YCsJOMlEU
         oFLg==
X-Gm-Message-State: AOJu0YxAFeiPnj1fFi+moIwBq39Tkg9E7TDwRtSFJ//hzEZAoGQgPoqN
	SV/aHjETFRLi34RJX3clEQItkJQ5gGJV0jkUz65DNvZBAfXVPVfD5JbyQp7H9IYBhOG+FQPxev6
	j
X-Gm-Gg: ASbGnctY//BKe8BDrrI2zIFhh87UsBQt+wtkKgLgprGP6X0p1P6vYpsLjAu/eadyGqo
	aAf6j3L5NRHLep+dtCRlfHzYkslmh5rBhMRr1997sW9FsOkeRYPo8rFcxig9/Nn7OlEMIMnF3Y1
	0XJLTpdZ1FZpQzhq7n8klPeU2JfqNd3CVlcMqOMSc82zpkNn2gQdaFrfLeKs1CXNLqyD3km8a60
	J0vagg/n13rdJ2X859Kg6XgjxnSIy4tgubw0w1hsBY+54lqfCPOJCkBFSZxEwSuy1wsmH5PMiT3
	VBFKAUKkRIYK8g==
X-Google-Smtp-Source: AGHT+IFJtiuC+yNpBy3iRZyLNu5uhef34u+DTxDf90FyA2fHJezNU1c75bcj+1iwTvB+SJfVP7Q7Mg==
X-Received: by 2002:a17:903:2441:b0:20c:ee48:94f3 with SMTP id d9443c01a7336-215010992a5mr20328155ad.14.1732683614281;
        Tue, 26 Nov 2024 21:00:14 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc05fafsm93686325ad.163.2024.11.26.21.00.13
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 21:00:13 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZVN-2Tc8
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQfN-32Yy
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 24/40] fstests: stop using /tmp directly
Date: Wed, 27 Nov 2024 15:51:54 +1100
Message-ID: <20241127045403.3665299-25-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127045403.3665299-1-david@fromorbit.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Tests should be using $tmp, not /tmp. this causes problems when
multiple tests all use /tmp/foo as a temporary test state file
and then step on each other.

Note that there are some tests that use /tmp to store "test stop"
files for background processes. Those that have proven to be
unreliable at stopping tests when interrupted by ctrl-c are also
updated to track and kill background processes in the cleanup
function.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/162 |  4 ++--
 tests/generic/163 |  4 ++--
 tests/generic/164 |  4 ++--
 tests/generic/165 |  4 ++--
 tests/generic/166 |  6 +++---
 tests/generic/167 |  4 ++--
 tests/generic/168 |  7 +++++--
 tests/generic/170 |  7 +++++--
 tests/generic/333 |  6 +++---
 tests/generic/334 |  6 +++---
 tests/generic/373 |  2 +-
 tests/generic/374 |  2 +-
 tests/generic/670 |  2 +-
 tests/generic/671 |  2 +-
 tests/generic/672 |  2 +-
 tests/generic/722 | 15 ++++-----------
 tests/xfs/601     |  2 +-
 17 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/tests/generic/162 b/tests/generic/162
index e23014f03..25d2da7e0 100755
--- a/tests/generic/162
+++ b/tests/generic/162
@@ -15,7 +15,7 @@ _register_cleanup "_cleanup" BUS
 _cleanup()
 {
     cd /
-    rm -rf $tmp.* $finished_file
+    rm -rf $tmp.*
     wait
 }
 
@@ -30,7 +30,7 @@ _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
-finished_file=/tmp/finished
+finished_file=$tmp.finished
 rm -rf $finished_file
 mkdir $testdir
 
diff --git a/tests/generic/163 b/tests/generic/163
index 51a00e4b7..f80d699ac 100755
--- a/tests/generic/163
+++ b/tests/generic/163
@@ -15,7 +15,7 @@ _register_cleanup "_cleanup" BUS
 _cleanup()
 {
     cd /
-    rm -rf $tmp.* $finished_file
+    rm -rf $tmp.*
     wait
 }
 
@@ -30,7 +30,7 @@ _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
-finished_file=/tmp/finished
+finished_file=$tmp.finished
 rm -rf $finished_file
 mkdir $testdir
 
diff --git a/tests/generic/164 b/tests/generic/164
index e5c8acd02..f38e39868 100755
--- a/tests/generic/164
+++ b/tests/generic/164
@@ -16,7 +16,7 @@ _register_cleanup "_cleanup" BUS
 _cleanup()
 {
     cd /
-    rm -rf $tmp.* $finished_file
+    rm -rf $tmp.*
     wait
 }
 
@@ -32,7 +32,7 @@ _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
-finished_file=/tmp/finished
+finished_file=$tmp.finished
 rm -rf $finished_file
 mkdir $testdir
 
diff --git a/tests/generic/165 b/tests/generic/165
index 0e565eb1d..128afbeaa 100755
--- a/tests/generic/165
+++ b/tests/generic/165
@@ -16,7 +16,7 @@ _register_cleanup "_cleanup" BUS
 _cleanup()
 {
     cd /
-    rm -rf $tmp.* $finished_file
+    rm -rf $tmp.*
     wait
 }
 
@@ -33,7 +33,7 @@ _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
-finished_file=/tmp/finished
+finished_file=$tmp.finished
 rm -rf $finished_file
 mkdir $testdir
 
diff --git a/tests/generic/166 b/tests/generic/166
index 16157571f..4e0b19170 100755
--- a/tests/generic/166
+++ b/tests/generic/166
@@ -16,7 +16,7 @@ _register_cleanup "_cleanup" BUS
 _cleanup()
 {
     cd /
-    rm -rf $tmp.* $finished_file
+    rm -rf $tmp.* 
     wait
 }
 
@@ -33,8 +33,8 @@ _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
-finished_file=/tmp/finished
-do_snapshot=/tmp/snapshot
+finished_file=$tmp.finished
+do_snapshot=$tmp.snapshot
 rm -rf $finished_file
 mkdir $testdir
 
diff --git a/tests/generic/167 b/tests/generic/167
index 0c3e20fe2..ceb53963f 100755
--- a/tests/generic/167
+++ b/tests/generic/167
@@ -16,7 +16,7 @@ _register_cleanup "_cleanup" BUS
 _cleanup()
 {
     cd /
-    rm -rf $tmp.* $finished_file
+    rm -rf $tmp.*
     wait
 }
 
@@ -32,7 +32,7 @@ _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
-finished_file=/tmp/finished
+finished_file=$tmp.finished
 rm -rf $finished_file
 mkdir $testdir
 
diff --git a/tests/generic/168 b/tests/generic/168
index bd9859f73..d4b63cec8 100755
--- a/tests/generic/168
+++ b/tests/generic/168
@@ -16,7 +16,8 @@ _register_cleanup "_cleanup" BUS
 _cleanup()
 {
     cd /
-    rm -rf $tmp.* $finished_file
+    rm -rf $tmp.*
+    [ -n "$write_pid" ] && kill -9 $write_pid > /dev/null 2>&1
     wait
 }
 
@@ -31,7 +32,7 @@ _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
-finished_file=/tmp/finished
+finished_file=$tmp.finished
 rm -rf $finished_file
 mkdir $testdir
 
@@ -57,6 +58,7 @@ overwrite() {
 
 echo "Reflink and write the target"
 overwrite &
+write_pid=$!
 seq 1 10 | while read j; do
 	seq 0 $nr_loops | while read i; do
 		_reflink_range  $testdir/file1 $((i * blksz)) \
@@ -66,6 +68,7 @@ seq 1 10 | while read j; do
 done
 touch $finished_file
 wait
+unset write_pid
 
 # success, all done
 status=0
diff --git a/tests/generic/170 b/tests/generic/170
index 35b278b9f..be9cf7a18 100755
--- a/tests/generic/170
+++ b/tests/generic/170
@@ -16,7 +16,8 @@ _register_cleanup "_cleanup" BUS
 _cleanup()
 {
     cd /
-    rm -rf $tmp.* $finished_file
+    rm -rf $tmp.*
+    [ -n "$write_pid" ] && kill -9 $write_pid > /dev/null 2>&1
     wait
 }
 
@@ -32,7 +33,7 @@ _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
-finished_file=/tmp/finished
+finished_file=$tmp.finished
 rm -rf $finished_file
 mkdir $testdir
 
@@ -58,6 +59,7 @@ overwrite() {
 
 echo "Reflink and dio write the target"
 overwrite &
+write_pid=$!
 seq 1 10 | while read j; do
 	seq 0 $nr_loops | while read i; do
 		_reflink_range  $testdir/file1 $((i * blksz)) \
@@ -67,6 +69,7 @@ seq 1 10 | while read j; do
 done
 touch $finished_file
 wait
+unset write_pid
 
 # success, all done
 status=0
diff --git a/tests/generic/333 b/tests/generic/333
index 03a7bcd0e..220614147 100755
--- a/tests/generic/333
+++ b/tests/generic/333
@@ -16,7 +16,7 @@ _register_cleanup "_cleanup" BUS
 _cleanup()
 {
     cd /
-    rm -rf $tmp.* $finished_file $abort_file
+    rm -rf $tmp.*
     wait
 }
 
@@ -33,9 +33,9 @@ _scratch_mkfs_sized $((400 * 1048576)) > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
-finished_file=/tmp/finished
+finished_file=$tmp.finished
 rm -rf $finished_file
-abort_file=/tmp/abort
+abort_file=$tmp.abort
 rm -rf $abort_file
 mkdir $testdir
 
diff --git a/tests/generic/334 b/tests/generic/334
index 3f9718476..0faa5d696 100755
--- a/tests/generic/334
+++ b/tests/generic/334
@@ -16,7 +16,7 @@ _register_cleanup "_cleanup" BUS
 _cleanup()
 {
     cd /
-    rm -rf $tmp.* $finished_file $abort_file
+    rm -rf $tmp.*
     wait
 }
 
@@ -32,9 +32,9 @@ _scratch_mkfs_sized $((400 * 1048576)) > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
-finished_file=/tmp/finished
+finished_file=$tmp.finished
 rm -rf $finished_file
-abort_file=/tmp/abort
+abort_file=$tmp.abort
 rm -rf $abort_file
 mkdir $testdir
 
diff --git a/tests/generic/373 b/tests/generic/373
index e6334398f..04ec64251 100755
--- a/tests/generic/373
+++ b/tests/generic/373
@@ -32,7 +32,7 @@ _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
 mkdir $testdir
-otherdir=/tmp/m.$seq
+otherdir=$tmp.m.$seq
 othertestdir=$otherdir/test-$seq
 rm -rf $otherdir
 mkdir $otherdir
diff --git a/tests/generic/374 b/tests/generic/374
index e56521aa0..9a85091e2 100755
--- a/tests/generic/374
+++ b/tests/generic/374
@@ -31,7 +31,7 @@ _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
 mkdir $testdir
-otherdir=/tmp/m.$seq
+otherdir=$tmp.m.$seq
 othertestdir=$otherdir/test-$seq
 rm -rf $otherdir
 mkdir $otherdir
diff --git a/tests/generic/670 b/tests/generic/670
index 67a8f6fe2..f32199e70 100755
--- a/tests/generic/670
+++ b/tests/generic/670
@@ -23,7 +23,7 @@ _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
-finished_file=/tmp/finished
+finished_file=$tmp.finished
 rm -rf $finished_file
 mkdir $testdir
 
diff --git a/tests/generic/671 b/tests/generic/671
index f20069113..3abe12274 100755
--- a/tests/generic/671
+++ b/tests/generic/671
@@ -23,7 +23,7 @@ _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
-finished_file=/tmp/finished
+finished_file=$tmp.finished
 rm -rf $finished_file
 mkdir $testdir
 
diff --git a/tests/generic/672 b/tests/generic/672
index 832907de3..a5e65042e 100755
--- a/tests/generic/672
+++ b/tests/generic/672
@@ -22,7 +22,7 @@ _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
-finished_file=/tmp/finished
+finished_file=$tmp.finished
 rm -rf $finished_file
 mkdir $testdir
 
diff --git a/tests/generic/722 b/tests/generic/722
index 5542c045f..b9c608713 100755
--- a/tests/generic/722
+++ b/tests/generic/722
@@ -10,13 +10,6 @@
 . ./common/preamble
 _begin_fstest auto quick fiexchange
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -r -f $tmp.* $dir
-}
-
 # Import common functions.
 . ./common/filter
 . ./common/reflink
@@ -38,8 +31,8 @@ old_a=$(md5sum $SCRATCH_MNT/a | awk '{print $1}')
 old_b=$(md5sum $SCRATCH_MNT/b | awk '{print $1}')
 echo "md5 a: $old_a md5 b: $old_b" >> $seqres.full
 
-od -tx1 -Ad -c $SCRATCH_MNT/a > /tmp/a0
-od -tx1 -Ad -c $SCRATCH_MNT/b > /tmp/b0
+od -tx1 -Ad -c $SCRATCH_MNT/a > $tmp.a0
+od -tx1 -Ad -c $SCRATCH_MNT/b > $tmp.b0
 
 echo swap >> $seqres.full
 $XFS_IO_PROG -c "exchangerange -f $SCRATCH_MNT/a" $SCRATCH_MNT/b
@@ -53,8 +46,8 @@ echo "md5 a: $new_a md5 b: $new_b" >> $seqres.full
 test $old_a = $new_b || echo "scratch file B doesn't match old file A"
 test $old_b = $new_a || echo "scratch file A doesn't match old file B"
 
-od -tx1 -Ad -c $SCRATCH_MNT/a > /tmp/a1
-od -tx1 -Ad -c $SCRATCH_MNT/b > /tmp/b1
+od -tx1 -Ad -c $SCRATCH_MNT/a > $tmp.a1
+od -tx1 -Ad -c $SCRATCH_MNT/b > $tmp.b1
 
 # success, all done
 echo Silence is golden
diff --git a/tests/xfs/601 b/tests/xfs/601
index bc8fa719b..df382402b 100755
--- a/tests/xfs/601
+++ b/tests/xfs/601
@@ -15,7 +15,7 @@ _register_cleanup "_cleanup" BUS
 _cleanup()
 {
 	cd /
-	rm -rf $tmp.* $testdir
+	rm -rf $tmp.*
 }
 
 # Import common functions.
-- 
2.45.2

