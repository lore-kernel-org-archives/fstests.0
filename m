Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A84689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683546; cv=none; b=Mcq+mF7HXdi6s6Ft3GfT1Q3BaYlyhJUcXoOdFar9hpaLAc42bEFqrCCqZQHMMGUO7E2BTUd8gqS+WrfcCQJNsyuoet8le+6q4Ye3hV9RJ3xL9mbqQhQ+FOzGqTyzYpLLH7YN4oKUskhSvoZFUkhS3O1pld/kQG+wcUqntC2lnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683546; c=relaxed/simple;
	bh=Lf47K7f1VAUohwSPIEOalscdH2rf7ZBjq/1KB7c8lx0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyxBxGBMtiJACV6u90kwlLOii6sV+wCFw/4Ci0n4CV7gQhL6vLeHjmSn1tAtoofL1fqdyHWHt+2e5MdHGT/mnDAyy7dg2vtnu/nJSZhg3bxlA9DtQCiXqX+CJWZTwWR6IOBfXGYWwzdE1Thvjlf0cTaYnaNOF28dUFv42/4HYp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KWIymzq3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KWIymzq3"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ea752c0555so4899875a91.3
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683544; x=1733288344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8Q8a71rnoEldk5CY5VppAcViknYxiUY+jLbO3d56Wc=;
        b=KWIymzq3nUE7J6Mgjd+Xkk7/tOtDTUac/Q4A9b/FnD/8sJ/dwCQB5DvR0a1hXR3Ouk
         IrRF7O4u7tcTUzYIE9NiApvArrU/OMnIl7PDQm8/Se4ETuMXxn4YPgfTX5vB8Rxfo4mM
         VL0r8FQ8nsQsC9xeGchc7Uzz7k4KTdTPeCRE2OYA9MMksKJqdUNE5KlS8nYG42unqcWB
         mJYRethRZHr0BeW5YswXR3glApNLy7Y0of0oHmFyoCycOmpPk2/0yCTqeL4jrB+bkQXP
         DjqzBG3Ll1X9cO5R8mW6ZOWGv9Cxe901YXYhKJpaoTZWvMK/Z3KoNOkNAAWstm0BtuDE
         JoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683544; x=1733288344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8Q8a71rnoEldk5CY5VppAcViknYxiUY+jLbO3d56Wc=;
        b=g/ZHG26lWUZDkWwzKs7aJUznSGN7wmSbSXyxd58NHRTsakmQeEhauvsvRasbhi1LNE
         e8jNjXDZ2h5sM0U4P9zT5hAt1hulo28ovMIV2ffHLM4lA/OVMFQUoruuXJxFErxly7LI
         UZDmxa4yFnUS8eYrZ+TwX1TCDD1YICRYJFVub0vGmagbFeL7rImuxRKE9Qt2rurlVcL9
         ttiTtIgwkJpBzKqRPBUmcv2qMTu1COmAewmuxQzqGlivRlsiHUp14ELOzJ106VpOBh5X
         PIaX4H+A3norabWVbafA36qLeB1euv1uymxVGCzXcJB5i7dLKZ+xCtRLOUpUJuw2agv3
         x/JQ==
X-Gm-Message-State: AOJu0Yxpi9HcmcDFe44VvJOqFll0vxEA0lm0ci/6kCv71TskC1jXaBK6
	4dM5kxDNut6iKh7eJ/o7RdZ++eaT103DIdUMGxjAtxYWCFcoPXLYtNv6TDN25hFLG2D5HnONVbZ
	T
X-Gm-Gg: ASbGncst/V7izTPsKRQiagJkO8RL0rBJcQ5cFipzxSH5IALyot9wYFABbxz6QXSeWZI
	XWX7jzhdGoiDAU/0/WABKP3h3LjzWza0mOii5qCOpHbo94pNPLvMW/qWcDZ4+Q4q21vDMalpyUM
	3bgQ2BfC5JuqkjgtEuJOvgBHDEmRLMXMlcqHQrWh/sGSBiYukf0b9eLjPxElxtQPOACtYP347nv
	Jhe/6ba1dblxYB3GqDu8CZw38DWJoDKn1AZc3MKsRc9kFMshvoOpAlrthR+n3BAAu6LoSIA8pqO
	4lNOloZi+9s6pQ==
X-Google-Smtp-Source: AGHT+IE6WSTffzwyMdhvMqunI5dgay38NYLBW2ZDCJQhFxnrsXsL3XQZkAK12Vk2V6AHVqHh3CKEUA==
X-Received: by 2002:a17:90b:1bd2:b0:2ea:4150:3f82 with SMTP id 98e67ed59e1d1-2ee08ecd374mr2214981a91.22.1732683544625;
        Tue, 26 Nov 2024 20:59:04 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0532460asm607920a91.1.2024.11.26.20.59.03
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:03 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3y-00000003ZW8-01G3
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3y-0000000FQgM-0YAO
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 36/40] fstests: capture some failures to seqres.full
Date: Wed, 27 Nov 2024 15:52:06 +1100
Message-ID: <20241127045403.3665299-37-david@fromorbit.com>
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

