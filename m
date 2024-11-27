Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B62C13A899
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683251; cv=none; b=CwGweJKVdOSc8Yzl4Xj9IFqG50JslIdTQ8a+G52xAxTXxNWa79XjY0r0WWpJExZYOqETv6iR9ccA5+QhL0W/5ncCroGZAQQ5x4i+erZisl/rPBg+rHpARpyXl15j2lGnzoMLmQoFptN5VPb3DN7zTmYjJTlDjmUsg9fvsmJBJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683251; c=relaxed/simple;
	bh=urXtjPN7x3KgjxaFASLjGM4sO3guAuua/An+IgQ+v8o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCuDhgkI0POrUcBxx00dpuuhCwmG8XOq7hTRET0+l/T8FhfweEHazJb2oLcf/Deleu2qY+FZcOopbHj3YbH/I5/lV2/lISIPrkaGE2DV2SlRhyocwaTzFR1d3GZ8i9Oh+9V8NIiU1FWyMN2b+6lzh+RldBVhoWYcMbF8lDdp8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=aTNStqx3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="aTNStqx3"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7eae96e6624so4959199a12.2
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683249; x=1733288049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aYUvNV0CSbt1n5IbjmJUMv5LqmwReocYnG4276zIaQ=;
        b=aTNStqx3aGALKLkhyhG3V4om09JdaXmvOggkLfwUOrIHkVgqYCu+YJWoWFwushOw/G
         BOvKdVC2KTl4qYIIEohdFQb5t+EsiVU8QkbjnrUWsGTY7bqRU8S2N76e7IDIwPefFScv
         HmzKCmZhVxhsnNuV9An/rQrizKBdOS+eLJePhflrRzvaK/KuwibHICQVTeQ5aL9gOV2F
         aGgZfjItMzfyN61DNQ7VUX+FBO3FE8Bhi6kGxqa469mv3o92s2hVqpDuY6hsM+2cCb0k
         /TStgXfyvisg8SWUBFPjh5JSsd7xOTMn2nzIit4fj4F2/ncQgFK+4iBhtJhsJ3UYQ5Bz
         z23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683249; x=1733288049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aYUvNV0CSbt1n5IbjmJUMv5LqmwReocYnG4276zIaQ=;
        b=mK4O8eJCE/1m0aB/XHyOKDjfJ1wRGwbXlmcd8mmHEywCYz5cDv84P7CUxFUNeKlGmB
         Rjjlf845D/R0umK/RRbJdWhf/5R0jJOEb3+dlIEIDTDuJT1xEejgNl74QkOPioB+3Sf0
         osQWDyg/bJIOE3ut5bHpShlc1t69GXA1hrmy6JKgjoOqX78ujzStPLc43fMgxCNR2GUN
         CC4hCmur8x75ZFUBuze7u5kr6ao2TJvNhGsQdRSa0Av+H/OcqenkpjO0L77HEklAr2aF
         kQemmKf0yaaoft600MMHXLFPIaFjw9rqBvP11BSZwLFdv1F9o2QWN0FTV4E8Ik4koYxF
         VnDw==
X-Gm-Message-State: AOJu0YwfqjIB1IGcmkENpNuwLuLCouXpO0JCMYcIgVxS/tBSlD1PYIHt
	tmBxtT+ssed2cvgqEOdWjNYMjrDnzYE101MAPLyEn9RML8w0VaPqExxAKk8eXa5OzAOmH49otgA
	W
X-Gm-Gg: ASbGnct1exGUy5TE4a7IFBJ5Mju+Mb/jHTZGVL++TmchUIC4Sy9tmxBztaB+OsTn3MV
	FKU1t1M2PR74kKZkArKCGpGXebhSWZcgkvTp3w9/WHMAQDrwLGTcQjXtrzvP5ZBfVTW5FCK0BeO
	kVBO3Cf6ufs0u81NyNtIR0Sj3WRjfblnNoHlSTUvPrNwGG0eVakZOpdKMThuzuZQf9atzTkh31b
	nYOltxGJalOfJIIolLF7h50hSpUNSHVnbzmq/D/5CezF+C02QhRhOc2EeurT3Gl/RwfyiU67XZu
	ao6b7y8xJdr2VfXmD6z705Ap
X-Google-Smtp-Source: AGHT+IGebmkvaiob13ei2AVo8oGoCUVLDalhK34KRIutvNsnDDG0UFQVAKDFVX/Jd2RQsKWNyv6H2A==
X-Received: by 2002:a05:6a20:4303:b0:1e0:da2f:9dc2 with SMTP id adf61e73a8af0-1e0e0c033dbmr3611137637.40.1732683249558;
        Tue, 26 Nov 2024 20:54:09 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa5fff0sm488629a91.21.2024.11.26.20.54.07
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:54:07 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3w-00000003ZTy-37tb
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3w-0000000FQdf-3gKZ
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:04 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 03/40] fuzzy: don't use killall
Date: Wed, 27 Nov 2024 15:51:33 +1100
Message-ID: <20241127045403.3665299-4-david@fromorbit.com>
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

Having test cleanup call 'killall xfs_io fsx xfs_scrub' results in a
system wide process kill, rather than just the processes the test is
running directly.

Make sure we only kill processes the fuzz test directly owns. We can
do this with 'pkill --parent $$ <process names>' to limit the search
for processes to kill to just the children of the current process.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/fuzzy | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/fuzzy b/common/fuzzy
index 9181520a3..3a7f04aae 100644
--- a/common/fuzzy
+++ b/common/fuzzy
@@ -1145,7 +1145,6 @@ __stress_scrub_fsstress_loop() {
 _require_xfs_stress_scrub() {
 	_require_xfs_io_command "scrub"
 	_require_test_program "xfsfind"
-	_require_command "$KILLALL_PROG" killall
 	_require_freeze
 	command -v _filter_scratch &>/dev/null || \
 		_notrun 'xfs scrub stress test requires common/filter'
@@ -1178,7 +1177,9 @@ _scratch_xfs_stress_scrub_cleanup() {
 	# distorts the golden output.
 	echo "Killing stressor processes at $(date)" >> $seqres.full
 	_kill_fsstress
-	$KILLALL_PROG -INT xfs_io fsx xfs_scrub >> $seqres.full 2>&1
+	pkill -INT --parent $$ xfs_io >> $seqres.full 2>&1
+	pkill -INT --parent $$ fsx >> $seqres.full 2>&1
+	pkill -INT --parent $$ xfs_scrub >> $seqres.full 2>&1
 
 	# Tests are not allowed to exit with the scratch fs frozen.  If we
 	# started a fs freeze/thaw background loop, wait for that loop to exit
-- 
2.45.2

