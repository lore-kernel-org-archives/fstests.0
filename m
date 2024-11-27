Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD99F13C661
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683252; cv=none; b=IsnSE8jBJsw3Y0/0mxwlD0Yxymnmb0lWzxIJgOOFkIMV+pq0VM21mKOclHjRaYNl6O8qk5GcgyU9izA4m8n4m8vd1oB9QZ0Gk8gjIr+pMl8xKLRROQFlzgUoTUnO7zZi3VYNTE0xniePcrWhY0dOahEJzSAVE6Rc3D125KVSKjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683252; c=relaxed/simple;
	bh=31+wezODfv0pTVCSdQQRtcm73s3T0h84iczEtGnaCc4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUV8N7WWYxEpWURGxCEgq7UKUK24ruzQxUFdPm7xvO0Lt+/gOBUNV+5nOyV6Q425kaFD4oNlz3IXjOkTXexq2bZqCFvcYU6dVPqqv8p4+5OvyoR6ImyCYwLo4YR/yRKc6ZWfFkKt2utuTQZLCMWiR9MGpJS+oHUjRLIMK///AA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=J++egDDh; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="J++egDDh"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ee7e87f6e4so5249936a12.2
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683250; x=1733288050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wy4IS/iZefcF4rH2xy70XIUO1t1F2MTEdWON+Bkp0Yw=;
        b=J++egDDh/LbVtsYy1Rmb4rSgL9TN8IBLW2mjYRytMTXKU7Vgs0gooib0P+PKRu/hOg
         BOKPyrkJR272bsyS5p4uSkYtcyU8aOfOml5NWaWlXP4IOaKzKaE3Lml/u0IDjwA66zmN
         sdwMpROquby+g6SRmKMpqw/UivV3q60PRYv/rUbHnzneJ/2gdhoLMwhkk729aoq9NYmn
         JMHFVggLnQ6REmFLs86+zPJIFotu9zzsCulYdP26+zjzazFI6UNbFxC2PdseJuL1/Qdt
         uuTWRRypdisqCPz1ngFSWLWLJ+4eaDMvNMvyzl9eTN42FS0TxSIqkyYnYnx708mbOZiY
         Wchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683250; x=1733288050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wy4IS/iZefcF4rH2xy70XIUO1t1F2MTEdWON+Bkp0Yw=;
        b=VpHjL/ETbykHPKjXJshWe1ecpoDyEPwsSsWoOxxIsjOFr/pAe0EKNcmw/oJjvzd38W
         qBVuWlNR59Hx0TRQo9U8lRxSZZVYI+t7mFSUJrJmqelfbhRRLHtfwCNWq1iAiz3T5+12
         sGlmoRcHEwPRXcjvuHKPMW7dlQmeEVBa238oJmPRAjdGfln1J0mqGGFVAKIjz7a9RSFe
         1pWL1g0pW6PpBnjVD3iBccKWfj16mi9FFvNm+5F4mRYzos0xlznR1eAc26LuRJ7qpm7J
         upqQje4vFTId69QeNNqXD5qczyVHosMbHwTJNXA+big+0xTxU2YiTlPP0C5l3G9d5wFC
         e51g==
X-Gm-Message-State: AOJu0Yx9+012wHpISxxpGNeINXx2xgJniAp7cq+ByC8Ns8aWm0roG+ZR
	9FOoEfoSM4QV50OZ4PkFfIMenVF3m4vIiY9cHvdyO5j3qPXlKHJiyB1XIwfxwDg5fjlPGU27p86
	V
X-Gm-Gg: ASbGnctu8dw0RA2IB4m+gzXqvgovtBAAh0phlnXjViycMwgby+584f0DrQdYvTbShF7
	9wLR2DLYcNI+cWHE6/kB4rK5YQfvykRq1E3av8aqnYTuQcnbGvBLkAZ8o5Msdx3YkrBasOsl1o+
	CLhvZoZV/Sifb+l8kvB7cwmLaRoe7rabveEN2+Qunwgh6NTdpjPiixZT1ckuSjTsJStJA2Vf4B4
	Z0YWLir52BLunU7DlaUuk1CWCtO8PI7Xv9x8OLd2wkbqeV7AtIh874ayeaVleTaUhTij1p8x9aE
	itgVOgPTKRaukkPUAPCjOfSh
X-Google-Smtp-Source: AGHT+IFf1BmplZBCtZWk7NMOSgQxXOix6eRIKl2JgaCvqQWYOWG0d8UcN/ndsGxkAdLAcBIOYodroQ==
X-Received: by 2002:a05:6a20:9f96:b0:1e0:da90:5f33 with SMTP id adf61e73a8af0-1e0e0b2352dmr2489293637.25.1732683250010;
        Tue, 26 Nov 2024 20:54:10 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de531247sm9566243b3a.104.2024.11.26.20.54.08
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:54:09 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZVU-2lxT
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQfY-3L2o
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 26/40] generic/310: cleanup killing background processes
Date: Wed, 27 Nov 2024 15:51:56 +1100
Message-ID: <20241127045403.3665299-27-david@fromorbit.com>
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

Use the trick we used with fsstress of copying the binary to a test
specific name so that we can simply use pkill to reliably kill the
background processes this test runs. Also use SIGPIPE to avoid
bash from throwing out "Killed" errors.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/310 | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/tests/generic/310 b/tests/generic/310
index 1ab81dd2e..52babfdc8 100755
--- a/tests/generic/310
+++ b/tests/generic/310
@@ -29,11 +29,8 @@ _begin_fstest auto
 # Override the default cleanup function.
 _cleanup()
 {
-	if [ -n "$readdir_pid" ]; then
-		pkill --parent "$readdir_pid" t_readdir > /dev/null 2>&1
-		kill -9 $readdir_pid > /dev/null 2>&1
-		wait
-	fi
+	pkill -9 $seq.t_readdir > /dev/null 2>&1
+	wait
 	rm -rf $TEST_DIR/tmp
 	rm -f $tmp.*
 }
@@ -74,6 +71,8 @@ check_kernel_bug()
 
 RUN_TIME=$((30 * $TIME_FACTOR))
 
+cp $here/src/t_readdir_1 $TEST_DIR/$seq.t_readdir_1
+cp $here/src/t_readdir_2 $TEST_DIR/$seq.t_readdir_2
 SEQ_DIR=$TEST_DIR/$seq
 mkdir -p $SEQ_DIR
 for n in {1..4096}; do
@@ -82,12 +81,11 @@ done
 
 _test_read()
 {
-	$here/src/t_readdir_1 $SEQ_DIR > /dev/null 2>&1 &
-	readdir_pid=$!
+	 $TEST_DIR/$seq.t_readdir_1 $SEQ_DIR > /dev/null 2>&1 &
 	sleep $RUN_TIME
-	kill $readdir_pid
-	unset readdir_pid
+	pkill -PIPE $seq.t_readdir_1
 	wait
+
 	check_kernel_bug
 	if [ $? -ne 0 ]; then
 		_fatal "kernel bug detected, check dmesg for more infomation."
@@ -96,11 +94,10 @@ _test_read()
 
 _test_lseek()
 {
-	$here/src/t_readdir_2 $SEQ_DIR > /dev/null 2>&1 &
+	$TEST_DIR/$seq.t_readdir_2 $SEQ_DIR > /dev/null 2>&1 &
 	readdir_pid=$!
 	sleep $RUN_TIME
-	kill $readdir_pid
-	unset readdir_pid
+	pkill -PIPE $seq.t_readdir_2
 	wait
 
 	check_kernel_bug
-- 
2.45.2

