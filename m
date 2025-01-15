Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D01F9F5C
	for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920986; cv=none; b=WvMNEiTRqUdz+1OaZA+p2VPAi7zzoSEXm/+IuwB4tphS8JEff3dTLuTocYI1Hf7HQ8GuA4RW326NE01E601asil43wFD9JlK6tm52BB5N23xCtW2/0ZM4I9bPa36QMMjfmvtlpyIgZLrKnMKSDTU1xLsMvhuevegkQQet1t8ly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920986; c=relaxed/simple;
	bh=NQ1NVX7mDRpk3eFImqWLbKttBReOmTgfmygnEDXVKcU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJhE3+jCoWl4TjLtbE3m1PKnBgN91UA0rUr8BlQuua3BlOvlFn1SNxgXp8tblZdy6C/7W6p/jSHRKgn59dIVd5frAhTQxkkj9mhMZ2rWOW/H4LIYBOyyYUp/yVc/yRl3nRvT1UHpPjzA4ctSDJ+ppt26TlBcaGEBzKrgOTfAxA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Z4CKFn4a; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Z4CKFn4a"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21670dce0a7so137226475ad.1
        for <fstests@vger.kernel.org>; Tue, 14 Jan 2025 22:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1736920984; x=1737525784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDyM9C+bh4pg44LGWqVZr4fOonPK+G5ritIIjqyIkgo=;
        b=Z4CKFn4aq7qacoSwSbx7DhUKO5/cx7w35Q12NhzkPzSH/u6FbrOcs+B5x8EVCIgFbW
         WpIzf1P6VGlT6ywachZFYbzNiEiansJnEhvbMDR5L5fcbPVct0RnzjRsg2kEOrrQKXDR
         +JxOUb+ZYMYYnfB5UfaqphjbCtUVx3qrVfLEQ3FyaMgrGxkEGUtZtxlfb24bJTH7c2d/
         BddRnp7Z9LWMZLJbH1J3v75pCrl4OckaRwe44Dh/+A+BefyITWpKBsikogqp8nOwe/N1
         1FaMjZKHFM0HQG5AwyMVFa/xAUpukrN+/jkNOLeHJNGjl5FV23qGy6uZIXGemxsMrPac
         nB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920984; x=1737525784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDyM9C+bh4pg44LGWqVZr4fOonPK+G5ritIIjqyIkgo=;
        b=WzVNgrXH9S2fYg0W6piOcoPw26f7z0yPPVnbhx8n2FMQbjGAq+Yt+/HHpkcQQ7MgmC
         D+M+rfe8YEwKagGAnzOviUjB7U2evnsjn0d+9at5ItSWhC1zYDnJ+BC3oYc2fL9s47Gz
         zw071YAZqnLudOzp6VQYSMag58jQNtJviSh/fvC7AG9VZa4HdUHbw03BBzK3fKM3EUCZ
         qgaA2OE/eaNU6hk1yMtEZ8RbooWnrI0g0vMuKYXZL9dlodv1YpJiT58KFhx2PITbmWki
         CU7ibTnmU0pGQApTdNEzmxX70kOKS1+N5xvyKI6SLlBogz9PJ2f9i1sIoOSKPfP18k05
         qiwA==
X-Gm-Message-State: AOJu0YzWtEDxTdkd1WPj04MPNIJ/cuuDYwR80fqHaTNXSqQk35q/mLRO
	e8ZQxFDQXZDQy1sl7ma2gdCFbMnczeqPHlrAo0XMo1E9/INEm5EhF3/h9JGuU7lRlnd1CUCoDpm
	+
X-Gm-Gg: ASbGncvLZpkDJYHKAJnn8YbkO44N7WpS35bAx2swnahbuUkxoG2sfP1KPikTchQs1r0
	Ef6xvzMM5Oo8k5EAg2j+IA99KYsLIlcP0ZgeFTEGGKtNN0/NpY6cgbnpB77b9CGSK2nIksQy1F8
	Dm/oQCPKpO8/HL3szdBKS/26GeoVFl89XDTO+ZsRsqOKSsCXYJQLlHVayyDYjgIb4fK+1Jxp4fM
	ZtM26HLSLFqohd+yLqTbDU3iBSRQsLqojk+gNYf7m1EeuGlWwhVl1vNaTXIqUauQeMqp1EbDgHa
	Te2lHY5u3cMdB8d4W3zUrGP7LHXxZ74=
