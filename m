Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B29281AD7
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683251; cv=none; b=T22dJglajpssmpFQl08trhtZ8lurGY0C//efFd2tNEVDGm7yXAvz8d3ZZ04D1aNL3mDfzWzYPTOQv9BlxXm1lrA+9cM5a7vCajU2B+wrq+n4/g1gVrDC6mUZVnDQTXePc8U9C65+vAYBDXKXsdZ+iJ+MWH3LKvSqfqmAaupSxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683251; c=relaxed/simple;
	bh=aYEaPH2/GPxJy5HfbWhE8f1jypLQ/lAIGmOi545jRaA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjzGgw9kePSUwxqkpJ1loEg4HXc5VlcQHsdDfJW10nu+/GA2fPXVMF9wmf7saraqYOoSqJsQVbzMdLa/9rfzmq2sZkLAqbdcFwodO+pyZraxuF1R7RtW2z3u/2LGSCB5zXJAgxSCHLvCGANfMZwMIglSlqhaDC+lyrO4ZjorCAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xwiqWxph; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xwiqWxph"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ea8b039ddcso5031366a91.0
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683249; x=1733288049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeZOo8eRbqCOh+Mr/WJaGp44XzlkeOAdFufROtEXAM0=;
        b=xwiqWxphkVRxvnwxsPqr/mL0I7Aw1fhD70ClbhBdLi0R0NmGQvQS1fM/3PnK3+ABIu
         txJpgG4yPS0JwipiVIE0GmEQLjqxCSNYazSRUit3vg3X3UHsGWaq2UyoMyDBgU1sOmQ3
         /ddtgmYHK4C45m/U7NP7ANXxCZt5hEPG5LopId44vrFuV2YArRCF97+iXXeAZ7o5BXgs
         8VF+0bee50D6+sly0cfVBNssJZWb5PB7j394LoB79fM6WFOjOYl0zsDJW2ZDgEkcm2ak
         x/ELuBc10o7uf9E8J4mqTZeetaW1hKZiV87U1tefs+4/vEmv1p0RF7xiVbIueww1XvzU
         8iUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683249; x=1733288049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeZOo8eRbqCOh+Mr/WJaGp44XzlkeOAdFufROtEXAM0=;
        b=QPDMFkYnrLudkk7fFcX4LdY8yz6fp/84tNSFzW3Yqsybpl5Esel/ZmOtXW+Rgt34rh
         VpxekAkdmqrYlJ0V3mhuf+xolzsKt1YUWGYQsZQuYIr1VRTU59m915w6XzaHYATx3umf
         FLX1aoLI5ByA/ANVKUOR4SKMmz75YHGXWpz5CNcvh0CDM0JwHsaEaqusgl3GJwsIlMvT
         IiThIXMDs7S7npd6vTfPZGjYCrfC8A+Pgvl4tU9y8QlGqOND+puVl3ITE/sHVo/0jcZU
         lgAZ1nAqHEZNpYuVMLrxChEQYMULpVv/jpnKrxkZt1HQ9Yl3l7zq5EBaOo9wVjowQHRc
         mEZw==
X-Gm-Message-State: AOJu0YxRD62Nh0JqhiANdDQNURv54XaEjA86gkkwuGjSlN7gLq9Y6MCz
	ZtaBr2Xp9w2WsJBdvoB5wFw4sZFG5bUNbBX4qDFjEaG1Ld51rDDs+SFcxW3oL4yu7w0AUv/a1z+
	i
X-Gm-Gg: ASbGncv1tukTpAVfyZzlnp6LlFv/jG6J7Ky+BkJX7uzb1PFQ8mCG+lqmN+WXcMh+MuU
	P/muKirnaRjTUiQpwulaRn8eSIlyja2gpWkOqrH2pmcxJy9ncAGW3TopJfJQG5Z7tvIh+sCp/ra
	Thw6pypQb/wRwce2ChjNIXkZnYVocKsGcXAPKfSK+Pmohj5IUhVAbPB9UpqXZphyY3YcTpKCxgu
	rxS0ZoC2X8Nt2jk0f2YwoNaL6eEBbJ5W7miO/y0JwK34ubM3LkxZ6ruTDJRQSUmpOMqnbXMkAx7
	unjto18HuGfvkjH5Ic4InX8A
