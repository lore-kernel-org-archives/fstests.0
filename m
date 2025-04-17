Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83C18DB2B
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859536; cv=none; b=mQXTeE3ytxvdyXbTJizk5OjeuBE7sSl38hIbC0PgwVxpw0FoROmEVthSWcM1k0AHglZwLv+gT0DxVVTqmjHfOlmYrRQFliKxf+aIslCkzQ6127eYSdC/YRt6nMCJ11E/dJfWWLAfbNDZxSXPXDsj9Tstn5D7cn/IP7mBRksIEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859536; c=relaxed/simple;
	bh=yr0y0UGOplAQ3QXfme0OJ1mVShH9ob2ZcsxLVupxl7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8ei2Z+pe3BV6TM05gwXNHRCezn7bFZtRTEovJxZuDqoF3YxUTHwCr1RUYTK4wI/K89QqWkVuUDNX3Xh7VRXe8+I3Qy2x0u52monfZcjVOsRH0MBW0j0XF/m+lKyhUaP91wDSyXhkfJ60QkcccQaTHiBhkrPQsZJoMJotvU4hT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=fOVhQk/t; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="fOVhQk/t"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22c33e5013aso3935575ad.0
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744859533; x=1745464333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysFoqa/HalAJk0EQFQUcaR6V/7QVGRlghqFuh1OxqyY=;
        b=fOVhQk/twgXYbD5JoEtArkrmwEpTqfgtDuzFweNMV/KG8Gy/XSwaNc/L/uqWrPaDB8
         xhoZ8gB2yrsQSejdodTM+1UQ4uhsGzl1ZL7Z4q3AFKF9ErPaMjA23fxYGOWCBeoCY8of
         3JFS6oB1t2Ih9VohUD2ASyZAiAe+nEu6QQ3SJN579+O9fS5u3VASXIrC6588sEsGJr32
         qP5z55czfDihMZ2q4W9zu/cxVSL2T5DiX/C4kAMCFQyFpWZLlhje7F1r/g3PudISEzOn
         fJOjONJWJwTcHfmZ1BM1/NV95/md65uiWR4rinvdFbIVZG9shpy+ziU+mhq3haZBac/9
         PC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744859533; x=1745464333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysFoqa/HalAJk0EQFQUcaR6V/7QVGRlghqFuh1OxqyY=;
        b=B/eNKXpU+LIldpkeygpx+385z+mpnrND7JdMKE4mzj1aGOm7QDP0H7O+gEkrs9h74t
         NNatK9Dy+KOpvfMvJ+26Y6jEmM41llq/wTkqsgPNCmj8wzbcGWq2ET/qGCD2oZCnvr32
         0rmbaGbHmfOqJTYazXbgH3cIgXtoxjg8ZcLS1xiohJL5zW+oSteAUEpDqYnFmAyzkvgV
         VwXjM2Y7zKqIS7yOJ28jx12EFtWRErzrz7ZZqhIQvDkEGeKeD7xoJxBeFo3ZYzb2rzzS
         ZU1iYC3J/bIP/x2HvJm+f2Tx+f/rcNNmIPG7x5qeEGzAzwOrrzbVyK3P7Ml/CfnUDyYn
         Ck4w==
X-Gm-Message-State: AOJu0YwOzGYXenZI5tYPRkIULVMRHG0LtlAlBasnj6Sg9GKT4rMPYT8A
	jlMQDJzYOVJxry7JS6BjtbIe2tXB3TOMqYE7LPY8NrqSqcE4ewHvt3uuKaE1Tc31x4+MhVeA7Eh
	o
X-Gm-Gg: ASbGncu5dvYqgdFx+/sx2ReZMiFTmw2jotz4ytQTPSXNGqnNeaqm3nCssXAqw4bnuko
	ak/e7RRq8XJkj+py1ixP1xWcNk72RrGhvel75/s4HQQfZkOSWlj1b1DcoiEQtz51/hGYoeKkY2e
	wjygMuFg8B433wgFXkIcY5dumdv93eEMnLynRi/NyD3H0PuSlxhRKDcG8sJNplM/ro4iKxGIDof
	TMbxveqy2BlNIJg3wGkKe6Fm2aPqkj78R+AmNFEpYKvrrJUMSNZBOaUeIofTzh083nhe5c2mJV8
	ZQGaYf54Ajb4I6qAc+SLkP8BC+ilgU0xPgIt9JuX3IO0vJ7XJvIeUBHnsSxRkqvxUA8dZBlFEiD
	BkDViCGDRItuZ
X-Google-Smtp-Source: AGHT+IF7Jyk672douf3NbUnDYyCVk4xLfCAe5UiNqtk8FE4oAxHKz7r0UvnZzfUHbLYWhnCNTFCDFw==
X-Received: by 2002:a17:902:ea12:b0:223:5241:f5ca with SMTP id d9443c01a7336-22c358db91bmr46144095ad.20.1744859533287;
        Wed, 16 Apr 2025 20:12:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f1035sm11216180b3a.114.2025.04.16.20.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:12:12 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009Y9x-0qtg;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mEf-1jAq;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 10/28] check-parallel: use PID namespaces for runner process isolation
Date: Thu, 17 Apr 2025 13:00:51 +1000
Message-ID: <20250417031208.1852171-11-david@fromorbit.com>
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

This provides isolation between individual runners so that they
cannot see the processes that other test runners have created.
This means tools like pkill will only find processes run by the test
that is calling it, hence there is no danger that it might kill
processes owned by a different test in a different runner context.

This means we need to turn of private pid/mount namespaces inside
check itself - nesting private namespaces causes all sorts of weird
TEST_DIR mount issues with SELinux disallowing TEST_DIR mounts.

Note that this also regresses generic/504 for check-parallel,
because it triggers looking at the init namespace from
FSTESTS_ISOL=privatens and this variable is not exported to test
subprocesses anymore.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check-parallel | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/check-parallel b/check-parallel
index 19f2d2b0c..aa88c681e 100755
--- a/check-parallel
+++ b/check-parallel
@@ -267,14 +267,18 @@ runner_go()
 	rm -f $RESULT_BASE/check.*
 
 	# Only supports default mkfs parameters right now
-	wipefs -a $TEST_DEV > /dev/null 2>&1
-	yes | mkfs -t $FSTYP $TEST_MKFS_OPTS $TEST_DEV > /dev/null 2>&1
+	wipefs -a $TEST_DEV > $me/log 2>&1
+	yes | mkfs -t $FSTYP $TEST_MKFS_OPTS $TEST_DEV >> $me/log 2>&1
 
 #	export DUMP_CORRUPT_FS=1
 
 	# Run the tests in it's own mount namespace, as per the comment below
 	# that precedes making the basedir a private mount.
-	./src/nsexec -m ./check $run_section -x unreliable_in_parallel --exact-order ${runner_list[$id]} > $me/log 2>&1
+	#
+	# Similarly, we need to run check in it's own PID namespace so that
+	# operations like pkill only affect the runner instance, not globally
+	# kill processes from other check instances.
+	tools/run_privatens ./check $run_section -x unreliable_in_parallel --exact-order ${runner_list[$id]} >> $me/log 2>&1
 
 	wait
 	sleep 1
-- 
2.45.2

