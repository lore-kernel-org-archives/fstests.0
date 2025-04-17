Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83651B393D
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859537; cv=none; b=nGQRHexCzI371QMaXfIrYqPnm2bTu9VUwjslHXTr/6UpnXXNBTka4/daVKp7fk9X1KcXCgepIQpmea9SksPVSI/J9L4WN4NGFSKIhcqPox/6HGN0qxGIbwP1G3h0n8sH6HWGTZRj6K49ybNblxmv0Ue5918I6Mdad/lHCLrw4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859537; c=relaxed/simple;
	bh=3+DyxpX2nkoW4MKE5n0o/Gcilcl4B80tjl1FMubaJEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XL8Xu2+SFk+Nji11TIz+YRteiXqEBSzHGw6qocb0v3QR7o3XcnwUxcFZJniTao+ye0MDNMLgdx+tXLMiPrYO5Q9vX5/LVCU/J42zdlEsPSJl+PbbdFppGszbKWb9c1m2QVtbJKIbtGLJmnUFq4YB8F/jyz7lnSuFHQ/15Muylkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=TjvmrxVQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="TjvmrxVQ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22423adf751so3666255ad.2
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744859535; x=1745464335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1f5PaAiM3/o9MBO+2dWyYZe0kMsen24Kl4YPM7oALY=;
        b=TjvmrxVQIvTtir//4FJ94Uf5cwGUNETlEuUmSmZmUAssoxCmZRR8vWOuYR86Wim83l
         1HbKMXptiqZt2X9peLFnC6IPEBk4kiGMTA5y5c6Wgq6N5/6HxLa12ozHLsRCo6xcoIB5
         QkqLVzWExpO4Ik8zdibddrAffSpQgQtAbQdGPS+u3hRBIwA0TCwa4Divf6YrEyyLn8R4
         duNGtFmK3afcUNeB3sEjqfo81vyccLTKc15JwwRLClzw1iVR9krV4uYA3txLPHPr3Xdk
         7nN921mFJSjyuwEiGK2GY3iCqxkt+HSmlT03q0I7wfIbBeTQE2sCc3moCEi4yQ/9ok9t
         vKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744859535; x=1745464335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1f5PaAiM3/o9MBO+2dWyYZe0kMsen24Kl4YPM7oALY=;
        b=HvUAl/9scGgqIbL6s37Kt5Tt9fXWdQ3AQgMFdpqxfEmFyDjQtPIcfi3aT7KbQAdKxk
         zVjokLfZT34KvK/+PuQxqBnBWzCV5rdNDBZTrZeR5ma3nY997wboGbN7dOtnvpNrrjhb
         BO87277NqoRfyo1dxvKEjVQIXmdB0K5Gz6ltVSup79bCEgU8lfA1hcEiNhKObsPbrK46
         +S7nf1k13t6V+XvLck2CzossXjafYyA5suspEABdOnhr6F/x2Y4NOSAEWZ2W9I5IgfZq
         0g1+zwK+hxIAcLhJu1QG+YvKKnCNR+O/9j98BTa08xrDrVwtHGM1T7AS39fsWj2zXDRS
         txAQ==
X-Gm-Message-State: AOJu0Yzfxm/vFysN/pR4zBiI0LjuegTeA5LPMnC1thqiTBxkDYy2d+m6
	Q/z/jLDXtaYiOOM46ITrY9oKDd00L6o65VvA+ajen1jjByt6Fut4h6A1AVwWfhFhkO2k+8duE0B
	r
X-Gm-Gg: ASbGncs3Hv1Zzkeu5LManbxNwYz7d433kL8Dbbw6bVZkX7LGg/mUOF94rIRCusdSoZr
	RsNGYxnXLNPOhrpJvH5z+8ekmd2JxccMKSB2RhHqEFb5hkKfct1ZnpcbYWeJksc3Vt/a/J1F40w
	Qtrl/1iU635WoAEk64/3EC4ejIREWu9nFHOJ0SMDel+0ErTrwk7QyPM/nDUnQB8LSbLjw3qN+jz
	HdSy46ZYm3eNQYK/neJ+YSRz4FeyUC2Ta5tjKxJNw6/MQePZv2VJoAhxWPbl9HjkPlD4zRe9KGG
	+tyl1ve5smlRA/CoWmeaYH6BP072OKWH0rpUVnm3s5JT0tWNDowGpzQ/hMyZX9l4Vheh8M+tRPk
	vSHNttBIEO9we
X-Google-Smtp-Source: AGHT+IE1tanE8nDI10aO4hw2NuUVWia2prbfyjqr5uBda7kOZZLAUmx3h0aIxdelag4vfyBrYdDOfQ==
X-Received: by 2002:a17:903:2383:b0:229:1717:8826 with SMTP id d9443c01a7336-22c358fd48bmr71172615ad.28.1744859534880;
        Wed, 16 Apr 2025 20:12:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fe6aa0sm22423955ad.222.2025.04.16.20.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:12:13 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YA1-10cm;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mEj-1qfY;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 11/28] check-parallel: initial support for specifying device sizes
