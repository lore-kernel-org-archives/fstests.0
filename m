Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373E158DBE
	for <fstests@vger.kernel.org>; Wed, 24 Apr 2024 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957905; cv=none; b=iFApH+oBXRsudUOry04b/QhRix8tuXELkV7amiOAfSz3gWICMepxYZhLaLVBHlYbM6X1Suqr7cqjtZmKRaGQhuAeAyj6fwECIrX15NPlMf+BMwFx3drH6+yMheZQuBj+DGZeCtCdciOJjrLckIz3es2schZQjzZTXJqeQOrkojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957905; c=relaxed/simple;
	bh=6q76qNl/gjUEJ5R8vVEuNalEJoOMwXU5zJ/bJIpXnRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RsS0/vkCFF8ywQrsxUyiKMfCVIfu2KqCHS4CDlGftmvLgVxD2vXGhtgb0tJEOHZ4gfCQKvF8hIOueNYwuPNoaj8e4ysHb1SiXWyVEkM9Q8VmGbNBDtoLfyMfpn079gf3/P/u46Hl9xVPMurz48S5Cz8cdYBujdVHS95x4JdUcts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PcAmRVUb; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PcAmRVUb"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso101123971fa.0
        for <fstests@vger.kernel.org>; Wed, 24 Apr 2024 04:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713957900; x=1714562700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hjguGVI21JYZb/wzAfcONkBTpl7IuZ+8BGZJwL6ABdY=;
        b=PcAmRVUb8fkda7yexhbs598W8xzBKgod4/dGdlBCU41KFUe6tH5jqSQ9yYtf/VecaI
         D04wvuQZZpZByi36RNP8dFDal3KdumE3YpDfH6vGUIkyca5yic58SZO6OH9dnsJ+dovy
         vpZXMRzZBRBJrUtLtkdhBhXk9DBXTuM1hV6Q0VCZKC7Xk5e81dcqh8K+Pot0Pz6MAimf
         n1lCw4RFkdTrieLf1uPbTykyI8bk1s9SujpovRM2MC3kZHOQZ0vdV+SZmBYH05kBUy9G
         HK0rpMfV/z4pBf10tMFkZ5ocam64ckZncOg8V3ecdgvmImdBgoKo8fIfvfaBaQN5Khis
         5aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713957900; x=1714562700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjguGVI21JYZb/wzAfcONkBTpl7IuZ+8BGZJwL6ABdY=;
        b=r/1n8hTHj0wkXzb5SI5aVKGwBWlvf3EZiEb54IHXjG3gt2ghjadJmRyoaSOY7QhKz0
         ew22nEx77WUXbi/286b8lVtz3A5F/jrM3rDDIBf1tqESlOZv49CNHOtLlZd+Pq4rKG76
         tS5ZCOiz060ftlHtsbsu210Q+681dqrr53hYUD1simMqVSuVwACHYy0XhIlUrSKEdg0G
         gkj5Yw9TWoHV82N4CRE2ZMjd6iKjurCEi9QRlaWW7iTe5xLP2ZwIqt0XmLVdJTXZzq8y
         lzsICqe71MjspvIhRepYCs3jwKnCrVKSpXPZ08PW6Ckv1Ht6a7hVy5BYYnHjaoIpTpC+
         yjdw==
X-Gm-Message-State: AOJu0YxM39+VxilBNUMmlHdpuEhNAs7T5k6CQt9j0nrv96QNAMQ91M6/
	Pma8TP8K3TMIMKDiwMjQ8FqxXAROb0vODM66x25u6Kn8sWyQrul6fpMlwI+z7lopYe1qSqs+gYc
	CdLccIQ==
X-Google-Smtp-Source: AGHT+IEGHXMspiJx+vfX1Rv5J5SJ+X9yildy2PuKAHQ0pBCV0aL0f0vg9k5bb9myujw/BKMuXpzFNg==
X-Received: by 2002:a05:651c:1a2c:b0:2d8:4a22:7536 with SMTP id by44-20020a05651c1a2c00b002d84a227536mr1630401ljb.48.1713957899803;
        Wed, 24 Apr 2024 04:24:59 -0700 (PDT)
Received: from localhost.asia ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id o24-20020a170902779800b001e5119c0f9asm11696124pll.66.2024.04.24.04.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:24:59 -0700 (PDT)
From: Yong Sun <yosun@suse.com>
To: fstests@vger.kernel.org
Cc: Yong Sun <yosun@suse.com>
Subject: [PATCH] fstests: solve no-return-in-nonvoid-function issue
Date: Wed, 24 Apr 2024 19:24:08 +0800
Message-ID: <20240424112444.20964-1-yosun@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When build xfstests in some platform it will return
no-return-in-nonvoid-function error in dio-buf-fault.c:83 and
fake-dump-rootino.c:224, add return value to solve the issue.

Signed-off-by: Yong Sun <yosun@suse.com>
---
 src/dio-buf-fault.c     | 2 +-
 src/fake-dump-rootino.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/dio-buf-fault.c b/src/dio-buf-fault.c
index 911c3e1f..6b07c729 100644
--- a/src/dio-buf-fault.c
+++ b/src/dio-buf-fault.c
@@ -79,5 +79,5 @@ int main(int argc, char *argv[]) {
 	c = ((char *)buf)[0];
 	printf("%u\n", c);
 
-	do_dio(argv[2], buf, sz);
+	return do_dio(argv[2], buf, sz);
 }
diff --git a/src/fake-dump-rootino.c b/src/fake-dump-rootino.c
index 8a30dffd..cada223a 100644
--- a/src/fake-dump-rootino.c
+++ b/src/fake-dump-rootino.c
@@ -221,4 +221,5 @@ int main(int argc, char *argv[]) {
 
 	munmap(header, GLOBAL_HDR_SZ);
 	close(fd);
+        return 0;
 }
-- 
2.43.0

