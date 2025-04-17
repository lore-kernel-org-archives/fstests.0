Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2191CAA4
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860534; cv=none; b=u89GIW2fg3TL+7uOOMELSv+BsAxG6JcgvqhMcrUle5sd3yuW14l1NpRc9xOF03sLgQJRip3XuyPhinffstrBr98snI4h/Xp04MTR9676f2V3+xvaKd4BM2C763aw+81wcW6yCV+zXeIs9wz/IC9PHjj2IZsK78rB5SN4Gk04Few=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860534; c=relaxed/simple;
	bh=SEgHJcK4eTRhxjNQvRo/+pkrDpcN62Leaqv/LsTIqRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITZ/alwxJyvxC4RmYFfuXy3jCBMgk8W9+P7iMS/aD8rrtf09KlmU7o2e2aV48rdy6+VGxUlUtBJpssbdXD4o7/Snc/TpfHgHBqZoJn8ZMpnT3NANX9gUo1AGjVwuU1SuRRjC8rnk+DLBvMH0261A/liPqKbSth8FAMHLQnBsUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=u/5FiIHg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="u/5FiIHg"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22401f4d35aso3902315ad.2
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744860532; x=1745465332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqdO5Pih8Osadx63ujlw1VMFDtBf/gMJQXIwixAuSlA=;
        b=u/5FiIHgqDpLH80pItu6Sln7YGEYBjq6enj8pqMWw+JV2s+XI1DgN/7JzvyA643C0P
         1Z5ELOoyw3gS6xvdygTQctNYJjsawH4qgtKlfFa+wfWscPj12PcU20IX6s14dEealHkP
         NL5xXV29OJONmsYmsNi/q2QumtHDZaJDkeJ0Nx4L1RxMoTv0l3qjS6+1MP2LOvzUzwz2
         QXWYD4qQ5aUnbzQkhgsx6MLVa0EoLfUKV6jBR7bFS4m2LgS8Ume9e8QVJgRRPvNMWp0E
         GnII97NOphdhQPMsDygoujjqHsDLmHYu8ldHXaqWgHhQSJovVqGwCOyGq2HjiGg2I8mr
         ZBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860532; x=1745465332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqdO5Pih8Osadx63ujlw1VMFDtBf/gMJQXIwixAuSlA=;
        b=Q9BETSYQv68EvNK4JFWpanfX9PmHzw59xJq1VAmcqB09luWkxkzfYwHMSP8koPSEaB
         IcW6hmVNIHSSaoiGImPilUk9fMe9C88v/nB8/a6iwXT2o+x8KuoK42Lw5mdc1kHtvcV7
         OZoGhUq4uUK36ERf/xKNUyWCWtZKmtPNz634dvMDPhePHl4rRF4xCNmobzeGIiTVVSLK
         BKj1pnBavmW0a58d0Ucmil4q7If2HZIreiE78oD51MXYtVEElMlXt6+5AiQhb4vijgX1
         zISieO5QIHFgTZsSOsqKTtD4ydlc50sZCAgmiaC/7si8Ji55EQb3xAV0gaJoQneMvUkE
         +kug==
X-Gm-Message-State: AOJu0YyNkXWWfbuwhEm+e6ibGV2WcQe5ETPe9M7ekwQzsB28xID1UY3m
	MAYjhoUxj4WLcd0WYXKyopA2pF0aRH4JJYQVZc9ZKwOZ3qPMGG/m1zJ28Ic8wAPoYl3+XJnL608
	J
X-Gm-Gg: ASbGncuTvIImu+wvVAOG8NH0xC1NixrX4vyma9XGN7X5kJEjA0//aHVUwhXKAMe1kfC
	ISDRHNLnYKKALYlhLy9gEQIFjfbncISHuzuv6C9C9zM07tkArs8Ptwjqp929J8h85g63XLqC6Gs
	iUmAczQd71NwMzNfoN6/30maW3ZEE6b3LHvsLJNi2dE/YUvJMgAXO9PsX/nwwRsUYUxV2BDFWY7
	CgN6u6Yt7neo/3aW8VYwrcBmDg7n7p5ThxDq06rjC310eV06PpiKEIrd0DVnvjuAb4dcBsFCGEZ
	gMzJbJLfD73PIIMPhBOnFUcbHHlYmbA3WoWysvErey71zlXIeTQuPRa0WtL/Y5HDrmIpi+B1ddR
	7Ng==
X-Google-Smtp-Source: AGHT+IHWuCyDgecca9QiqxmbvvHZYFwSKg23uRCjqMoXiJrigT/GmuU45RDu1bAZDR/6J5dfz8XmtQ==
X-Received: by 2002:a17:902:cec8:b0:223:62f5:fd44 with SMTP id d9443c01a7336-22c3596daf4mr71308025ad.40.1744860531893;
        Wed, 16 Apr 2025 20:28:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fc4b89sm22480695ad.169.2025.04.16.20.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:28:51 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YAg-2VFo;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mFY-3J7z;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 21/28] generic/531: limit max files per CPU
Date: Thu, 17 Apr 2025 13:01:02 +1000
Message-ID: <20250417031208.1852171-22-david@fromorbit.com>
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

Currently g/531 runs t_open_files on every CPU, and with default
kernel settings that means 50,000 files per CPU are tested. On 64p
machines this means the test tries to create and unlink over 3
million files. This takes a long time:

Ten slowest tests - runtime in seconds:
generic/531 534
.....

Yet generic/531 is included in the 'quick' test group. It is
anything but "quick" on large CPU count systems.

Further, small filesystems  like are typically used for fstests do
not have the inherent concurrency to scale out this workload
effectively. Even using the mkfs.xfs concurrency options requires
using >250GB scratch devices on 64p machines because it won't make
AGs smaller than 4GB. Hence to get 64-way concurrency in the
filesystem, we need huge devices to be set up, and that's not really
practical for check-parallel.

Hence limit the total number of files this test will create
to a sane number, and distribute them over all the CPUs so that
the test runtime does not blow out on big systems. LOAD_FACTOR can
still be used to increase runtime of the test by increasing the
total number of files created.

Limiting the total number of files created brings g/531
system back into the "quick" test range on a 64p system:

generic/531        5s

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/531 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/531 b/tests/generic/531
index 07dffd9fd..3f691c0f8 100755
--- a/tests/generic/531
+++ b/tests/generic/531
@@ -29,13 +29,13 @@ _scratch_mount
 # Try to load up all the CPUs, two threads per CPU.
 nr_cpus=$(( $(getconf _NPROCESSORS_ONLN) * 2 ))
 
-# Set ULIMIT_NOFILE to min(file-max / $nr_cpus / 2, 50000 files per LOAD_FACTOR)
+# Set ULIMIT_NOFILE to min(file-max / 2, 100000) / $nr_cpus files per LOAD_FACTOR)
 # so that this test doesn't take forever or OOM the box
-max_files=$((50000 * LOAD_FACTOR))
-max_allowable_files=$(( $(cat /proc/sys/fs/file-max) / $nr_cpus / 2 ))
+max_files=$((100000 * LOAD_FACTOR))
+max_allowable_files=$(( $(cat /proc/sys/fs/file-max) / 2 ))
 test $max_allowable_files -gt 0 && test $max_files -gt $max_allowable_files && \
 	max_files=$max_allowable_files
-ulimit -n $max_files
+ulimit -n $((max_files / nr_cpus))
 
 # Open a lot of unlinked files
 echo create >> $seqres.full
-- 
2.45.2