X-Google-Smtp-Source: AGHT+IGeoxkeF/7zq8x8mJdCpZOJwzug8hm3ywWmjopnYR1+shseKw0uBoZzoZx6XLpwAe9sc2j/Fw==
X-Received: by 2002:a17:90b:1fcd:b0:2ea:3f34:f1a0 with SMTP id 98e67ed59e1d1-2ee095bfef5mr2463280a91.30.1732683248788;
        Tue, 26 Nov 2024 20:54:08 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa9951csm490165a91.34.2024.11.26.20.54.07
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:54:07 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3w-00000003ZUC-3jBF
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQdu-00ld
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 06/40] fstests: per-test dmhuge instances
Date: Wed, 27 Nov 2024 15:51:36 +1100
Message-ID: <20241127045403.3665299-7-david@fromorbit.com>
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

We can't run two tests that use dmhuge at the same time because
the device name is the same. hence they interfere with each other.
Give dmhuge devices their own per-test names to avoid this
problem.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/dmhugedisk | 19 +++++++++++--------
 tests/generic/620 |  1 +
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/common/dmhugedisk b/common/dmhugedisk
index 502f02437..0757e1908 100644
--- a/common/dmhugedisk
+++ b/common/dmhugedisk
@@ -4,6 +4,9 @@
 #
 # Routines for creating huge (fake) disks
 
+export DMHUGE_TEST="huge-test.$seq"
+export DMHUGE_TEST_ZERO="huge-test-zero.$seq"
+
 _require_dmhugedisk()
 {
 	_require_dm_target zero
@@ -20,26 +23,26 @@ _dmhugedisk_init()
 		chunk_size=512
 	fi
 
-	_dmsetup_remove huge-test
-	_dmsetup_remove huge-test-zero
+	_dmsetup_remove $DMHUGE_TEST
+	_dmsetup_remove $DMHUGE_TEST_ZERO
 
 	local blk_dev_size=$1
 
-	DMHUGEDISK_ZERO='/dev/mapper/huge-test-zero'
-	DMHUGEDISK_DEV='/dev/mapper/huge-test'
+	DMHUGEDISK_ZERO="/dev/mapper/$DMHUGE_TEST_ZERO"
+	DMHUGEDISK_DEV="/dev/mapper/$DMHUGE_TEST"
 
 	DMHUGEDISK_ZERO_TABLE="0 $blk_dev_size zero"
 	DMHUGEDISK_DEV_TABLE="0 $blk_dev_size snapshot $DMHUGEDISK_ZERO $SCRATCH_DEV N $chunk_size"
 
-	_dmsetup_create huge-test-zero --table "$DMHUGEDISK_ZERO_TABLE" || \
+	_dmsetup_create $DMHUGE_TEST_ZERO --table "$DMHUGEDISK_ZERO_TABLE" || \
 		_fatal "failed to create dm huge zero device"
-	_dmsetup_create huge-test --table "$DMHUGEDISK_DEV_TABLE" || \
+	_dmsetup_create $DMHUGE_TEST --table "$DMHUGEDISK_DEV_TABLE" || \
 		_fatal "failed to create dm huge device"
 }
 
 _dmhugedisk_cleanup()
 {
 	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
-	_dmsetup_remove huge-test
-	_dmsetup_remove huge-test-zero
+	_dmsetup_remove $DMHUGE_TEST
+	_dmsetup_remove $DMHUGE_TEST_ZERO
 }
diff --git a/tests/generic/620 b/tests/generic/620
index bf97328d1..3f1ce45a5 100755
--- a/tests/generic/620
+++ b/tests/generic/620
@@ -47,6 +47,7 @@ testfile=$SCRATCH_MNT/testfile-$seq
 
 $XFS_IO_PROG -fc "pwrite -S 0xaa 0 1m" -c "fsync" $testfile | _filter_xfs_io
 
+_dmhugedisk_cleanup
 # success, all done
 status=0
 exit
-- 
2.45.2

