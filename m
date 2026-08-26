Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598A3128CC
	for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759667; cv=none; b=gtcYLt76cXmKU0W7QTC6kAqWcLI96R+bog/HouHc1bKVT6kF9RBjP2yzULoa1bts9xNVqyBrao8RPUc1efIbTsa8vnSxO8QsMhM8rxwTTUBU6dfKKcJ5dXpAqEyS/NR5s4ipUcvs0bIZKc/Exo/cL2Jx877+WrOcY8dcOXtApG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759667; c=relaxed/simple;
	bh=+B8bLSKXLeIfCYJH3PW70BAyzHD6bTPP45EpR1KmA+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ggq6Kbi8Nk6M84Bv2rMunHCalUK/bbQu7chA8hYqr5TflCH0w5l42897DaxDTyj7CD5I7kyiVT9fIG2Sx8eijywS3LL5WVclhlISgf2zm72j+tlHY4dotwUYYzODQ1BvufvC8djDsGsdjL3F7oi5alG40bp3aXfznlMyV6EdO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XudhWNkW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XudhWNkW"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c25344a8c6cso26012366b.0
        for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787759664; x=1788364464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pFse/vYxtG5kld0lYEc5lD9aTNjYM3kCzlc1Lv8bCXc=;
        b=XudhWNkWlvLu/iqhv0mi91u4nMmXmD3Q5Z0k1RAXXgAG4gu4+s2J4Krw4HeNGOMbxP
         uHdYxC9Uw5xiloEgF2QjnW39JBXjTWf0SbLyEOpQ+JVv3dNtKUYl4nnr31gVvYn+GPaG
         LkKmtSLeK4noRREJ35q5XNA3avob0DUV+h/NMAcgSrL9nI1eWd7H2Az+N5n6xPG1C3kQ
         VHH0vPwZEYkB8B4Rs3fi5iafe5R2e9fTB+xCZHYKwNpmCxOZtJDI1rOK5bSHQxwdeFT6
         qromfzSNAkm4rluvrgwgfyo4fQ3jRRmmdmzsbLSQu/Nwme7vpyVwWQi9DE5gT2lwD/sK
         293Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787759664; x=1788364464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pFse/vYxtG5kld0lYEc5lD9aTNjYM3kCzlc1Lv8bCXc=;
        b=fUgjMb83DQAZzrA+0Aqou01T5D8u3a4Fm77SXIU0VduIPprlmPAfIGA2UpBsHhMvDH
         imt5kvVg29kTmPv2r4MMLNhXjoxglsnYrVQEJbWVR7p8fQtHz5JXHfmYUVpV3GmGuZeH
         x4/3+kXrUoEc1ya2rUErjqkHDSCP5T6gDZkFlk6ZkaYyDRQkoE3/MtEaPIS7iMdh+lyu
         pDi+/NEF2NmfyYHjkLdCmajg1hwSJnVkSr/qxupPTPqJzTYd1I//ivC2Jb9wGmKw88LZ
         fYFUEIJoGxMqbLPvXM9vVDhFs3Ly2DR5EqN8e/EBMIFFPJ2Q8yxm6dhHu91apM5mQOdQ
         N9sQ==
X-Forwarded-Encrypted: i=1; AHgh+RrcaAtVjyWKTvzZWwSkpzF6kCrq+TzmUlMuenaH7dsoEWwPP6gBXmtKStGOj5SdBWpmC2epsDtI@vger.kernel.org
X-Gm-Message-State: AFuF++nDke9OTTUrvuUSZjD/Lrk6c+TfsPIigxnuAKQQhoxu4DmxZ/Z3
	AMbBTnY/+gR7eH63kpFOxERFvWTYicSahV2b96oTXG4yunD1Qib7eTduSr/EVux5Ats=
