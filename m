Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8B1CAA4
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860552; cv=none; b=gH8sSjrkxV3GXzTgYwFKq7n56F5hhkWjE6+GJf0JygQefu1Qb7jhWmvkWci6xh84F/96zCQ0+jZoqyT/sots1bN5K6qIafuK/rKDOY6joAI/V+lK1/8Dv2CC8/P+MJvEx6pwrfvrnVSuTs7xSQQHeGFrUGLfTOve8WZyP8Q8cHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860552; c=relaxed/simple;
	bh=Hh42y1K5kUUZwrvHxUDCeiIEbpcwvE/bYup2XYtnCO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ba0FjUR5fIQs4f65FCkjdpssyQzdOVS4NY6OyO3vReP4cMUGIZ0iEjwIVr2fswkot1aozo9drHqpdJJtPz1AyObo/mt1oqFIncteN49v8layuCnqt37WY+yAnzjLkw+k2ReQkWYhW6W9zSWScnMb2zkzCWR5cvWsHeSywyDxiH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ZjTjXkfl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ZjTjXkfl"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22423adf751so3766355ad.2
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744860551; x=1745465351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4TW1Q/XvbQCkhxQNiAzdif3wyuW34/gs7KfEg12MYA=;
        b=ZjTjXkflO9e6dpukwyL2CQvyR1PFWjAEEU1/MPDnIneaQP/OBOmzRfLB0vtJdnyGtF
         g9o6onjU+71dm6Kc1z6YP4HO3zxmFaFQ6O6CEV+ltrEgHAgB52jWYPv279zHjcdLEbqI
         aFjoRXf/B+Yrt0BffiEf3efb/QVEk8hdaeHUDR3ZUM4KFV7fkAuozHcxUKQfhX5HdiQo
         +/aVwV/V6gKAuEkDTyRhTL2roYXAaB/hgN+AHYpjLS1QNI5Lmbo1ezaHhsuhdpSYxDHy
         ur3rU2DQRVIPI+5yombaUqbrTMQMF9BJVvJnY55VPkcPURNP8Fnpw7p8IB2nC40gkn7K
         KnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860551; x=1745465351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4TW1Q/XvbQCkhxQNiAzdif3wyuW34/gs7KfEg12MYA=;
        b=neWvt7OzfDn8WS/KTOyhhD5W9oBly22y2fG9bt7u5H9hDNc9WEFY/+0rgsWGazCbCd
         umTx0Gkw7Q44c7BYJIL6ck1+mxUJyFIGkaa1f2+I6nmEe8NkY/vXXdoB3WYUwy9GOut0
         69CO0V5P9078bXPen76msrBDJhqaaTLOzQByD5nV4qsIHrtVjZoFRVcb6CpcIDuvK9pq
         fssaXL8eWhZtXIJTObaOz8S3vJn1O54PPbEVIIeNYEEaHKdcg8I92XUBsjmLm/Z8bhTb
         KANKLKLcKGCKiykIUd3Af/V3eKLhpEyTMLerjAy4LuJwAa25zkATXhIReIWkOtz3Gfnt
         omdA==
X-Gm-Message-State: AOJu0YyO9r/yYmPQbMYs+qNEw6as7W49mhbLuq/t2/t7p6ipEl3qt4mk
	OBFaqVeWuw8Ae1lbJjpmjSH7YVlFqnpHYtv/wXTEHm0lomwVyr/ZXK2eQZv10edkaOpxNarcPuj
	A
X-Gm-Gg: ASbGnctG0iDBCdyjqHDvGmDTVXdvlSkhPZNsXMBGyvAjeef1c2yOYIFhA0dfRbUPVFd
	kJfe0KhCU9lQGjKpcNBQztosgeyJexwoMFg2A2l42/5WU81Jm+065sSckpB0w0VRTdRqImw4oNE
	gZzbxJMwP5sBL5H5uLuKBMAgyCkbCgv63aAfusTaZFXa1RI9TwiJZY32xj9veFA1OhfYMjj7Vt5
	e9Kgb9uZHFN+JxFgHLphaa3b7rQWUG1Ayyf8My0WYO7NS7PGK5XL05l/fRWKO5be3+WRh+KvQiI
	XmbknDi8jSPgNftcQB8luLE+Xg0pLc0tpX4v92grOLbeAVPSSqP8VxEm4WcMBRMfUrSKQ5M6iIS
	Pkyo8UIbrtvIl
X-Google-Smtp-Source: AGHT+IEkHAnILGIuvXXjbyM6rDxJM+xKiZrnxbMVe2KyJkKfSTNLg7cCjycKJR9KeMEeofcSwXhzHw==
X-Received: by 2002:a17:903:1a44:b0:224:1935:fb91 with SMTP id d9443c01a7336-22c358fd434mr60110045ad.27.1744860550684;
        Wed, 16 Apr 2025 20:29:10 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fcc04dsm22575505ad.200.2025.04.16.20.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:29:10 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffd-00000009Y9O-3vA8;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mE1-0dLK;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 02/28] _scratch_mkfs_sized: obey USE_EXTERNAL for XFS filesystems
Date: Thu, 17 Apr 2025 13:00:43 +1000
Message-ID: <20250417031208.1852171-3-david@fromorbit.com>
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

From: Dave Chinner <dchinner@redhat.como>

_scratch_mkfs_sized is failing on my check-parallel setup because it
has an RTDEV defined but USE_EXTERNAL is not set.  Hence
_scratch_mkfs_sized sees the RTDEV, adds a size parameter for it,
then passes that to _try_scratch_mkfs_xfs() which looks at
USE_EXTERNAL and so doesn't add a RTDEV to the filesystem.

The result is that _scratch_mkfs_sized -always- fails with this sort
of error:

.....
** mkfs failed with extra mkfs options added to "-m rmapbt=1 -i exchange=1 " by test 300 **
** attempting to mkfs using only test 300 options: -d size=536870912 -r size=536870912 -b size=4096 **
size specified for non-existent rt subvolume
Usage: mkfs.xfs
.....

Make the XFS code in _scratch_mkfs_sized look at USE_EXTERNAL like
the ext4 code does.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 9bed6dad9..12a05cb96 100644
--- a/common/rc
+++ b/common/rc
@@ -1264,7 +1264,7 @@ _try_scratch_mkfs_sized()
 	xfs)
 		local rt_ops
 
-		if [ -b "$SCRATCH_RTDEV" ]; then
+		if [ "$USE_EXTERNAL" = yes -a -b "$SCRATCH_RTDEV" ]; then
 			local rtdevsize=`blockdev --getsize64 $SCRATCH_RTDEV`
 			if [ "$fssize" -gt "$rtdevsize" ]; then
 				_notrun "Scratch rt device too small"
-- 
2.45.2