Date: Thu, 17 Apr 2025 13:00:52 +1000
Message-ID: <20250417031208.1852171-12-david@fromorbit.com>
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

Rather than hard coding loop device sizes, abstract them out into
environment variables with defined default values. This allows
a check-parallel wrapper to specify sizes or, in future, for them
to be read from a config file. Sizes are specified in human readable
values using M/G/T suffixes to indicate the units being specified

Whilst doing this also add support for creating all the external
devices that XFS uses during fstests execution. A typical setup
will be something like:

TEST_DEV_SIZE=10G
TEST_RTDEV_SIZE=10G
TEST_LOGDEV_SIZE=128M
SCRATCH_DEV_SIZE=20G
SCRATCH_RTDEV_SIZE=20G
SCRATCH_LOGDEV_SIZE=512M
LOGWRITES_DEV_SIZE=2G

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check-parallel | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/check-parallel b/check-parallel
index aa88c681e..5bb44b6a5 100755
--- a/check-parallel
+++ b/check-parallel
@@ -18,6 +18,14 @@ run_section=""
 
 tmp=/tmp/check-parallel.$$
 
+TEST_DEV_SIZE=${TEST_DEV_SIZE:=10G}
+TEST_RTDEV_SIZE=${TEST_RTDEV_SIZE:=10G}
+TEST_LOGDEV_SIZE=${TEST_LOGDEV_SIZE:=128M}
+SCRATCH_DEV_SIZE=${SCRATCH_DEV_SIZE:=20G}
+SCRATCH_RTDEV_SIZE=${SCRATCH_RTDEV_SIZE:=20G}
+SCRATCH_LOGDEV_SIZE=${SCRATCH_LOGDEV_SIZE:=512M}
+LOGWRITES_DEV_SIZE=${LOGWRITES_DEV_SIZE:=2G}
+
 FSTYP=
 
 . ./common/exit
@@ -116,7 +124,7 @@ while [ $# -gt 0 ]; do
 	--exact-order) _tl_setup_ordered ;;
 	-n)	show_test_list="yes" ;;
 
-	-f)	is_supported_fstype $2 ; FSTYP=$2; shift ;;
+	-f)	is_supported_fstype $2 ; export FSTYP=$2; shift ;;
 
 	-s)	run_section="$run_section -s $2"; shift ;;
 
@@ -243,22 +251,35 @@ runner_go()
 	local id=$1
 	local me=$basedir/runner-$id
 	local _test=$me/test.img
+	local _test_rt=$me/test-rt.img
+	local _test_log=$me/test-log.img
 	local _scratch=$me/scratch.img
+	local _scratch_rt=$me/scratch-rt.img
+	local _scratch_log=$me/scratch-log.img
 	local _logwrites=$me/logwrites.img
 	local _results=$me/results-$2
 
 	mkdir -p $me
 
-	xfs_io -f -c 'truncate 2g' $_test
-	xfs_io -f -c 'truncate 8g' $_scratch
-	xfs_io -f -c 'truncate 1g' $_logwrites
+	xfs_io -f -c "truncate $TEST_DEV_SIZE" $_test
+	xfs_io -f -c "truncate $TEST_RTDEV_SIZE" $_test_rt
+	xfs_io -f -c "truncate $TEST_LOGDEV_SIZE" $_test_log
+	xfs_io -f -c "truncate $SCRATCH_DEV_SIZE" $_scratch
+	xfs_io -f -c "truncate $SCRATCH_RTDEV_SIZE" $_scratch_rt
+	xfs_io -f -c "truncate $SCRATCH_LOGDEV_SIZE" $_scratch_log
+	xfs_io -f -c "truncate $LOGWRITES_DEV_SIZE" $_logwrites
 
 	export TEST_DEV=$(_create_loop_device $_test)
+	export TEST_RTDEV=$(_create_loop_device $_test_rt)
+	export TEST_LOGDEV=$(_create_loop_device $_test_log)
 	export TEST_DIR=$me/test
+
 	export SCRATCH_DEV=$(_create_loop_device $_scratch)
+	export SCRATCH_RTDEV=$(_create_loop_device $_scratch_rt)
+	export SCRATCH_LOGDEV=$(_create_loop_device $_scratch_log)
 	export SCRATCH_MNT=$me/scratch
+
 	export LOGWRITES_DEV=$(_create_loop_device $_logwrites)
-	export FSTYP=xfs
 	export RESULT_BASE=$_results
 
 	mkdir -p $TEST_DIR
@@ -285,7 +306,11 @@ runner_go()
 	umount -R $TEST_DIR 2> /dev/null
 	umount -R $SCRATCH_MNT 2> /dev/null
 	_destroy_loop_device $TEST_DEV
+	_destroy_loop_device $TEST_RTDEV
+	_destroy_loop_device $TEST_LOGDEV
 	_destroy_loop_device $SCRATCH_DEV
+	_destroy_loop_device $SCRATCH_RTDEV
+	_destroy_loop_device $SCRATCH_LOGDEV
 	_destroy_loop_device $LOGWRITES_DEV
 
 	grep -q Failures: $me/log
-- 
2.45.2