X-Google-Smtp-Source: AGHT+IEQzF6KjrbH9bb7HxEdgA+Kg03emAnemZVSnpBNFX+gk6mEpz8MEUTmGXbqgcmv02n/wn33ew==
X-Received: by 2002:a17:902:d481:b0:215:b01a:627f with SMTP id d9443c01a7336-21a83f48e86mr442042485ad.4.1736920983986;
        Tue, 14 Jan 2025 22:03:03 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10e2basm75162815ad.19.2025.01.14.22.03.03
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 22:03:03 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tXwUW-0000000641i-29Ga
	for fstests@vger.kernel.org;
	Wed, 15 Jan 2025 17:03:00 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tXwUW-0000000Gabd-31Ig
	for fstests@vger.kernel.org;
	Wed, 15 Jan 2025 17:03:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 5/5] check-parallel: allow FSTYP selection from the CLI
Date: Wed, 15 Jan 2025 16:51:16 +1100
Message-ID: <20250115060258.3951185-6-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115060258.3951185-1-david@fromorbit.com>
References: <20250115060258.3951185-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Add a CLI option to specify the initial FSTYP to test. If this is
not specified the the default of "xfs" will be used. This option is
different to the way check has FSTYP specified as check-parallel
has no infrastructure to support non block device based filesystems
and hence we have to reject virtual or network based filesysetms
are this point in time.

This patch only implements default mkfs parameter support for the
test device. Config sections can be used to override this as check
will then format the test device when the section that defines
non-default test device mkfs options is selected.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check-parallel | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/check-parallel b/check-parallel
index 498b53c5a..38fa4f7f9 100755
--- a/check-parallel
+++ b/check-parallel
@@ -18,7 +18,7 @@ run_section=""
 
 tmp=/tmp/check-parallel.$$
 
-export FSTYP=xfs
+FSTYP=
 
 # We need to include the test list processing first as argument parsing
 # requires test list parsing and setup.
@@ -35,6 +35,7 @@ check options
     -r			randomize test order
     --exact-order	run tests in the exact order specified
     -s section		run only specified section from config file
+    -f <FSTYPE>		specify the filesystem type to test
 
 testlist options
     -g group[,group...]	include tests from these groups
@@ -66,16 +67,39 @@ external_file argument is a path to a single file containing a list of tests
 to exclude in the form of <test dir>/<test name>.
 
 examples:
- check-parallel -D /mnt xfs/001
- check-parallel -D /mnt -g quick
+ check-parallel -f xfs -D /mnt xfs/001
+ check-parallel -f ext4 -D /mnt -g quick
  check-parallel -D /mnt -g xfs/quick
  check-parallel -D /mnt -x stress xfs/*
- check-parallel -D /mnt -X .exclude -g auto
- check-parallel -D /mnt -E ~/.xfstests.exclude
+ check-parallel -f btrfs -D /mnt -X .exclude -g auto
+ check-parallel -f udf -D /mnt -E ~/.xfstests.exclude
 '
 	    exit 1
 }
 
+# Only support block device based filesystems with generic mkfs support
+# at the moment.
+is_supported_fstype()
+{
+	local fstype=$1
+
+	case $fstype in
+	xfs)		;;
+	ext2|ext3|ext4)	;;
+	udf)		;;
+	jfs)		;;
+	f2fs)		;;
+	btrfs)		;;
+	bcachefs)	;;
+	gfs2)		;;
+	ocfs2)		;;
+	*)
+		echo "unsupported FSTYPE: $fstype"
+		usage
+		;;
+	esac
+}
+
 # Process command arguments first.
 while [ $# -gt 0 ]; do
 	case "$1" in
@@ -91,6 +115,8 @@ while [ $# -gt 0 ]; do
 	--exact-order) _tl_setup_ordered ;;
 	-n)	show_test_list="yes" ;;
 
+	-f)	is_supported_fstype $2 ; FSTYP=$2; shift ;;
+
 	-s)	run_section="$run_section -s $2"; shift ;;
 
 	-*)	usage ;;
@@ -108,6 +134,8 @@ while [ $# -gt 0 ]; do
 	shift
 done
 
+export FSTYP=${FSTYP:=xfs}
+
 if [ ! -d "$basedir" ]; then
 	echo "Invalid basedir specification"
 	usage
@@ -217,8 +245,6 @@ runner_go()
 	xfs_io -f -c 'truncate 8g' $_scratch
 	xfs_io -f -c 'truncate 1g' $_logwrites
 
-	mkfs.xfs -f $_test > /dev/null 2>&1
-
 	export TEST_DEV=$(_create_loop_device $_test)
 	export TEST_DIR=$me/test
 	export SCRATCH_DEV=$(_create_loop_device $_scratch)
@@ -232,6 +258,10 @@ runner_go()
 	mkdir -p $RESULT_BASE
 	rm -f $RESULT_BASE/check.*
 
+	# Only supports default mkfs parameters right now
+	wipefs $TEST_DEV > /dev/null 2>&1
+	yes | mkfs -t $FSTYP $TEST_DEV > /dev/null 2>&1
+
 #	export DUMP_CORRUPT_FS=1
 
 	# Run the tests in it's own mount namespace, as per the comment below
-- 
2.45.2

