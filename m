Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E698FC1D
	for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036680; cv=none; b=I46u19GQYZO9snLOMEmwgm08wyd4TkgbXm6ZfVrDqH0+ZlwMnkVjXUmyLS1GcJqcSyPPqPr6+u9rwTNCNnpQmDHTuujTYfwKe2JSCU5TgirwPGCDGpsE8tLYqul1ggf2ZPH/4KXVv2e2Wi1cNTh5vMjQxqXN6oTkVAq4gijf7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036680; c=relaxed/simple;
	bh=hvEHSN4nBH2S39NUuQk7COo9uoswhKjoLVMgYsSA3VI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XZH6fydTXQIoVnYjaVRfQp3zU0v4WDVpZOaTgdh4IXP5JdMQDRCbsHoUMn001bkNVittEsLJgmzRKwOVMYg9FUd9po32AGHK3hq2xPw4ZzAsjtlQ3aAqfhSZ4YtN3Ub29DvPW9zSJ00151tjSQAt4BOzY4FhyIg4mGuUXURJVrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XujUiNFA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XujUiNFA"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24cde6c65d1so49039085ad.3
        for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758036678; x=1758641478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0F/09+ybJI0nYASZ6JtY36KtMl7rPmjhGN6nI4HUYo=;
        b=XujUiNFAa01x95ap1O0ZZ6z7vtAINeWwiZJQQKeMtJPeskhj/8gebvLnI4nkHe7tC3
         N86E9gkdBwgwE773l4X6sBlmWJdh/kuRIGAHxxwO0eBESArDAbpsoFu3E05Mc51WHpZN
         rQ/dXVBSlqsHC/ilnXsxE5EzLXZH1BWzafG0tprqCMgLO7IjDVwjC8zdjzlEP9jjkcHU
         5W4Bo6vA9skzfp23zhHvDcwIC8tDEwmf1F9GjUruFllEMjmlXmvj3ijziIq5g8KK6MuO
         7oGQy0ignQBNHd+H4j3Do9EpNSi0nLJKw8gBmspbQba7p8VdSx4/tFpUqo4cG8bCVS+L
         H/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036678; x=1758641478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0F/09+ybJI0nYASZ6JtY36KtMl7rPmjhGN6nI4HUYo=;
        b=lVlJpRzGdADNJwbxlXfG0pefrI/EhErxykIK+yaLWLPqT6BgpLJaDl9EJv27Qp94He
         zsYrq1M6CQwRqZpg12Sha601tUNinV+McPIbjQ1KAG3+a+rskH0JWUux5lHlwsuPUJKM
         yJcBj1rs7Sak66MKoNzX5E/kQSkK+b4GtzoQ9SY6ehNCbVDAAL6YcISr1HZp30ahNAkB
         8WadFlCLlW4AmetD5BHPWN+qwu/03mkHqMgv7R1t6Q8z2dv+xXlfDJ/64Ry4JFRKuBO9
         GyBJUcGRTTt1TIc2t+mVNlhefckyX6NQ5MbGnjk5cFPFiNTsDXKj+2IVEVzrMl+qz7yV
         ihEQ==
X-Gm-Message-State: AOJu0YyogC8n0xxYT3eY3XwtII/3nbSfIRs3U39Tpcy2Sn5w8XZ8kKv4
	27yFf82gfbpg+s4tGqYCZiTynO6Jv2FVCAkxR1NuvILlcWbCJtV6swdhNYDLkQ==
X-Gm-Gg: ASbGncsKxCKzSjMvMU8IJbAUJbsPfL10coKh0jqsTG+t2bDmxk3jlvUMVvW9NMgIjGF
	wOafGM6q0EA7YxWU1QClDZRso42ooHL0h/7Nwu0YkTiL532LTAv0B2wWx+DUjMnpXe4WwjMENhs
	L9lBo+6q9ow4JYEfC1GQ9q4hiCecF1bwgQnSqyd3xFN98sQwO94HcdBddPEMGH9qAAlDui/c2FE
	p1nXoZiTQwrGAkOdsSajzZBI5Jl1n91wb7SHu+buli+rVyk+DZndgsEfeZNlb0niQN1vxWpOucX
	cgA4VbGAZNspy0pGZYlu3h4nMVfVU65ePhyfYMUr2e/V4epCt/nCeglNG0PxzDgFZm8M/7aEcX3
	g3Ds1zJcYg3EiqbKRu1KUeYKlFNA=
X-Google-Smtp-Source: AGHT+IGRXG2BviwEvYZLsr2TRQ8Fpwh2V2yKV4NAu3KLgR8/pjai6DH03269UbfyLWNr1SLLf/fVRw==
X-Received: by 2002:a17:903:3804:b0:25c:ae94:f49e with SMTP id d9443c01a7336-25d268649femr195970485ad.37.1758036678138;
        Tue, 16 Sep 2025 08:31:18 -0700 (PDT)
Received: from citest-1.. ([49.207.211.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-262df893ec5sm92596345ad.46.2025.09.16.08.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:31:17 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: nirjhar.roy.lists@gmail.com,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	fdmanana@kernel.org,
	quwenruo.btrfs@gmx.com,
	zlang@kernel.org
Subject: [PATCH 2/4] generic/562: Make test compatible with block sizes till 64k
Date: Tue, 16 Sep 2025 15:30:10 +0000
Message-Id: <b3ce6c555b0a04f6c8cca08ab36e3b0068abbbb2.1758036285.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test fails with 64k sector size in btrfs. The reason for
this is the need for additional space because of COW. When
the reflink/clone of file bar into file foo is done, there
is no additional space left for COW - the reason is that the
metadata space usage is much higher with 64k node size.
In order to verify this, I instrumented the test script and
disabled COW for file foo and bar and the test passes in 64k
(and runs faster too).

With 64k sector and node size (COW enabled)
After pwriting foo and bar and before filling up the fs
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1      512M  324M  3.0M 100% /mnt1/scratch
After filling up the fs
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1      512M  441M  3.0M 100% /mnt1/scratch

With 64k sector and node size (COW disabled)
After pwriting foo and bar and before filling up the fs
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1      512M  224M  231M  50% /mnt1/scratch
After filling up the fs
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1      512M  424M   31M  94% /mnt1/scratch

As we can see, with COW, the fs is completely full after
filling up the fs but with COW disabled, we have some
space left.

Fix this by increasing the fs size to 590M so that even with
64k node size and COW enabled, reflink has enough space to
continue.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/generic/562 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/562 b/tests/generic/562
index 03a66ff2..b9562730 100755
--- a/tests/generic/562
+++ b/tests/generic/562
@@ -22,7 +22,7 @@ _require_scratch_reflink
 _require_test_program "punch-alternating"
 _require_xfs_io_command "fpunch"
 
-_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
+_scratch_mkfs_sized $((590 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
 
 file_size=$(( 200 * 1024 * 1024 )) # 200Mb
-- 
2.34.1