Whilst trying to debug test failures, I found a few places where
errors needed to be redirected to $seqres.full rather than
/dev/null. This is a collection of all the conversions that haven't
been captured by some other bug fix patch.

Note that calling _check_filesystems() after removing the
require_test/scratch files means it is a no-op, so I removed that
call at the same time as capturing unmount failures after the test
has failed.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check             | 5 ++---
 tests/generic/049 | 2 +-
 tests/generic/603 | 6 +++---
 tests/xfs/495     | 2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/check b/check
index 9222cd7e4..8131f4e2e 100755
--- a/check
+++ b/check
@@ -1004,14 +1004,13 @@ function run_section()
 
 		if [ $sts -ne 0 ]; then
 			_dump_err_cont "[failed, exit status $sts]"
-			_test_unmount 2> /dev/null
-			_scratch_unmount 2> /dev/null
+			_test_unmount 2>> $seqres.full
+			_scratch_unmount 2>> $seqres.full
 			rm -f ${RESULT_DIR}/require_test*
 			rm -f ${RESULT_DIR}/require_scratch*
 			# Even though we failed, there may be something interesting in
 			# dmesg which can help debugging.
 			_check_dmesg
-			(_adjust_oom_score 250; _check_filesystems)
 			tc_status="fail"
 		else
 			# The test apparently passed, so check for corruption
diff --git a/tests/generic/049 b/tests/generic/049
index 94b5afe96..fcfbd48ec 100755
--- a/tests/generic/049
+++ b/tests/generic/049
@@ -56,7 +56,7 @@ i=1;
 while [ $i -lt 1000 ]
 do
 	file=$SCRATCH_MNT/$i
-	$XFS_IO_PROG -f -c "pwrite -b 32k -S 0xff 0 32k" $file > /dev/null
+	$XFS_IO_PROG -f -c "pwrite -b 32k -S 0xff 0 32k" $file >> $seqres.full
 	if [ $? -ne 0 ]
 	then
 		echo error creating/writing file $file
diff --git a/tests/generic/603 b/tests/generic/603
index a84695831..2a75cf9e0 100755
--- a/tests/generic/603
+++ b/tests/generic/603
@@ -77,7 +77,7 @@ test_grace()
 		_filter_xfs_io_error | tee -a $seqres.full
 	repquota -v -$type $SCRATCH_MNT | grep -v "^root" >>$seqres.full 2>&1
 	# Reset grace time here, make below grace time test more accurate
-	setquota -$type $qa_user -T $bgrace $igrace $SCRATCH_MNT 2>/dev/null
+	setquota -$type $qa_user -T $bgrace $igrace $SCRATCH_MNT >>$seqres.full 2>&1
 	# Now sleep enough grace time and check that softlimit got enforced
 	sleep $((bgrace + 1))
 	echo "Try to write 1 one more block after grace..."
@@ -89,13 +89,13 @@ test_grace()
 	# And now the softlimit test for inodes
 	# First reset space limits so that we don't have problems with
 	# space reservations on XFS
-	setquota -$type $qa_user 0 0 3 100 $SCRATCH_MNT
+	setquota -$type $qa_user 0 0 3 100 $SCRATCH_MNT 
 	echo "Create 2 more files, over the inode softlimit..."
 	su $qa_user -c "touch $dir/file3 $dir/file4" 2>&1 >>$seqres.full | \
 		_filter_scratch | tee -a $seqres.full
 	repquota -v -$type $SCRATCH_MNT  | grep -v "^root" >>$seqres.full 2>&1
 	# Reset grace time here, make below grace time test more accurate
-	setquota -$type $qa_user -T $bgrace $igrace $SCRATCH_MNT 2>/dev/null
+	setquota -$type $qa_user -T $bgrace $igrace $SCRATCH_MNT >>$seqres.full 2>&1
 	# Wait and check grace time enforcement
 	sleep $((igrace+1))
 	echo "Try to create one more inode after grace..."
diff --git a/tests/xfs/495 b/tests/xfs/495
index b42e7e5b3..ce724f381 100755
--- a/tests/xfs/495
+++ b/tests/xfs/495
@@ -24,7 +24,7 @@ _require_populate_commands
 _require_xfs_db_command "fuzz"
 
 echo "Format and populate"
-_scratch_populate_cached nofill > $seqres.full 2>&1
+_scratch_populate_cached nofill >> $seqres.full 2>&1
 
 filter_nbrepair() {
 	grep rebuilding | sed -e 's/directory inode [0-9]*/directory inode XXX/g'
-- 
2.45.2

