Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC9E1C8628
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859538; cv=none; b=FfRiPT4eAWx7WHw1UuNbvZDv/KE5Ap6KXUIVFZa6saAZna9gCj2ha1o12VBv+RfbfaL/AurGr4jJ6kDbzLNDlscjRHYzKAMYONscIQKXTz/fLfbfuJ2z3oDedjGUpvayN8THLEc86bRF22BFUKXGa6T+4zNSzLpFVW5ieT6Yw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859538; c=relaxed/simple;
	bh=t3yOMBHI5hM9QtZl6rp6tAAW93Tf4IjrurDoXBiqK0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCGGq2Hm9Ha01H963ePCx1cAjj2iJrjcA+6zWbxzLl7535wv2yWOG8jVTk0vcZvzjqz5do6r5apK1/qPCeAHFj8kp9Ro3eLeAq7DYhdU4A3mRDsWBYnyPulalyzmyzlZvbySI8giDIO4TGRRpenm5o6WAx3LMHX66z2vUbI4W0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=oAJQVT5b; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="oAJQVT5b"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22c33677183so3551955ad.2
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744859535; x=1745464335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHn4iJxogQuMh/ahDhm/alvnR/vDGleiBZtOn+tJ4VI=;
        b=oAJQVT5bMG22Iob5wGqakHnFhU0roTfpmqGs+WLBunkw6bwEGIiRlecfKTKc5GwQSX
         7z36baDaAe+WEeMRpCZe3k//MWcrHHVUhNJjGIQrj5zRuWb26OpyfNDX4yPo0hKpRcpN
         7oJgbBLmesG6eQ9CqEbKWMjkwWlpuKjSN3Wsbrj9FwmVu6VisVTvGwl+qIak2rPjJpVz
         feVvecPpDRVcXfkFJP3dCYJ9w3FqVel7I4VXLocWA2wIecQz2LZHmpGqPHbsQv80YjDu
         RL8Utlj66z1gdb5f7ivBM8TpNHKpXluy69YmzwZBlJGc+qHhg4ldls/z0wO2+oB6zT1+
         V91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744859535; x=1745464335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHn4iJxogQuMh/ahDhm/alvnR/vDGleiBZtOn+tJ4VI=;
        b=D13sIYxx22Hxffey4xsCfinzQSgj3SNn5N4EY2N3zSwhKUJWBTDODHqrPiGDjwGymf
         IByYTEAuQYZ5SVSrq6ZoOGuZkowJMXEsHXFD4yts8VjGjaoWuW7INXTcGbcOYaL8qqIV
         2qH9W0yScsBWuJQznfw+YuXdcrN+HIbCq5T1KOhH4hpphEimQMBdYsggGWIv31ZfwCYs
         pVdz5btvFlmiVoQxJfGgN4dqX7uwsUJlD2wTAvhp+vFe3ME8nkZbxNrrdUolmASts1Oz
         9SoNqgRgLPuhyJ6OjTfLm6Qg+fZHgLwFObKYX449o5y7sZIDZ1S3q2pK+224vjNurSgQ
         UPBQ==
X-Gm-Message-State: AOJu0YxnwxkM1FnnhR0aJwPVsf/FIT6aBhACc9iVfihRJWYkCiqo2P7x
	pA7QDzTIbM1S44U3iZQb8pWHzYINAYqBGGJKTlfS02XU7We+M0O0GbPzXl319G8jD+DKf7kT+gc
	t
X-Gm-Gg: ASbGncsuRzHnxZbsw46GB70IKpCKvlhJu+4Cy2pc4iCvYqSn2fGCDP+TMCQ+YUtjagl
	9cvEIt+C8hk3LGR8U/iK0RgynQl3s0hHClrat2Zb9gE+YrwBP7NtQ7MFWplWxsofiufuv9Dumfi
	FpnPzu/dCM6LM6ToBWwQJO+jPURdNAWN34bl5JNcXjcz2iUvTl58m37LX8qcDF67OtYiB68j6GO
	Qeb1bco/VZU9bnCZGiiKHrIHXwpxMiTzj+pjyp1ufECvA4UJVyIg0YH8EDOtl8ZdscQ+Nzl+Dun
	RUVXPCawYjEhKdXh/oV3xQKj7Py7+3iSAK3OiiZR2MKMorStYGWOz+KthCA1+4dQU1s1AZ529qO
	jkxll37c4vWKL
X-Google-Smtp-Source: AGHT+IGOkvZKpnidJ3XbojxwtvIyOA/jEkG51ys0Us6l0MjbyIrJKcSy1lj23EkCyjB6Eh+hlfEQUA==
X-Received: by 2002:a17:902:cec5:b0:21f:61a9:be7d with SMTP id d9443c01a7336-22c35983aa0mr54753705ad.49.1744859535294;
        Wed, 16 Apr 2025 20:12:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cdf7sm22497265ad.72.2025.04.16.20.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:12:13 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffd-00000009Y9R-40lV;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mE5-0l08;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 03/28] fstests: move test exit functions to common/exit
