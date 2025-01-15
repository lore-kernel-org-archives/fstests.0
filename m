Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9121F9F5C
	for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 06:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920988; cv=none; b=dPNME9LOw7GKQpjt7LMj1KRIdY2X2Q6v5bC9iCs+FgRmjL7+WKlTuNIPJKqbqa+wZGzfs58wVXlqBHNmLkGVVCeyhspS/YXv6zGcom35umSIcGRIHeW884Grh3s6wlGNgcebNxRnS3OX7l2i+9XG+9KzTVdfq6poO8f5Lak62wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920988; c=relaxed/simple;
	bh=70aX2grdn7mhJu+t9ymdcv9dvII1AWUBMNOgdPqHuQI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OW4fjuCOpL2fx4j6lLHJAqMSyHn2AcwiMHsPuPj+ODsN4HR4DNBTfaBRyJylRc0YysIjdIsa/QY8bY8q28riKW6ohvD8MopmBsq6AR8fjGs3gNKmSIb4PWMu/jegiNHCestw6OiZssCjAboVsbUYepF1vGjZPSA6gp9eT5Meu/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=AvqCQ/3v; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="AvqCQ/3v"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-218c8aca5f1so136970875ad.0
        for <fstests@vger.kernel.org>; Tue, 14 Jan 2025 22:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1736920985; x=1737525785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfNZ2QuURZIoZqHQzg7cCMYCy3ZgmB4MlCZfMTYK5jY=;
        b=AvqCQ/3vFGmeyX3dISw//NFkf79xnH9nyKNWHNXoulNKO7xH+1Xy8kQEftZXqbXbuh
         rfoDxSt/VMaWGhd9UsplGd5R5xwtJcLYbTz+7EmpuJkrnmcAKLl5pef1YE4wS1ae3NBT
         uUkeNkKqyyDIgkum1dkmj4wAG4GV8NYpT1/x7py5uzLiqG+GM180/9mTx3rrXrAAFvOx
         PulOMNACBef6aj5qJdC4xbRmqDmsMVYEDd1a+fPkkIzhr7d3CvHKBh62cqL0NRaFOffo
         LZLEF1KnvXI6+f2w1V0DRV+SRv7yA5qsuXTZvLB7FLrmWOLsobHtkqy8hK1cjxvkHf3K
         1+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920985; x=1737525785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfNZ2QuURZIoZqHQzg7cCMYCy3ZgmB4MlCZfMTYK5jY=;
        b=B+zjcrltfjVVKTyjK8ORPb/6/Gdk5Lq6poh7XYMt+qGuf5z2sDf5PK+VepHPXBn0Qc
         G/LKxE+/ggm5f35vhKu5G2WYAg6L0iKLqu1OW87f9D+H4SLZVVfB9JmkcgEoBZ4YsA1Q
         3IzAprnd3LLST3NN2BuTUqR8n5Fk99x9eePl7UuRIm9HZgLEHNjGfY4gfyH+hK5eHlmM
         pQ7SVPoEofOSo2ie/3WG7a5atlKSx5elfEEs4wgxfF6gK5864aGh+K02vV4SSamTvn6v
         LALqSDKrgwi6NIl87Fcn3FWuAPI3T0xvG8d10v0wTX3sOsRv5tUyxeJKtiGjnjoUkdro
         E+sw==
X-Gm-Message-State: AOJu0Yyu2SaeaX9eq3z4KzkD6NseF8mlTWelhGgZUgBBKcu9YirqzGgU
	xARGDjpVHwSAI5wSdCOlRGD9FoqPRf27/jghyFQhJSji9/4SLRPPvOe00zgOPyc8PrweYzYwu4U
	P
X-Gm-Gg: ASbGnctndgx1KIjhLjo1OuuY5dkI907EqscY8MtuVWwyWiqFcFeQgbLrnU0oqlhXv+u
	Wt9r/Nquodw9wK0qYq9SzukliEaYe9whZH6Y6jhC4p7sQmFBA8vAuAwPxJr1u/ezA7E7tCaTmNX
	Gc0x/sJiJNBalhZCQssDa5yF4Qg+X+AkoPlsFC836IwfPGAXXmqOuo7gmIcF1LW5yHHgguFrfCE
	X1CuDbWYmX6Z2Pkb9uttCLhf6WUKAsQ05Sl/VJK5mdBSNwDYHImN67f0IN1oL+QtlW54BypUH22
	0dxsTCXtVj789oZXkokOBGxwdctQ17k=
X-Google-Smtp-Source: AGHT+IFnnF89oPAIKI03sym3L10IADQsfgNQOI7i0htwSVAtWbMMhATCaDl6sPyxYLokSEW5yiADuw==
X-Received: by 2002:a05:6a20:3d86:b0:1e0:c5d2:f215 with SMTP id adf61e73a8af0-1e88d18b424mr9578958637.12.1736920985244;
        Tue, 14 Jan 2025 22:03:05 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31d5047e01sm9099263a12.54.2025.01.14.22.03.03
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 22:03:03 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tXwUW-0000000641f-21rJ
	for fstests@vger.kernel.org;
	Wed, 15 Jan 2025 17:03:00 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tXwUW-0000000GabX-2rPP
	for fstests@vger.kernel.org;
	Wed, 15 Jan 2025 17:03:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 4/5] check-parallel: add logwrite device support
Date: Wed, 15 Jan 2025 16:51:15 +1100
Message-ID: <20250115060258.3951185-5-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115060258.3951185-1-david@fromorbit.com>
References: <20250115060258.3951185-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

It is just another loop device per test runner....

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check-parallel | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/check-parallel b/check-parallel
index a341c9c2e..498b53c5a 100755
--- a/check-parallel
+++ b/check-parallel
@@ -208,12 +208,14 @@ runner_go()
 	local me=$basedir/runner-$id
 	local _test=$me/test.img
 	local _scratch=$me/scratch.img
+	local _logwrites=$me/logwrites.img
 	local _results=$me/results-$2
 
 	mkdir -p $me
 
 	xfs_io -f -c 'truncate 2g' $_test
 	xfs_io -f -c 'truncate 8g' $_scratch
+	xfs_io -f -c 'truncate 1g' $_logwrites
 
 	mkfs.xfs -f $_test > /dev/null 2>&1
 
@@ -221,6 +223,7 @@ runner_go()
 	export TEST_DIR=$me/test
 	export SCRATCH_DEV=$(_create_loop_device $_scratch)
 	export SCRATCH_MNT=$me/scratch
+	export LOGWRITES_DEV=$(_create_loop_device $_logwrites)
 	export FSTYP=xfs
 	export RESULT_BASE=$_results
 
@@ -241,6 +244,7 @@ runner_go()
 	umount -R $SCRATCH_MNT 2> /dev/null
 	_destroy_loop_device $TEST_DEV
 	_destroy_loop_device $SCRATCH_DEV
+	_destroy_loop_device $LOGWRITES_DEV
 
 	grep -q Failures: $me/log
 	if [ $? -eq 0 ]; then
-- 
2.45.2

