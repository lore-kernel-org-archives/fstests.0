Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E31553389
	for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338492; cv=none; b=AT4rIvRSWQmZrDbSouMunWT2p5gu9BgAfb5AQhIOKC5GKBhWqKgjIViTfgoFCUErAKwNA/UGXKRCNQ2385Epb0q0yfWYAC89Wz3r8oE28VhFTmULF1gHwZepvHRVKr2p7Mjo8rEbxH0jebLcP9VWU19ZGW3NY3GS2GxOgB6XOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338492; c=relaxed/simple;
	bh=IIBE5r7JHTxOV7+82WCt+7FC5WUNqQra//neAiJO398=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bQjq5z1aoPRVwzqVz7xVrdT6PmIkIxduPklktcAFENW/1gr1BjvaxEnC1bh4wvStYHB8Bq4iTMsVNAxuV4G6R6atV1Jm0VhMIGPcAL5uOfQPcUCuvY9tE0stqY7chCLlibRd2H1Ml7A47gbxpbf7t7xr7ZLk0+/3x4wzMC77XHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZjAgQB68; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZjAgQB68"
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F3E113F2B9
	for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731338482;
	bh=UxsVF8hSpJ29Z9qLUkQUCmyF9bhH0xObTONhJfT8CBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=ZjAgQB68nAtm1izXoxMvp/2JGSdPy/2O/u8OhptyyzaWXKxtTq/jhgQtAUAyq4aYG
	 /dSZT/FO9d7Bef8XpCt6YHvvYctmllBIMfbzonxwmUIN8O/BtL8pha68RD8ESS0tek
	 wJrc45glYtYPyhvCG7+cIP15kvJ38ImV4Vi47+mYFQE19AZBLTg8KwmPdMnyc2a6ar
	 rvtmw0wl5DdVyzz+qO5GSOvMUpMk4qtW8LI0yimteeHy5CuMxNYtMHIPPcWScU6DFr
	 e6ajMMFIkJ+t5WMyiCxMdHhD0leayIP5sBaEZSf515E/I3P0Zf8HLWFF8tfQ1ZQ5PX
	 o10qrETu+NejQ==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a99f084683fso429351766b.3
        for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 07:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731338481; x=1731943281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxsVF8hSpJ29Z9qLUkQUCmyF9bhH0xObTONhJfT8CBw=;
        b=nYcAbKRG2a6dHqjuUADRapA0wFotYNwcwfs2cPfRow/3x+PTiJwUsW0yxGCznVfCzV
         NQ21FztKp+Mpae1GNgF9GpygmVShxK7nqyiBu9t2RzF6l+Em6pq/Umnx0dRUB/qPPZvR
         aG3bmQ5RiqEvCx6wfSa5UUjVlNUkjvJ8XPKJ26clMnOhjy640QzzAoj+DfSO056XQgEQ
         oRHhu2S2/2ZwdEjvUqEm64BCXPBDd/11ujZzF+m8OI/3/MesNNNXLBqUszCjnuRB5opp
         xFVaCXLmzKChg7jSt9ciCeuFhA5t37Mi281PgMY5BqpOqfh05gQAww83y71jSg+S5bEm
         7cRw==
X-Gm-Message-State: AOJu0YzUzz7lRmQvCVnk/zphTD+l5H5H76vgPu1PZo9yUGnROwJWctmQ
	AudYU788wzQhJJ88pB2hIBH0mLpYYbc/JKDHkRfAmmVbKKWkVWTkeyJFzyswHLwM7CmuUcaNKZX
	XSGV+RO0j+orT66iMGMiYyG7MNFzG1FXESZcZTa1s1pRzQi6fXAT8Zd4OG+1nfubLRC3+Zc7wJI
	3pg9MkFA==
X-Received: by 2002:a17:907:9483:b0:a99:fe71:bd76 with SMTP id a640c23a62f3a-a9eeff44678mr1452424066b.34.1731338481003;
        Mon, 11 Nov 2024 07:21:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQQuKSVIyFlgrG9ZavwCUBdqj175JxVD/+sPLv0IoGvA4iD0GIZwCfNeviMBaHTbVNFQpWHA==
X-Received: by 2002:a17:907:9483:b0:a99:fe71:bd76 with SMTP id a640c23a62f3a-a9eeff44678mr1452421366b.34.1731338480675;
        Mon, 11 Nov 2024 07:21:20 -0800 (PST)
Received: from amikhalitsyn.lan ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dedc3dsm600736566b.133.2024.11.11.07.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:21:20 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	libaokun1@huawei.com,
	jack@suse.cz,
	tytso@mit.edu,
	zlang@redhat.com,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v2] ext4/032: add a new testcase in online resize tests
Date: Mon, 11 Nov 2024 16:21:00 +0100
Message-ID: <20241111152100.152924-1-aleksandr.mikhalitsyn@canonical.com>
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
 tests/ext4/032     |  6 ++++++
 tests/ext4/032.out | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/tests/ext4/032 b/tests/ext4/032
index 6bc3b61b..238ab178 100755
--- a/tests/ext4/032
+++ b/tests/ext4/032
@@ -10,6 +10,9 @@
 . ./common/preamble
 _begin_fstest auto quick ioctl resize
 
+_fixed_by_kernel_commit 6121258c2b33 \
+	"ext4: fix off by one issue in alloc_flex_gd()"
+
 BLK_SIZ=4096
 CLUSTER_SIZ=4096
 
@@ -136,6 +139,9 @@ for CLUSTER_SIZ in 4096 16384 65536; do
 
 	## Extending a 2/3rd block group to 1280 block groups.
 	ext4_online_resize $(c2b 24576) $(c2b 41943040)
+
+	# tests for "ext4: fix off by one issue in alloc_flex_gd()"
+	ext4_online_resize $(c2b 6400) $(c2b 786432)
 done
 
 status=0
diff --git a/tests/ext4/032.out b/tests/ext4/032.out
index b372b014..d5d75c9e 100644
--- a/tests/ext4/032.out
+++ b/tests/ext4/032.out
@@ -60,6 +60,12 @@ QA output created by 032
 +++ resize fs to 41943040
 +++ umount fs
 +++ check fs
++++ truncate image file to 786432
++++ create fs on image file 6400
++++ mount image file
++++ resize fs to 786432
++++ umount fs
++++ check fs
 ++ set cluster size to 16384
 +++ truncate image file to 98304
 +++ create fs on image file 65536
@@ -115,6 +121,12 @@ QA output created by 032
 +++ resize fs to 167772160
 +++ umount fs
 +++ check fs
++++ truncate image file to 3145728
++++ create fs on image file 25600
++++ mount image file
++++ resize fs to 3145728
++++ umount fs
++++ check fs
 ++ set cluster size to 65536
 +++ truncate image file to 393216
 +++ create fs on image file 262144
@@ -170,3 +182,9 @@ QA output created by 032
 +++ resize fs to 671088640
 +++ umount fs
 +++ check fs
++++ truncate image file to 12582912
++++ create fs on image file 102400
++++ mount image file
++++ resize fs to 12582912
++++ umount fs
++++ check fs
-- 
2.43.0

