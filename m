Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329024689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683563; cv=none; b=mPydigYKFH0gke8m5V3m33BijH2Z7FqtL8VUFH7zhSdePSPTVnFjucaOUugxdoS+AesHvuZy89FtPbGzkkh4qSykJfooDPYRS1+PPIwunROge7xHLmgzwHfUDEXPv4HPJ4wNXjdR8Nz7wPQiygP7Rb2JxvxLJLLTg4O+SHIrqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683563; c=relaxed/simple;
	bh=8F3ahj52RLuFFYcpclQOTqaI1agSd8O2tSilTsS3lQ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlYpgbDp/IPgOpp92wT5uegbn+Em2s+RL+2QLO6oUTmDIA3i7zOp1jwlc7sleIFMNhxi3YKfwnZUBe1Y/W8AKZwPDzf9qXzV5dVmJN5NU3jbWSMk5ADBzddfNENvw1rXV59F9ejzvWs/vinVGHFHDYIEJVStIVbB+bYhFjKFh4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=i24n/JAF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="i24n/JAF"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21207f0d949so60715145ad.2
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683561; x=1733288361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heLgL7p4r4D/esMWLUmlF6hx36ceCs2TRfNR0C6IBB8=;
        b=i24n/JAF6Ak0shmtdGlJlzRhcrlJ5yTaAeNm47BVjJAo6v8wFDpWByY1AvElTIxJ+K
         iC7lRHXLI1yqKVMOmWWLUIEtLAtqOwppVG/yOBCSJoU9s3Tdyv95LxHZ1ApYyAbLo2vi
         BcQzBHSWgkd7UojQye4XuO6dGVMa/UVGnL5OJ+hoGiSvn2d8O6fYaR5eKbBX5HK1G5Mc
         RVttl5jmqqqn8xxz7mTBvI5yibbE9WCdpMVGMg9qSM9JW9a6ZHouFpmBmJCxtXo9egIL
         h55FOAfoTtMxiYyLu7yj9rmckbfu7yHd7yUBqIBZp3BLApTYE3G3L4/mKd/38kNcKF1o
         5DmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683561; x=1733288361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heLgL7p4r4D/esMWLUmlF6hx36ceCs2TRfNR0C6IBB8=;
        b=X1mRXCD4tYlgP2+C8cCcpYNWmWCblv7oGDwBBEixZJ3MTgs88oU0w8GXOeohTuWyoY
         sfz/MbeEExY88huFWjlH+DiHFSKRRgf+B1d3BIO8o1z3aJmyGqgNjU2SKFFx50/h4l/g
         FIbToAHwunaxD7LZAOef45zA3c5pg/WUNRqVnfFKPyJf7IfVdPeXiTimC5swkBoTWSLL
         pk62Sv/ovN+GvrksThXdMmlhh3N8FTGuUofeeMHzo//95Rt5pHaMCzO11ylf1/pyG2ux
         qYC7A95B6ERxUkMgrYX2TQMw//jaFokBdy559hD9dpvSkLGgHEFp5Mj17/GAwySE4lwO
         N2gA==
X-Gm-Message-State: AOJu0YyTGMvUStR5LIG0gdqu+v5+kGRxiu/4HN1OYle6pjWupg+tjB8t
	mlSgx3T9B6x8yCFIDdKLuA6SjJo4spadxFGwhaN/aCaWvTT8HlajkOQXAPgQp7Pfvkn/V/mJX8X
	t
X-Gm-Gg: ASbGnctiwaGk+2UORYMzystrHFe3sp9ZMX/i348Ef0Z4geuWge47KtviQcHwJgRgfuf
	uilPLMVFPlfzP78GokhuavdY8UDd+DmHJDzZIxGq/U/rxcqQMApbokseXfPM2DTRinzWvUHdkNN
	V44xeO0OxLWB7GK3RXvyrsWCgaACFuMPE0gyOciS7biH+T7ik8KI6Qke9ZwerelY5MZyr2w1CXi
	48/ejPpXsn3CPeDjO9frtaiBFO3BwlwTnG0kkHDVY1SlAFdfJnuuULiNVsHk37H8OBZj5TyL5k0
	o0U2UkyAJojcmA==
X-Google-Smtp-Source: AGHT+IEVOF96wJZ90spLA5OvJhf/aYzgbJhHfn5iQ+ARBIyFBqlNwKFxdwkD0HsYcq9ygBn2NzKTfg==
X-Received: by 2002:a17:902:e810:b0:212:5d38:b45f with SMTP id d9443c01a7336-21501085456mr23879215ad.8.1732683561529;
        Tue, 26 Nov 2024 20:59:21 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc208b6sm93590565ad.229.2024.11.26.20.59.20
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:21 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZV1-1nuE
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQez-2N7w
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 19/40] xfs/177: remove unused slab object count location checks
Date: Wed, 27 Nov 2024 15:51:49 +1100
Message-ID: <20241127045403.3665299-20-david@fromorbit.com>
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

Stale code; we count XFS inodes through the sysfs stats code now
so remove it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/177 | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tests/xfs/177 b/tests/xfs/177
index 22719ba1c..82b3ca264 100755
--- a/tests/xfs/177
+++ b/tests/xfs/177
@@ -58,13 +58,6 @@ dump_debug_info() {
 	echo "round $1 baseline: $baseline_count high: $high_count fresh: $fresh_count post: $post_count end: $end_count" >> $seqres.full
 }
 
-# Either of these need to be available to monitor slab usage
-xfs_ino_objcount_file=/sys/kernel/slab/xfs_inode/objects
-slabinfo_file=/proc/slabinfo
-if [ ! -r "$xfs_ino_objcount_file" ] && [ ! -r "$slabinfo_file" ]; then
-	_notrun "Cannot find xfs_inode slab count?"
-fi
-
 # Background reclamation of disused xfs inodes is scheduled for ($xfssyncd / 6)
 # centiseconds after the first inode is tagged for reclamation.  It's not great
 # to encode this implementation detail in a test like this, but there isn't
-- 
2.45.2

