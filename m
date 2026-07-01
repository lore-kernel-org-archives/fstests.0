Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53D35E1D3
	for <fstests@vger.kernel.org>; Wed,  1 Jul 2026 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917335; cv=none; b=ZUaxCXQgHhn81uCRXHcNwaLMLtip9DWKjMrfuRhPBmgJE2MZ+M2j+2HeNx3pefzCSIH/v574pKZKUkbPj5o9cO7pCqsHXpGpNbQwF0BBM4mhyKYs4nnRXdlVEIrUgesK4Udmg8g+Ob3JpZ71H0jUUlaS5tiP/pReY9dg68BiLjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917335; c=relaxed/simple;
	bh=YLCnsCeVPpiU5AYlu10LkCcKUGtUQQWV/4aECWQjeWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUaTUs9CFIxIMmdniLDZZSnTpoBx++k0i8JSShVmLYIAkYqA/AWxrUNDejI37sUsXbhw760Qn+A2dOpjdl/3DLVmOUHPlDGskwy34IRL58ezjHBAIDSm1ViVIwJ0oxYmqLXdi76TFk545rMq23WqIY3odoYwfkAVx550evoV/84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PUDOp0FP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PUDOp0FP"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493c19bad03so5620205e9.2
        for <fstests@vger.kernel.org>; Wed, 01 Jul 2026 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782917329; x=1783522129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zf9XF72PcvIpy6O1yXrgN+iLZbdjwbdbWkKJmvaKF4c=;
        b=PUDOp0FPv2x+Pitl2r2IdZU9EtJPAD4er6uy/dO86WjKr3SA73AOEzte32XxRUr/FY
         iBg6COiGoxrF0ohFf5LYsX748YQNm7ttFJZUvr57MzEJZr2XW4a1d3gPPXb5lIVt00vo
         rKSdRNfhBtu55b9/S7N9pbLiy9vccNyTtjS/U8lw8ea52toad6SFMADL0CW1oW2jfVYZ
         DWovnCIEnLktiLn8lCt69o//o9Y9H6iBwnDmPwTnF7IU1jqMtaX+LhMK0rvvYaSU5l3V
         sxAMrt1OEOhejf3kdYQG49RTbC1RmuXpC+bxn+c8M4RVqooe82tplAD74QYgegsdhdkz
         BQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782917329; x=1783522129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf9XF72PcvIpy6O1yXrgN+iLZbdjwbdbWkKJmvaKF4c=;
        b=h1ea5IYKpDlLH+l37v3JF0P5d/hZV+4qD2Ff09kdAMchbhXh+nGIjRUopkeDKyFgw1
         kXCbdRJdRxuqWBEiLbpfwGWGWkxs7bp140LdGYRSeNLqnzbri4hPSLa7ECAy9vNmLLIM
         cQO72g5TehDNW2PpUZaY4LKNtXBt3y+oBQl9xq3HFqCn9jhJryMV/28gGAhQkW9EdtIi
         hd+mSLroADbOuRvkRXUhEz2SKnmx4JvpK0USneXpvVhBurwcl4ay86w8lydPgKlFo1CE
         GNh2J+vNnBSpwCrYfbPKu5k2vfG+fPoopOkSzoMc7vUS8SuYlfEwC/qQSJqFXBxUriWr
         /wKQ==
X-Forwarded-Encrypted: i=1; AFNElJ//7B+1G2w+KDJFtN0J4XlIpLvzkHTTkKWqniCvO+x3oTeH/gNUPlDj69ZXNDWlgG0H9lzmqZp7@vger.kernel.org
X-Gm-Message-State: AOJu0YzrGc6DQspuB2gMIWD2lCfze1SGeODoZpp+ZTKAtR1Ofd4kkoPw
	7611uxsytzaadHzhImnq2LNjLrBVtg9PTQE9XCiwoH79OZF4NSrPAx2WfKHrD3BdoQM=
X-Gm-Gg: AfdE7clmYBeuq0HRM4/ed8DwSIjtRyMT8CEb91Cbko7ytH4LacZ+g7imFSfQTuFYKV0
	HtJ7jcu/OjugNqEYK/2/JRcs/a3mxCKtLW0D3ZTTumOTQMq1Fe1Hric/5wguq+tIrLY+/janZW3
	UUwN0/q+PR9TaIgmoqCNfCtUgHelKawU+rpUFWYt8bEXuW6G966lV4buP/TDxRc9SdQjrGWV5iu
	OuuR5gxpcTQIiNyEDT9mzwCeYKH8oanPAHBfaa3GZ7W/zCn6RVsp0M2Pbfi4iEOXGn0ymrtX9RH
	ZpYBYIdh2eDxPVubbteHVJWdNQPxLMjTh03K1lwTEvKDXZeRUDl0zlgJjYBHzs+l0tWZ+cH2qlW
	15uAtdJuGmDS3rR0/Cjzf2r/cAbuca+JFLk/oDoGMJkj/pxtiQLk4z7r3b1HY5G/ihfy6oFiGHO
	Rc2dLqua4E7SpE7NBmG1venw==
X-Received: by 2002:a05:600c:6a8e:b0:490:bd66:e523 with SMTP id 5b1f17b1804b1-493c2b7f3bbmr24597555e9.20.1782917328917;
        Wed, 01 Jul 2026 07:48:48 -0700 (PDT)
Received: from localhost.localdomain.com ([240e:304:4bb9:5900:2473:1306:a293:a912])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca6d84c81esm13917605ad.16.2026.07.01.07.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:48:47 -0700 (PDT)
From: lan@suse.com
To: djwong@kernel.org,
	fstests@vger.kernel.org
Cc: An Long <lan@suse.com>
Subject: [PATCH v2] common/rc: fix mount options quoting in _mount
Date: Wed,  1 Jul 2026 22:48:06 +0800
Message-ID: <20260701144826.15992-1-lan@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: An Long <lan@suse.com>

In commit 078f320 ("treewide: convert all $MOUNT_PROG to _mount"),
direct calls to $MOUNT_PROG were converted to call the helper function
_mount.
However, the _mount helper was implemented using `$*` instead of `"$@"`.
This unquoted argument expansion triggers word splitting on any arguments
containing spaces (such as the overlay mount options containing spaces in
tests `overlay/083` and `overlay/086`), causing the mount to fail with
"mount: bad usage".
Fix this regression by using `"$@"` in the _mount helper, which correctly
preserves argument boundaries exactly as they were provided by the caller.

Signed-off-by: An Long <lan@suse.com>
---
V1 -> V2: Revert the error log to "$*"

v1: https://lore.kernel.org/fstests/20260629155812.GW6070@frogsfrogsfrogs/T/#t

 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 79189e7e..b9a07324 100644
--- a/common/rc
+++ b/common/rc
@@ -296,7 +296,7 @@ _has_dmesg_since_option()
 
 _mount()
 {
-	$MOUNT_PROG $*
+	$MOUNT_PROG "$@"
 	ret=$?
 	if [ "$ret" -ne 0 ]; then
 		echo "\"$MOUNT_PROG $*\" failed at $(date)" >> "$seqres.mountfail?"
-- 
2.51.0

