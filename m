Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA75374C4
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860585; cv=none; b=g3jcFJlcG/ETEtfY6D16HevGtYSs84UQE58SDIFjBuEZVo/exhOwsRI+QPm9QoR9/cQvrwabsHhxaycDfG/fy+y/0vzQmANIhDNgp8fo8QwCaZE+sHROP5oG/6Xumx+lx1WxPJkjqjoPhQWnk8+JGXKdM0KUCZ1UNCmF1bQ9ubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860585; c=relaxed/simple;
	bh=yResdUoix6Ck85QCf9rDVsR185nm1PcZJ1Py6Ol8iTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsgwEUyERNPnl6EOOTbX6Pw/m11dzrN6UHVqR6EDH9DsOeIyWOonTI7lxq0wg1Y6kFoM15pDx6q4nP25L/eVuuQjwJw8JyQutdkctGxzyQf6rVM5rU1CjQrumZD5cFZiX8wvLJOYN8f22I3WCH/QCfFK7GshM8WjfUg+Qbt8gkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=n+Fky4Sv; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="n+Fky4Sv"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b00e3c87713so239391a12.2
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744860583; x=1745465383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhB9Mt7twDYlS04UPuuTvNJc/3LaLwBPCmiOE/N7kp0=;
        b=n+Fky4SvhNmFuY6vjHDWQfx6KWhxVgPJ/oj7VDNr04y00ugMTLZWdz29S2+Rk9d9Nk
         +OfQJHD21OsH47r8cNNu20MQuOnImWCfliLwADbKSV3SCdoi1xvT+Gl5W9JlJg0UQjMq
         zOARyDYJ+lA4Fr2zlM8Bdx5MLeCgJ0FC8prGDLs7HOzbtrFUsz5DGbBPh72i9Mwh5DDX
         UYSJnTtKh74AU8HufyDMY+nye/BVSl+nkX3v+59Rm7P1XNuXNT3TgAYxCCrUXt0xUP7H
         jHTkLSSk46Jd5pk+FNFi3jBiK8b10mfOIN8UNxyI/KPujQHFQKYdWgiDnwGuK4zCu3jH
         t7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860583; x=1745465383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhB9Mt7twDYlS04UPuuTvNJc/3LaLwBPCmiOE/N7kp0=;
        b=EhKI9FlJnnittf4LauILuKx5aQ8+0vjCXvyqJWaFv06mFYxwvgUnr5vHUDwya14sC2
         b9+hwEWd/YEDo4/yhlfpN71N2tIXMQ63zLTW2A/2rkdCGy1Gl6mNzd7YFW6dWICOAFrj
         kAP9MkUC+F0amei17nO6F+q6M6FFTFFfqihvW625IpXPJeXHe9o92B7l1B6d07h7PoEK
         Gm9YW0LzFPfUAn6tnnwQ5u65XlcCT68NYCCTk3xVV46pa9OV3Ap9ZwFSn1dgP/DjwKUN
         T3CGi7RYlumwG4T9IgIstcL2Xs9NTnVWG88dhsIk9bUJugSENoSK6gOxffQlMe6ycYZA
         Cy5A==
X-Gm-Message-State: AOJu0YyrbEsIlBIrWIqjxErEcPm+Mq2iEDW4S4MAdDH7YMEIoiP/npjU
	x+ugt1UClksa0tgASdYmiq9XxnPPexnuuCX+hCiam/AoTh6TXqUHn3a034vhRskOiWDg03U4HhQ
	v
X-Gm-Gg: ASbGncujZEZ0p34nfw6kGPwvxDEsp+PETZW3KUVSFi8CEL1W4PMwcpZjjdJh6j7I0LK
	BDu+N1O2TZ4cIi3VdCG2Oa63q4RpGoqcjCVPJOb5mEAroo37DFS1uLFpS6mR8ePduiLG05Jg10R
	DnnUOyMf6otAVhQekOjYNsSrlTjSluSdcZpd4vGB0T0YGhHMhAUpXamE3qvmrubv9hxdEpZuyLZ
	UPwyRWFgOiV3MMFeL608KueX2n/fFy5L+mQH4Q7sU8Iq6dXyd5OINubFE6XjeZiky5d8sDhhw2A
	JXfR5s63kB5N3qRE5HsYIKujrDNHGp8eGfOt364jbB1Ri/ia8K7boB7bvFT4eODRzpk6HXLlVq4
	2Cg==
X-Google-Smtp-Source: AGHT+IFxrsrfka4K06EZI/iBuvMklZDtPSeYUoIeNBtBeFj2R1QpLeHrBuo0UlRL2E18STCvuKQl5w==
X-Received: by 2002:a17:90b:17c5:b0:2f6:be57:49d2 with SMTP id 98e67ed59e1d1-3086402502dmr5448261a91.17.1744860582838;
        Wed, 16 Apr 2025 20:29:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611f3e51sm2475168a91.16.2025.04.16.20.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:29:42 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YAn-2gGL;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mFh-3Zgq;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 23/28] open-by-handle.c: use syncfs() rather than sync()
Date: Thu, 17 Apr 2025 13:01:04 +1000
Message-ID: <20250417031208.1852171-24-david@fromorbit.com>
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

generic/467 runs open_by_handle at least 15 times. Each
execution runs sync() at least once, sometimes three times.

When running check-parallel, sync() can take a -long- time to
run as there can be dozens of filesystems that need to be synced,
not to mention sync getting hung up behind all the mount and
unmounts that are also being run. This results in:

Ten slowest tests - runtime in seconds:
generic/467 442
.....

This test running for a really long time.

Convert the sync() calls to syncfs() so that they only try to sync
the filesystem under test and not the entire system. This avoids
interactions and delays with other tests and mount/unmount
operations, hence allowing both the test and the overall
check-parallel operation to run faster:

generic/467        6s

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 src/open_by_handle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/open_by_handle.c b/src/open_by_handle.c
index a99cce4b3..816bb5d12 100644
--- a/src/open_by_handle.c
+++ b/src/open_by_handle.c
@@ -430,7 +430,7 @@ int main(int argc, char **argv)
 	}
 
 	/* sync to get the new inodes to hit the disk */
-	sync();
+	syncfs(mount_fd);
 
 	/*
 	 * encode the file handles or read them from file (-i) and maybe store
@@ -563,10 +563,10 @@ int main(int argc, char **argv)
 	}
 
 	/* sync to get log forced for unlink transactions to hit the disk */
-	sync();
+	syncfs(mount_fd);
 
 	/* sync once more FTW */
-	sync();
+	syncfs(mount_fd);
 
 	/*
 	 * now drop the caches so that unlinked inodes are reclaimed and
-- 
2.45.2

