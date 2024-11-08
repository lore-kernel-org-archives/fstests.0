Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA21F4FA9
	for <fstests@vger.kernel.org>; Fri,  8 Nov 2024 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073717; cv=none; b=a8G61XRpw/o+C7cN7EINWwFef61fmk7e9/WG5dL+a6b8NKtVMsBNJ11k9px0O4F9FhbxF9XzX7k5TAdT9nkrtvOBhiqZjFR+MGF6+ftwEXcyraG532lxX4vU9rk/USLoe3qsXQUDkLSSszIra+/A3Uzjwh6SgxEnN1lFde/ah2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073717; c=relaxed/simple;
	bh=HXll/USNPXm9osgO9GDNWVRMyn2qi6KDiYjdAd4rm2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GXTI5eQO+7zkMxg55kGdmuEi3Ap8Hl7RgjEjVOi8mv76bgyCHFAa+v7FaALx4byFs1awyAgo0N0O4Atmq3MU2SHWYJRYQRyvoOHOAAT576CsmdPK6Ypbu8EmdTyafVgh9gaFCWApu02bxrpjKi0l4QVC4qCF6kAtdedqlgQCMvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oFZkhia5; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oFZkhia5"
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4893440C4B
	for <fstests@vger.kernel.org>; Fri,  8 Nov 2024 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731073713;
	bh=NetQDVoDx3YBHIR6egryvpy51aqIFhsEmHs2mG5SPpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=oFZkhia5xRhmitE3MwjcWfr74vjCSu297iRsOiJxh2KFTem6gR6IpfyU4uOa5/89M
	 my/ELoGABdDh8SfOLQsXerrgS0QJRrh/k/v0YD2XNzFyREoKJcuJjggvLdmBJZCqqf
	 su+YxgpACD514bwSDlEy7C8so7ZfuAPkl/QxDZvExijdktcJrn4nUgb2Y+UxyzFcOB
	 JxWJ4B1TVw7RWC22QbpeSi/seSW5vsDTHmx4naTg+Kge5GnvhiEBNKw8+VnA0BhTDn
	 MLz76YoL9wvVsfQH9mdPnxNFm78KxHIF0vicBueHnOhjJMmXPsDZW4MfcGYtcisL3+
	 sgAXegVv+xUfw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a99f43c4c7bso145896166b.0
        for <fstests@vger.kernel.org>; Fri, 08 Nov 2024 05:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731073710; x=1731678510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NetQDVoDx3YBHIR6egryvpy51aqIFhsEmHs2mG5SPpg=;
        b=MGeYjqUUQhnPe/oBgePAXsUPp0fDc/QUZ+kh7urAwShNDSPh8MwRReB6o2mucWOEDs
         iC3vySU0kUvYdao3/zlRFS9qXStXq9Xnr36mZNO3+CzPeVrXJUY4FoFW9A26Dn0Sl7Gr
         GUEwjQF+vkIK8f9+eVjhhqOAxTFmVt57lJTDMCq1tMC/+xztnH0M++kNluIuZ8SIvrV/
         oNmnMuSB6f21aWc1vHx+bahzQ7UqBPlbbAugcZSHxfDcZ4cnbjH+uoWgd8F7WRhkBJHF
         X/f+EKOxplWIwUNEh503SO3p53kENh+M80XytDJEv+oWMtGw6lVu2u0hyf5tFHJrjEzQ
         xu9Q==
X-Gm-Message-State: AOJu0YwBCeOSN7fxCPsHi1G1SHdggKWKKtPNnSzo9S6tV4bMRn80X5Nc
	tTA/iP7Mt1Gv2Jt1ZpMGDSDWNGjsd0JZnuCvSswr3tF1FT5/ldMEHChBl59Yq0G7yU0y3B4h+cj
	yI3rXLi/SlCyErDkuMqakYRymmhrSkWLi6LFXpiJE6vNHNf6TIG8n+gxcdWyhJAQIWbvBFO8+O5
	74gUBCoQ==
X-Received: by 2002:a17:907:a09:b0:a9e:b5d0:4ab7 with SMTP id a640c23a62f3a-a9ef004ab81mr291565166b.52.1731073710004;
        Fri, 08 Nov 2024 05:48:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELza7P8x5H3b/u2qEA2ug56jAkmBU7ECYtpN4HyVG0aKkn3lo7Jul5BbYnaLkLnCHrUKT9xg==
X-Received: by 2002:a17:907:a09:b0:a9e:b5d0:4ab7 with SMTP id a640c23a62f3a-a9ef004ab81mr291562966b.52.1731073709621;
        Fri, 08 Nov 2024 05:48:29 -0800 (PST)
Received: from amikhalitsyn.lan ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2ea76sm233539966b.205.2024.11.08.05.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:48:29 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	libaokun1@huawei.com,
	jack@suse.cz,
	tytso@mit.edu,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH] ext4/032: add a new testcase in online resize tests
Date: Fri,  8 Nov 2024 14:48:17 +0100
Message-ID: <20241108134817.128078-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new testcase for [1] commit in ext4 online resize testsuite.

Link: https://lore.kernel.org/linux-ext4/20240927133329.1015041-1-libaokun@huaweicloud.com [1]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 tests/ext4/032 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/ext4/032 b/tests/ext4/032
index 6bc3b61b..77d592f4 100755
--- a/tests/ext4/032
+++ b/tests/ext4/032
@@ -97,6 +97,10 @@ mkdir -p $IMG_MNT || _fail "cannot create loopback mount point"
 # Check if online resizing with bigalloc is supported by the kernel
 ext4_online_resize 4096 8192 1
 
+_fixed_by_kernel_commit 6121258c2b33 \
+	"ext4: fix off by one issue in alloc_flex_gd()"
+ext4_online_resize $(c2b 6400) $(c2b 786432)
+
 ## We perform resizing to various multiples of block group sizes to
 ## ensure that we cover maximum edge cases in the kernel code.
 for CLUSTER_SIZ in 4096 16384 65536; do
-- 
2.43.0

