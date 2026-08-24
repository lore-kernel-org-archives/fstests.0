Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236F367F45
	for <fstests@vger.kernel.org>; Mon, 24 Aug 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584272; cv=none; b=YqszKqbCYb4ZswDdFnxa2w8Vln0MWxIdj3JS/uDpi+IaDTa0eWjhUX8knvCvdKyBSvJOlr9C5Fex18uXf9yHZRx7dlxe+beYVUEznBuPagbvWkG2dxP7dfxe5cvkB5okRgflCPM2by3khxNU+vGQI5VKa363GcB6yBmBua65WRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584272; c=relaxed/simple;
	bh=Lv7SCqkEbZdeAKVX0F54kAnkD9mFuUJbzasVQAaSxfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6Pb67tuiwKXBJ2dDqUUOcdC/E3rqofRdY+IFVkSdCyBTL2upPzLTqDuBswrLkm3Zu4C7tMLWotYSOqhFo7KvFjznQmAAuCDhoJTg/i0biGxbE7zjXNnm1TfO177z60sfI4vGsJ+2qUIm1Qcdc7nBJY2Dfy42gMePBCS7Fow6Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=duT86rcx; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="duT86rcx"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so5419332a12.2
        for <fstests@vger.kernel.org>; Mon, 24 Aug 2026 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787584269; x=1788189069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y76bQQkK8WF+8yOj/wH5p+zurvQ5FlQ1Fo5WsfZhoDE=;
        b=duT86rcx2g41BExOSuTN0kWZO4kloc4YC++jkAdGQzGrocYSGIENYVzqK6Id3aotfj
         dSzn0Br6tYULv6B60ZnyNDC34qRX7hrlRI3ltfbE8444oNUY2aaJPOTM9NyC286vQCCK
         gI9Qil3b2nIAqGm07ndGd+OGtPf3fII6kaE8zJ5+qAXsaXB/ROS46xXl4DpSiRl2R6tu
         YvSHBXHW07VvREV7KKQzqrW/3+oV49kb9KjIbqiy/Yaz+aYQZBZHW/qakrEwOEnmSTwb
         pJV1Wmo74Ldw+4pxM3Ka45flwkm1lRmf0EqsX8IErZpDqdvIKY+mq+nWx+o6SqYwt0H8
         hnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584269; x=1788189069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y76bQQkK8WF+8yOj/wH5p+zurvQ5FlQ1Fo5WsfZhoDE=;
        b=OgkBDqvPnIKJ2aMtQWxn+Vp2FhWFuBRTUmUvNk3YENbg5cBQdTxpq3XQRjzkfwRpGQ
         cJ1QhYAxfgNlCW/8+khkDKYYn9PcVnMlRjpEc+nfYLDLSmDn4z5MgLJM8CWeZqv4HNCI
         mV6aN1A9PzQRGtnkUhBRuPjW6rPCuDukmYEf5o3KzpXQRp3aixfvYhNaxbpLbCO8Oclp
         bYZqYIuCob3v99a3+VHoGoRDR4uAapdHNoo+ExQGdZTnkuCrmm5O4eMrlOvjp79TRErR
         x+nzeNp1qqAlG0cAzg5vIxZ6Gaxm7PNwcmIAHT2r4AETEXp69wLfquJGgOQ/6YST/U5R
         oDGA==
X-Gm-Message-State: AFuF++kKdlfTr16PCFpLh6DQ/Lh904eBYtUrdocHnYB2pomAUVW8tibS
	ZTVo6Ze4PyE6x8Keg/Louc7PGj6Srjam4sP1oYQwy+L3S9Mj2Whmk8dFAADtEReWj+/iR61EWrI
	J3YHaNuQ=
X-Gm-Gg: AR+sD13dMtLeyTQhc9L9otb4jDGezyAqVmVEGoTBj8DmHerD4rXlp68OVDUTZMk2Aob
	/IdAv5oaMmMUwvXYjEze4z60tQmfyd+nGbv7rGTvg2Jmp0XpSHdyZks6ISzPEG1SLaMEzCSjPh2
	aO0UByC4r7Ah3rW+I/NeXVQ8H4wHy2GuGpQp0PT/MLqHkPfWNzGcGfpZTc5Fj+hUv/7LkaVROrY
	4dH2sjWKwJ7QH4c53vF2hW1SCsSprrfuTLq0KZ0zn8qs/pw5Nf3E63qbQra2jLOfXdkgKhKOrcm
	R3XVFVFWTh+aSzynRmz6j3LGfcjYVuYKAymts99UWXtFYVNXkZrLVIlbEurJpytneGRT04Hp7ao
	FY+KOCbG40ILgFEgvluFcV399Snnr4EqrSTCoDkprLULQWmkAfEGg///NEO2cIwfzKyUxyK3TbG
	O+W19HTpMq9xx0GyVv5l2DM9YcbMFkJ+1wEY1hhrUn3V782Q==
X-Received: by 2002:a05:6402:320c:b0:6a3:fdb0:c374 with SMTP id 4fb4d7f45d1cf-6a42f2054b1mr32473280a12.13.1787584268136;
        Mon, 24 Aug 2026 08:11:08 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1aeab9sm10383661a12.22.2026.08.24.08.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:11:07 -0700 (PDT)
From: Avinesh Kumar <avinesh.kumar@suse.com>
To: fstests@vger.kernel.org
Cc: wqu@suse.com
Subject: [PATCH] generic/798: exclude nfs from cachestat dirty page reporting test
Date: Mon, 24 Aug 2026 17:11:06 +0200
Message-ID: <20260824151107.209027-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avinesh Kumar <avinesh.kumar@suse.com>

generic/798 checks cachestat() page cache dirty state between write and
fsync operations.

On NFS, the client flushes dirty pages to the server during close() to
enforce its close-to-open consistency model. Because the test uses separate
xfs_io invocations, the file is closed after writing, leaving pages already
clean by the time the subsequent cachestat command executes, causing the
test to fail.

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

Exclude 'nfs' from running this test.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 tests/generic/798 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/generic/798 b/tests/generic/798
index 0fe37646..80b2acc9 100755
--- a/tests/generic/798
+++ b/tests/generic/798
@@ -16,6 +16,12 @@ _require_scratch
 _exclude_scratch_mount_option "dax"
 _exclude_scratch_mount_option "sync"
 
+# NFS flushes dirty data back to the server on close() as part of its
+# close-to-open cache consistency model, so a page written and closed in
+# one xfs_io invocation is no longer dirty by the time cachestat runs in
+# a later invocation.
+_exclude_fs nfs
+
 pagesize=$(_get_page_size)
 
 _scratch_mkfs > /dev/null
-- 
2.55.0

