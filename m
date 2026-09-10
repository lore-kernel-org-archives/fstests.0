Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A04BFE84
	for <fstests@vger.kernel.org>; Thu, 10 Sep 2026 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788998714; cv=none; b=JmYDVk8+hhKHXb8HnI9pFVDMY9lBDkeH5LaTqy8fFj4/zCgiuXlphgFUAsgNhJ8Q0zb5eahGhntg6xhuQQKSIGxVsOQjQbiCFTmRyDSyGtZT4Qwa4rSnXy/F2nCGxGi3lFUeTis35xeATvGi1It0tQIoU1ZdGx7fdfS6eXmUYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788998714; c=relaxed/simple;
	bh=vPGGigZtbn609VllmdxIrfgs2wVQVwK4tTE8Lofg/mA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTGhWuarVmZI45KMRcD1qDPecTMwFeuo67hjPet0ghHAZkYWMDQI5EHW9w10ns7b5980I7BTZvVf8gkt7RzWipJaq9vMlz2p9/dq6bl0cwCb5CMa8lYNn5eqRty+K6nPLSWLZTD7f7ODQTJJUsBff7+IcYNMoGn23eLn1zAaX0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=n/unJEpP; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="n/unJEpP"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-857ff9fef54so64068197b3.1
        for <fstests@vger.kernel.org>; Wed, 09 Sep 2026 17:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1788998712; x=1789603512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SBS5mNZmCsiLBp7HvXFMoNdv6DnLngpLQ6EQEUK1Hco=;
        b=n/unJEpP0izSh1Guwp4X1e84gw4dp4dz85xPeBi/uLDts4snOuJtwQDOeeqUw2yCFJ
         3CuuMg0OUb3mrL84n+JH3z/aHbOizez/8KSKUmtC6RllS7u9xNJ/lBJTPr571R2P6Sub
         XDZfNQsAYQUlQRMFOjNFsX+ThucsM/laHB7onnNMiBACKnBErZl+PDqldWSDBmn9MhRS
         ExQLIPGzuJHa0YcRH0yIRO3xfoDLOmAatrWku/WXP2dJNtyHP7FViQxA+hELPA1oQfnr
         RWAiLZs5ljOt2QcwFdG3h79R1TBlDCOFNFo3KSnuO4uW+cx1Yxa9iWHyvL1J1wETLKHM
         36Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788998712; x=1789603512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBS5mNZmCsiLBp7HvXFMoNdv6DnLngpLQ6EQEUK1Hco=;
        b=XoJgok4jrQsdOK9RV4PX21A9ArIPfdyt+Lkrzq7NpapglUCw5Mprj8PK2jvMUshgao
         MqFVxbF+sdRXoxSNiafx7XbOSZVRGWU+EnRiSt57b9Q4TppUpxEu1kVrYBjST3cHw/9F
         llJ8Cs4/0vtWPCzTh9Em/M5+0lrCeiSuS46jqN89vxeH7tTe+ZnWdXczmKGZmrQubiqv
         cHVWuhc0vsJsvHu+YW7F7Lcudb0IrqQoQoCQFCobByWfDVv0+ETZE3ds+wrouHvy9fho
         jFY8RG1eyFzQmDTB4bFBjE+lRdd2l3Er/H2nKbV8NuxunXNnOrwVXY4whBMKbfcYl3Wi
         6wUg==
X-Forwarded-Encrypted: i=1; AKwUvBwtyxLTFKeRNg9kM+GGS8fBW+WyJVImsBLeQet5QlRj+38zqubpR6LxEYRUbI22z+twUQ0NGegp@vger.kernel.org
X-Gm-Message-State: AFuF++mx0lJuKEV7nthjWsmSLaz9vUs3WvZolVl5/OfrQaQeSVRJGyA/
	orHHVGOwn3neyyEbXuvpIaoYpfni6rKPXfG6GC4QIFFp/tIERGA01jhLBxWYBActYN8=
X-Gm-Gg: AYBFou3shxvRvTvRpLJ032ZobRH2V/H7sLqrlGY75PEn8Buoj2uDsnns2cdk9f6dwvS
	7s8oskc9I//rBay4y3xeBqNXgSFhAy2GijVuh74KBqB0lzADj7OKvR5eyKM8WaXfa/LyKQXwIIi
	88sAoj1X9OIEsE5TLqSVYyNsQukXGtmJKUikQHtfobR/ZJ5DYWar54sV0WHdEnaasIiiuUpcnd1
	6Yj9M8USsJAhmTfk9vzMKCZt5A4tfbfQFC1Anv9cvhoDzKz+s4j/VAzAQ2BJxQwsnuteMD94Z7h
	/T8yJQWpzZMcRO//h0lWHxuMadXqeaRWawaYt38ZiAV4dar1bW1/tiPhtXIlENYE1NbNCqJFfJG
	UfGtefEj7JooPXrgvkl49FSjkXNL3jBBT/cOkynmZbx1s1ZtXw5DexafOHOC1VE1qJ/vFq7ueW3
	iZ8IAamnqrU+2a8SBa6wqrZXk3rqI8Nu4O0m8Fn1OeP91xjbdi4xqL1Xw6i6mTngNTTrtS8vUBG
	jQzdk6VSsbFj3GDKIpEljQxjDNiBTNNm1T3NLdCIQ7ucbZAXod5rd4IC1ihwI9XNl9OW5I86poF
	rZj5o6vCqxV4rtaYi4ns/I16I4ccg3VGtlWdFLM=
X-Received: by 2002:a05:690c:dc2:b0:870:47a0:6fce with SMTP id 00721157ae682-871225989c2mr154470257b3.4.1788998711977;
        Wed, 09 Sep 2026 17:05:11 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:bfe2:d67c:7903:eb5e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62503dsm118699177b3.38.2026.09.09.17.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 17:05:10 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: zlang@redhat.com,
	fstests@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de,
	vdubeyko@coreweave.com,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] xfstests: exclude hfs/hfsplus from generic/339 run
Date: Wed,  9 Sep 2026 17:04:50 -0700
Message-ID: <20260910000449.747189-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dirhash_collide generates filenames from arbitrary random
bytes (only '.' and '/' are filtered out), which are not valid
UTF-8 in general. Catalog names on both classic HFS and HFS+ are
Unicode. Feeding random bytes causes fsck to report "Illegal name"
or catalog corruption that has nothing to do with directory
hash-collision handling, which is what this test is actually meant
to exercise.

This patch excludes HFS/HFS+ file systems from generic/339 run.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 tests/generic/339 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/generic/339 b/tests/generic/339
index bf8f7729..5cc1086f 100755
--- a/tests/generic/339
+++ b/tests/generic/339
@@ -17,6 +17,15 @@ _begin_fstest auto dir
 _require_scratch
 _require_test_program "dirhash_collide"
 
+# dirhash_collide generates filenames from arbitrary random bytes (only
+# '.' and '/' are filtered out), which are not valid UTF-8 in general.
+# Catalog names on both classic HFS and HFS+ are Unicode. Feeding random
+# bytes causes fsck to report "Illegal name" / catalog corruption that has
+# nothing to do with directory hash-collision handling, which is what this
+# test is actually meant to exercise.
+_exclude_fs hfs
+_exclude_fs hfsplus
+
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-- 
2.43.0

