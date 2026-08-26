Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E2449999
	for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756506; cv=none; b=Xq/AHrO6cDWK1bn4M0O3GciIIvT2OVtJFDvtS/57yU9JlxSffFBaO3s9XlOg0LHSHE1um+tFfVJuUp1wrE8amTqaQWKxQOF3P1WTefLqjQ8LoYOeMmRU31acVrKhW574j4wYCUO3Oe3mFxZg4VQyxr6fx7QtmsD1LgiZpn80Aeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756506; c=relaxed/simple;
	bh=BcwIAtbaQ0O4P/yTvpf11oruY1C/RW5BDDDxRO8bmGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c59qGEd8byn7U4erqMIt4QYQ38Ij9POJ0M7OR3s7+FJt4bgKIR+FBdjL2Ncy89JpJCeWsoba52PACYuIUSX6q+fsTsjy/PpCWQjKME2mTw5alA90/10s+BrLM0qsXQ7B0eFq1H3q5RSsCixHJCkgjn1MNACDBWkmkKgsl4Te0Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c4OE9h9A; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c4OE9h9A"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a1a546a6bbso1789721a12.1
        for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 08:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787756503; x=1788361303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bCX1usaL9N3tibEVJPVuprx9gNSWLcbm5Db+04YOsiY=;
        b=c4OE9h9A6HMIzvkiXya8z37ysTJ6e22gB8orw/+lHRTQoezA5/Ws42J1yw5tGf2R7P
         2GQEWeBCucpqgEFElJujoPvLE/Ifsv99VVYhp3zWJf8+0ux90nuQwJmHXoqZtGhD9UWx
         SYx8gpebQkS1apkE2jeM6W33exXNCtZ+WajUWXH6x4jnUVDBAqOSihuuefCnJDWrnhVj
         CLeQpalUBOiJr8WFtoZgxLMzICbPXBRE+HYy4hi4l6A3QXM8vf275YHWpNJT3bOd8p+S
         dYv8mL5KHpD37/9bbErDl5RjI2/L7zym9kOs3f4FHvJq1Ex8d2VkE85dxjrFNh+kB67G
         Qkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787756503; x=1788361303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bCX1usaL9N3tibEVJPVuprx9gNSWLcbm5Db+04YOsiY=;
        b=qRWY7r8Rry68jtG933ToTMnxWHvbYaN8bd36PebX1PIb6xHE91qW0i/jnpYCsJDC+t
         NRjRvwBYYfbZUTA48ms3iqTh1AGuiipi2ncadeGcvYkAAinpoCYoaCjoKBB8NxO/vsi5
         lxssSI/hU+0isS96IlfFcyIwXZ6/++DE6VstPMyDxgJ32+h8ZYVJJSspk0lXup/YFnhU
         5+VpyTC5SKyB2RfZ0riQUAZZ6Eewd/DDwkt5tvKIGgPzOzyiq02beoGWIf2wok0AxVxz
         oZSXZMj+8vkXc7f0R/ZSx/gRqfjss6z9QBCH87iXmGpZwdnKP88WPsP48oYrNZptNKIG
         o45w==
X-Gm-Message-State: AFuF++kjYWaotDlNeMkgxwFao9o++V/2h7KrOz7oVTU58eEcP87BF7/l
	IglUBtWNVtXWNNfMQnmocxeY4jEmuxvbjzx5q2JxfQINblo5ZknRxic1+71N8bP6sX8GdzjA2ck
	drRBWABw=
X-Gm-Gg: AR+sD13Tk1DHpsM9nEcP77N6M0IKeaJ9hbK1W00dcQQb4bYzFVdBmu8+At6O50uHW0l
	ovoCcoQcI97p2j48xmdypK3aUQtCSRAtcHGD0IFGhKpM37ltFVJvLoyLh8v4l5Wv2yHg7oiSnt2
	eAaFvMb6DkxWoXdK+SW5B9Vk1JMTV865suD99jvuBYyUDyO3L+uCd6FjDxp+nauouOPsrEbx2mZ
	TZwai/1banCPTyqx4KYDx+GTt5ACCdstXzQrxOCwl966/SCSWIZTHcmUWtYDdj7boCsEDF0DOvW
	4P6iXea54DtlMup6funK25bakgRLmCK/aL/Yk23uqQKfKz0u2dRg9YaxMfOQB7b4Ue/9tTfyfwR
	+6tG1vQwA88SgJj2l2OySOeae8V0i6KoTAloKK9uerYFY4jhSb7+FJy5ji4BIPc7GbOpyqpWKvO
	GsQgwYKfNVydil9xKqLhIaqmlAxBLGardiNwFNh9DcRwSGdA==
X-Received: by 2002:a17:907:e1d3:20b0:c25:d03:6794 with SMTP id a640c23a62f3a-c250d036dcdmr710645466b.16.1787756479743;
        Wed, 26 Aug 2026 08:01:19 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d69a7sm807039466b.8.2026.08.26.08.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 08:01:19 -0700 (PDT)
From: Avinesh Kumar <avinesh.kumar@suse.com>
To: fstests@vger.kernel.org
Cc: wqu@suse.com,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2] generic/798: chain xfs_io commands into a single invocation
Date: Wed, 26 Aug 2026 17:01:14 +0200
Message-ID: <20260826150118.177196-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824161518.GP839663@frogsfrogsfrogs>
References: <20260824161518.GP839663@frogsfrogsfrogs>
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
 tests/generic/798 | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/generic/798 b/tests/generic/798
index 0fe37646..171878ee 100755
--- a/tests/generic/798
+++ b/tests/generic/798
@@ -27,12 +27,22 @@ for num_page in 1 2 4 8 16; do
 	echo "=== Test with $num_page pages ==="
 
 	rm -f $SCRATCH_MNT/foobar
-	$XFS_IO_PROG -f -c "pwrite -b $pagesize 0 $size" $SCRATCH_MNT/foobar > /dev/null
-	# Basic cached number reporting
-	$XFS_IO_PROG -c "cachestat 0 $size" $SCRATCH_MNT/foobar
 
-	# Test dirty page number reporting after a fsync.
+	# Basic cached number reporting and test dirty page number
+	# reporting after a fsync.
+	#
+	# Do the whole write+cachestat+fsync+cachestat sequence in a
+	# single xfs_io invocation. Some filesystems (e.g. NFS) flush
+	# dirty data back to the server as part of their own close()-time
+	# cache consistency, which would clear the dirty bits before the
+	# second xfs_io process ever got to run cachestat.
 	$XFS_IO_PROG -c "fsync" -c "cachestat 0 $size" $SCRATCH_MNT/foobar
+		$XFS_IO_PROG -f \
+		-c "pwrite -q -b $pagesize 0 $size" \
+		-c "cachestat 0 $size" \
+		-c "fsync" \
+		-c "cachestat 0 $size" \
+		$SCRATCH_MNT/foobar
 done
 
 _scratch_unmount
-- 
2.55.0