Date: Thu, 17 Apr 2025 13:00:44 +1000
Message-ID: <20250417031208.1852171-4-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250417031208.1852171-1-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Functions like _fatal() and _exit() need to be called from
common/config as well as general common and test code. Having some
of these test exit functions defined in common/config requires all
contexts to source this file and run all the environment setup
just to gain access to these functions.

There is a catch-22 with these functions - they cannot be defined in
common/rc for all contexts to pick up automatically, because
common/config needs them and some functions in common/rc depend on
common/config being sourced first. And we can't define them all in
common/config, because there are contexts where that hasn't been
sourced that need a specific test exit function.

Solve this by move all the test exit functions to a new common/exit
file and source that explicitly in the contexts that need it, hence
removing the circular dependency between common/config and common/rc
for defining these functions...

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check           |  2 ++
 common/config   | 16 +---------------
 common/exit     | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 common/preamble |  1 +
 common/rc       | 22 ----------------------
 5 files changed, 52 insertions(+), 37 deletions(-)
 create mode 100644 common/exit

diff --git a/check b/check
index d6bab8b5f..69866b14b 100755
--- a/check
+++ b/check
@@ -52,6 +52,8 @@ rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
 SRC_GROUPS="generic"
 export SRC_DIR="tests"
 
+. ./common/exit
+
 usage()
 {
     echo "Usage: $0 [options] [testlist]"'
diff --git a/common/config b/common/config
index eada39717..5081c300a 100644
--- a/common/config
+++ b/common/config
@@ -40,6 +40,7 @@
 #
 
 . common/test_names
+. common/exit
 
 # all tests should use a common language setting to prevent golden
 # output mismatches.
@@ -96,15 +97,6 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
 
 export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
 
-# This functions sets the exit code to status and then exits. Don't use
-# exit directly, as it might not set the value of "$status" correctly, which is
-# used as an exit code in the trap handler routine set up by the check script.
-_exit()
-{
-	test -n "$1" && status="$1"
-	exit "$status"
-}
-
 # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
 set_mkfs_prog_path_with_opts()
 {
@@ -121,12 +113,6 @@ set_mkfs_prog_path_with_opts()
 	fi
 }
 
-_fatal()
-{
-    echo "$*"
-    _exit 1
-}
-
 export MKFS_PROG="$(type -P mkfs)"
 [ "$MKFS_PROG" = "" ] && _fatal "mkfs not found"
 
diff --git a/common/exit b/common/exit
new file mode 100644
index 000000000..16777507a
--- /dev/null
+++ b/common/exit
@@ -0,0 +1,48 @@
+##/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
+#
+# Test termination functions that need to be independent of the context that the
+# test is running in. This must not have any dependencies on common/config or
+# common/rc, as they both require these functions to be defined before they are
+# sourced.
+
+# Exit a context, setting up the test exit status if appropriate.
+#
+# "$status" is the exit code for the trap handler routine set up by the check
+# script, hence we cannot call exit directly from contexts that require $status
+# to be set.
+_exit()
+{
+	test -n "$1" && status="$1"
+	exit "$status"
+}
+
+# Bail out of a test context, setting up .notrun file. Need to kill the
+# filesystem check files here, otherwise they are set incorrectly for the next
+# test.
+_notrun()
+{
+    echo "$*" > $seqres.notrun
+    echo "$seq not run: $*"
+    rm -f ${RESULT_DIR}/require_test*
+    rm -f ${RESULT_DIR}/require_scratch*
+
+    _exit 0
+}
+
+# Exit a test immediately with a fatal error.
+_fail()
+{
+    echo "$*" | tee -a $seqres.full
+    echo "(see $seqres.full for details)"
+    _exit 1
+}
+
+# Exit any context with a fatal error.
+_fatal()
+{
+    echo "$*"
+    _exit 1
+}
+
diff --git a/common/preamble b/common/preamble
index ba029a347..0b684cc33 100644
--- a/common/preamble
+++ b/common/preamble
@@ -49,6 +49,7 @@ _begin_fstest()
 
 	_register_cleanup _cleanup
 
+	. ./common/exit
 	. ./common/rc
 	init_rc
 
diff --git a/common/rc b/common/rc
index 12a05cb96..94c00d890 100644
--- a/common/rc
+++ b/common/rc
@@ -1798,28 +1798,6 @@ _do()
     return $ret
 }
 
-# bail out, setting up .notrun file. Need to kill the filesystem check files
-# here, otherwise they are set incorrectly for the next test.
-#
-_notrun()
-{
-    echo "$*" > $seqres.notrun
-    echo "$seq not run: $*"
-    rm -f ${RESULT_DIR}/require_test*
-    rm -f ${RESULT_DIR}/require_scratch*
-
-    _exit 0
-}
-
-# just plain bail out
-#
-_fail()
-{
-    echo "$*" | tee -a $seqres.full
-    echo "(see $seqres.full for details)"
-    _exit 1
-}
-
 #
 # Tests whether $FSTYP should be exclude from this test.
 #
-- 
2.45.2