X-Gm-Gg: AR+sD13khxJxMC9NOKN9aplBu+TaecpF2BEhytniICPOJUMtejgI9gwOEHM1HTRyeew
	xS44FgHuP/m2Zc/r1VJN8ry2Q/Qe+Vo2f06qVyFzX/SHKbISUzt4Vfrwx0OAiXJP6WiyChDdTTA
	dCM3IC/AsVPmJjxXQouxI4+1rS2bDYZIvhzR/tw4oDuFI9TH7S6rk4ss9TBX28sXIKPlv6Ifgin
	w8mtmDj4fOTfvxTZ/gldDWFo01eEoFk/pixKO5FXT1wZ4xKIZbqEo+ixP8YXF6+PNeVSnuB8D2O
	EqVwnOCwHQd7lJMIo97hyTBbAnNpsyhnDwSD68Ppo7rklG/hY5M50scN3ylPoF0YIprDUxsEsQW
	ShZJNz8X4ccNY201EZzrAlfVLelIXm8tbCX2bzwD9PqEVk1oTIpPYiNx4B1HShCIXR8x0Ch+qBa
	5NE6eFAOFO/ZBEk1HaT8rdyfWAxvcXpIs5935QrnNK5Kso14is2ZrV1AFA
X-Received: by 2002:a17:907:3cd6:b0:c1f:922d:34c3 with SMTP id a640c23a62f3a-c250c308f96mr858858166b.14.1787759663959;
        Wed, 26 Aug 2026 08:54:23 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d647dsm528239366b.13.2026.08.26.08.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 08:54:23 -0700 (PDT)
From: Avinesh Kumar <avinesh.kumar@suse.com>
To: djwong@kernel.org,
	fstests@vger.kernel.org
Cc: avinesh.kumar@suse.com,
	wqu@suse.com
Subject: [PATCH v3] generic/798: chain xfs_io commands into a single invocation
Date: Wed, 26 Aug 2026 17:54:23 +0200
Message-ID: <20260826155423.183785-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826152014.GT839663@frogsfrogsfrogs>
References: <20260826152014.GT839663@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avinesh Kumar <avinesh.kumar@suse.com>

The write, cachestat, fsync, and cachestat calls were each run as
separate xfs_io invocations, closing and reopening the file in
between. Some filesystems flush dirty data back on close(), clearing
the dirty bit before the first cachestat ever ran, causing test failure

- output mismatch (see /opt/xfstests/results//generic/798.out.bad)
    --- tests/generic/798.out	2026-08-20 05:25:39.000000000 -0400
    +++ /opt/xfstests/results//generic/798.out.bad	2026-08-21 12:30:39.831381108 -0400
    @@ -1,16 +1,16 @@
     QA output created by 798
     === Test with 1 pages ===
    -Cached: 1, Dirty: 1, Writeback: 0, Evicted: 0, Recently Evicted: 0
    +Cached: 1, Dirty: 0, Writeback: 0, Evicted: 0, Recently Evicted: 0
     Cached: 1, Dirty: 0, Writeback: 0, Evicted: 0, Recently Evicted: 0
     === Test with 2 pages ===
    -Cached: 2, Dirty: 2, Writeback: 0, Evicted: 0, Recently Evicted: 0
    ...

Run the whole sequence on one open file descriptor instead by chaining
all xfs_io commands in single invocation.

Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 tests/generic/798 | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/generic/798 b/tests/generic/798
index 0fe37646..5c81b429 100755
--- a/tests/generic/798
+++ b/tests/generic/798
@@ -27,12 +27,21 @@ for num_page in 1 2 4 8 16; do
 	echo "=== Test with $num_page pages ==="
 
 	rm -f $SCRATCH_MNT/foobar
-	$XFS_IO_PROG -f -c "pwrite -b $pagesize 0 $size" $SCRATCH_MNT/foobar > /dev/null
-	# Basic cached number reporting
-	$XFS_IO_PROG -c "cachestat 0 $size" $SCRATCH_MNT/foobar
 
-	# Test dirty page number reporting after a fsync.
-	$XFS_IO_PROG -c "fsync" -c "cachestat 0 $size" $SCRATCH_MNT/foobar
+	# Basic cached number reporting and test dirty page number
+	# reporting after a fsync.
+	#
+	# Do the whole write+cachestat+fsync+cachestat sequence in a
+	# single xfs_io invocation. Some filesystems (e.g. NFS) flush
+	# dirty data back to the server as part of their own close()-time
+	# cache consistency, which would clear the dirty bits before the
+	# second xfs_io process ever got to run cachestat.
+	$XFS_IO_PROG -f \
+		-c "pwrite -q -b $pagesize 0 $size" \
+		-c "cachestat 0 $size" \
+		-c "fsync" \
+		-c "cachestat 0 $size" \
+		$SCRATCH_MNT/foobar
 done
 
 _scratch_unmount
-- 
2.55.0

