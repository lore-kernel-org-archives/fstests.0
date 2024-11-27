Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF2F4689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683581; cv=none; b=VT0NTOy9wY0kNv9SXMbA7/SqmBZ1+QfExdKzV1RLj6b1KgklpqoqG+oFFJ2fRZ6KidRqmHinl3vNZ5NzWr8C/FcZbqrDbrj/KmAfJOQ7/4cTs/QvuF/rc9hiIB55K9nPRgw0Ukz+c39JFk8rKyzpRz8OFXdHiWBLz7hcCts80fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683581; c=relaxed/simple;
	bh=OvqZjkLmidtiPpSC3NXJZPas+XM2soqZGPX6TekKEhY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HneA/4y7EsB/CEelKl/jdZcty43zG6WNpcb/zjdkqXT3otPZD97S6Nu7mnizU/cSHwXKcgIDmoyoqj15C6w4l6K4DUAeIh9yqjhNGiBG7fWzx9QuTaiKdc4cciGTVQxI9KW5Hgp9z8QkyFPZ2SZzgrzqgGyT26VVzExY86oj20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=NdsplSDy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="NdsplSDy"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21210fe8775so3558845ad.1
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683579; x=1733288379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLyvRmpA/T9GK7gzdKLhJ6NSQ3rODHP4ylzcE+r6rVY=;
        b=NdsplSDyjO1/rmZBJoQzCPnDbP4AdLxgAVkI0DONw0/CLNybOKVWxFpT0yXPPUzSO4
         8ZUr4J1tvaE57mUOu+cZPbQSjqGXj3VX2OEoBCZtkOi5k5PGdNlOa0ACOlAstdAMcQgF
         9jq0nJtuT6NlVlj0Fhcn+8WbXHiPzYlzJhDG6JLoF1WEwOjYQ6oBAJ1VK1wbuvtE/M9w
         GPVzA3Azx9AOEiFyNjXT7ogt8GQP3UI5MLB+q8k0ksAXK1zcTwzwyMCntcg5bTLpwbo8
         t++VXjjBwTmIILYZbn6TquXvlwBMQ2+gF6Uq+0ZOjTPjaZDvyqAjEK85+in4BXYFzBnU
         I58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683579; x=1733288379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLyvRmpA/T9GK7gzdKLhJ6NSQ3rODHP4ylzcE+r6rVY=;
        b=OyKlKLVpyKy4oZsJOGrq4bsL+r9FdPOvcfL2wEN2NyUHyX69VgQaAPRMkEntJtD8fX
         RKOCSLpKfLf5h7hfNorCkHmNsk/ESW7xaEBcNgIiOzCsx+kuum5XkvvOo4NmjD8DX+fV
         bzkrjhOt3lWP7AqSFPFph8JLrp0KT3WnhxYudfKxElHCJDQXkKGvjM9BEjHDBjUFwfYJ
         FLV+XHTmKEJ3hSqVFToRpYmjzVAosbp4CDQpKcHDY5LtHg8Q28DjtPOxx6ppCLSI8aEy
         Jf7HUFMuSsyqPK1BT4e6Qpf7Jp45jrFsbJw6eE7pX4g7rMsn7AZtiZnCt0AXLqGQRVcd
         2kyA==
X-Gm-Message-State: AOJu0Yyk/5ww7eCUAs2vaJ59jUDb9PKZHUpUkUeB6cjeWhtqiQqTljO2
	lybtfoBAswdDWmBOD3fCglGC+49KVHtwpoOJ4q2/GRmtMgctgVpPpf7SprRx5hXeay4yvqRkqPF
	C
X-Gm-Gg: ASbGnctZGjWJYuP8GrqKYgLX9fOxg0o7fYBHyMsbwSAbVCbXeZZKwm3btIxHv71GKhy
	YUzqoOJJn+R26Rtko5S5QrKhsPNu2k+IR8nvJ9ObyTa+We3YNyt7JC672BVoIooWciwQPlSVOuy
	KKdGGLjqv8qxiabT2y+HI8nMZpCpUpOJjcRicNLK4GgRO4nAemKCxFdzKV/N9UED2yrBVJEqjqd
	1dYMeVnm1vo3M7g0FEnKfYlhMZQkf5+MM71y8Lck5IL1jCFBqrMia1smea2mMz6OPlndnyLnAjQ
	DbKBAEsLLKk/NA==
