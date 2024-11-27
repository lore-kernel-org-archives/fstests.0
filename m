Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CED513D502
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683605; cv=none; b=clRnPIBr8ypZ2Tt/Vo4q/lEg+OoqIgWvp5RFrUcFGnDfVqfhMKLb40R7agQ5+eTC0oaW6nGfchAy+vz2Wn5K6GvICLqbjNYSl6v3uqB+PjFb/8ys60Yy/YihKw6a/lU/5KAWtUUIJF1aL5ZDwAODdR4nlrmAIi9VrE9Nmb6/tF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683605; c=relaxed/simple;
	bh=HPU8/Dl60OUQhEO3ZB/NTOq/YNjWmyPeNd4FYbDA/KQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghbRNe7eo7N+ZTHhpeX64ccOFjmX14VTZAe0TP2diwpoRoclng1Qgf0oxqSd249iBDsRQsPMSSwi9bs6hBouVdOrVf8CMY5ECDVLAHot9iUdrSwZqLACz10xva1ZFqtglDJO/MiZgX7o5Vnohjcj+gIa10VCIuxzkqG/hkV4Gng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YDDsdjEO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YDDsdjEO"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7251abe0e69so2064809b3a.0
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 21:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683604; x=1733288404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiJvkl4sWpc7nD13wqPuFC22qsq8ZAW0iNgH8B0Igv0=;
        b=YDDsdjEOgLeB7EjpoB5ZndJ/Qck7uNMlA1DVU78qbXl0x+kvVSEK+grNhEAlZpyip5
         h4GUNPPX0HL5H4jq7kF4FkU8mtQ1x8Ll2hHSbPBtmIpdShqPeSlweMjeRqJE3fWKBDTu
         jLAS1WaOlEVqcYN9N4zOYixIQnSuP/q2MDwX5rTSzsZ5qaCL3pO9iGz9mbPVD61Nw6Ea
         ShiQwNULlIssVy2/4/XDL/xehaRPraD/O81WazBW6I5fyXumYa+NLrhv9Z4ewJxI7RlE
         3ECDZTbvnx5FO08+Khs2YN1L6b85yuVNDDciiNJFrZXhFepdfMaMnsthLhyAb0AU/4AZ
         sBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683604; x=1733288404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiJvkl4sWpc7nD13wqPuFC22qsq8ZAW0iNgH8B0Igv0=;
        b=L4dWeLIyzaM/+fXqiihS/afhOI1LtBKMDjDTZmaQjDvLCsBUE5i9Tdvs6UOrfEAr22
         gCZjjekZcpxzLpX1pKe7VaTz91tmv1bHvCC2KyORIoIVDMhd+i5TkLZFhP97QWolygZ2
         9R3SIqOCsHrhH91zLadWAIvsysWnIslGGGTf4jrwS9am+/Nran7zzq8EjAdn4gSoLd/H
         5AZD5wSKromL4sMxeA1seiVIoavwy8eJoPHijvICNYWwIDh4nCW78224AIW3nW1TMbHm
         FejLR82p5f7/z7Q+mh7TL3QpPK/QWDUOQFtbZWU1xMq0LD0YAE9us3NICjnCIWzuy2iC
         ofVw==
X-Gm-Message-State: AOJu0Yze1WyYJetm2YPznqSqUDHPnBjCqiQZaj9lZt1Yd6qjHTnGNikB
	v1CnV4AhgnI8b26+PQve/Jz/GQjaehUu/6cf15xFnASo4G/DsL1s/mJKY4YV9uZfT8zEeKzSBur
	S
X-Gm-Gg: ASbGnctv4Eo3m8OMKTiIIjyPkoBGg+5lyi7Sc+6/Bz1NKfvMbcW9bwbxX38dFyYrDts
	PDPXapPWrUQJV+82tHur1yUqBSPmxb+3yGYBWmKNjOQtG6kFi00LJ2Xm+yqmug2PlJro1Xqg5i5
	lJ8Czl38XTV2EoLfWISlQc/CjZcb1hPZ2oAcB0v47On+J9VgUq7UBZkijeSC+TU66IyltYFD6Lq
	XdTiIxbYGv4/oyu/07bmG3LOcB9b1ah4b9lvOzec8PNHf0QDk20iTix+mYI5p3nXQsHtZrDeLep
	ayIHN0+mL+Ws3Q==
X-Google-Smtp-Source: AGHT+IHjHGXn23NJ4gU18U2GLZxQwnGZjeT+GkcSjcyn09xa124HbP8TlnwiMPidcvWlzn1gtWBUoA==
X-Received: by 2002:a17:90b:35cb:b0:2ea:6f19:180b with SMTP id 98e67ed59e1d1-2ee097cf0d5mr2119573a91.36.1732683603920;
        Tue, 26 Nov 2024 21:00:03 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa48134sm500995a91.18.2024.11.26.21.00.03
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 21:00:03 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZVp-3Ri0
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQfw-40VZ
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 31/40] fstests: clean up a couple of dm-flakey tests
Date: Wed, 27 Nov 2024 15:52:01 +1100
Message-ID: <20241127045403.3665299-32-david@fromorbit.com>
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

Just little things I've found that should be cleaned up.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/066 | 3 +++
 tests/generic/321 | 4 +++-
 tests/xfs/051     | 7 +++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/generic/066 b/tests/generic/066
index 37d04e069..9e4047a11 100755
--- a/tests/generic/066
+++ b/tests/generic/066
@@ -24,6 +24,7 @@ _begin_fstest auto quick attr metadata log
 _cleanup()
 {
 	_cleanup_flakey
+	cd /
 	rm -f $tmp.*
 }
 
@@ -88,5 +89,7 @@ _flakey_drop_and_remount
 echo "xattr names and values after second fsync log replay:"
 _getfattr --absolute-names --dump $SCRATCH_MNT/foobar | _filter_scratch
 
+_unmount_flakey
+
 status=0
 exit
diff --git a/tests/generic/321 b/tests/generic/321
index 73a892334..df8f13597 100755
--- a/tests/generic/321
+++ b/tests/generic/321
@@ -13,6 +13,8 @@ _begin_fstest auto quick metadata log
 _cleanup()
 {
 	_cleanup_flakey
+	cd /
+	rm -f $tmp.*
 }
 
 # Import common functions.
@@ -57,7 +59,7 @@ _rename_test()
 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar
 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar/foo
 
-	_flakey_drop_and_remount\
+	_flakey_drop_and_remount
 
 	_ls_l $SCRATCH_MNT | tail -n +2 | awk '{ print $1, $9 }'
 	_ls_l $SCRATCH_MNT/bar | tail -n +2 | awk '{ print $1, $9 }'
diff --git a/tests/xfs/051 b/tests/xfs/051
index fe3d75cab..ddc28ac97 100755
--- a/tests/xfs/051
+++ b/tests/xfs/051
@@ -11,6 +11,13 @@
 . ./common/preamble
 _begin_fstest shutdown auto log metadata
 
+_cleanup()
+{
+	_cleanup_flakey
+	cd /
+	rm -f $tmp.*
+}
+
 # Import common functions.
 . ./common/dmflakey
 
-- 
2.45.2