X-Google-Smtp-Source: AGHT+IG/yq2VIBM2mbfk4EW9oRuDg8P0JCv2biZTycv1L6SwqH7jlxqjod7SFiRXjErIzswEiCbQPQ==
X-Received: by 2002:a17:902:fc85:b0:212:38d7:78ea with SMTP id d9443c01a7336-21500fc4fe7mr30388405ad.25.1732683579247;
        Tue, 26 Nov 2024 20:59:39 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc13239sm93367515ad.177.2024.11.26.20.59.38
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:38 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZUP-02zd
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQe8-0Xk8
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 09/40] fstests: per-test dmdelay instances
Date: Wed, 27 Nov 2024 15:51:39 +1100
Message-ID: <20241127045403.3665299-10-david@fromorbit.com>
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

We can't run two tests that use dmdelay at the same time because
the device name is the same. hence they interfere with each other.
Give dmdelay devices their own per-test names to avoid this
problem.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/dmdelay | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/common/dmdelay b/common/dmdelay
index 66cac1a70..1c4fca6e9 100644
--- a/common/dmdelay
+++ b/common/dmdelay
@@ -7,13 +7,15 @@
 DELAY_NONE=0
 DELAY_READ=1
 
+export DELAY_NAME="delay-test.$seq"
+
 _init_delay()
 {
 	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
-	DELAY_DEV=/dev/mapper/delay-test
+	DELAY_DEV=/dev/mapper/$DELAY_NAME
 	DELAY_TABLE="0 $BLK_DEV_SIZE delay $SCRATCH_DEV 0 0"
 	DELAY_TABLE_RDELAY="0 $BLK_DEV_SIZE delay $SCRATCH_DEV 0 10000 $SCRATCH_DEV 0 0"
-	_dmsetup_create delay-test --table "$DELAY_TABLE" || \
+	_dmsetup_create $DELAY_NAME --table "$DELAY_TABLE" || \
 		_fatal "failed to create delay device"
 }
 
@@ -33,9 +35,9 @@ _cleanup_delay()
 {
 	# If dmsetup load fails then we need to make sure to do resume here
 	# otherwise the umount will hang
-	$DMSETUP_PROG resume delay-test > /dev/null 2>&1
+	$DMSETUP_PROG resume $DELAY_NAME > /dev/null 2>&1
 	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
-	_dmsetup_remove delay-test
+	_dmsetup_remove $DELAY_NAME
 }
 
 # _load_delay_table <table> [lockfs]
@@ -52,15 +54,15 @@ _load_delay_table()
 
 	# run a suspend/resume cycle to avoid excessive resume delays once a
 	# delay is introduced below
-	$DMSETUP_PROG suspend $suspend_opt delay-test
-	$DMSETUP_PROG resume $suspend_opt delay-test
+	$DMSETUP_PROG suspend $suspend_opt $DELAY_NAME
+	$DMSETUP_PROG resume $suspend_opt $DELAY_NAME
 
-	$DMSETUP_PROG suspend $suspend_opt delay-test
+	$DMSETUP_PROG suspend $suspend_opt $DELAY_NAME
 	[ $? -ne 0 ] && _fatal "failed to suspend delay-test"
 
-	$DMSETUP_PROG load delay-test --table "$table"
+	$DMSETUP_PROG load $DELAY_NAME --table "$table"
 	[ $? -ne 0 ] && _fatal "failed to load table into delay-test"
 
-	$DMSETUP_PROG resume delay-test
+	$DMSETUP_PROG resume $DELAY_NAME
 	[ $? -ne 0 ] && _fatal  "failed to resume delay-test"
 }
-- 
2.45.2

