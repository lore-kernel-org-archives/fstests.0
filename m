Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3171A4F21
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860588; cv=none; b=kFBBEEqhvAsGpYA9FrIhbAUfb1zABNmA/iz18oXqTUU7cmtleR2o6JFuBxm+LZTsT2MN8n6PAtZiE57x4KfdY4uNxLdZcFW+g1cAcfMYLMFehNytNRRIIJuhjpvNmwZBKO2Whk2fpLzGRkAVMtUv/sIhNLEGkAkcUAhDGtjUe9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860588; c=relaxed/simple;
	bh=gh8By8eiWjYFsKpo43v3UL4RKanOrcbcYhSrQHU2aBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5N9wPq0qoaJPDO+5k1dAQjUWY9MQhzVilD2xBjQzLeLazaclaHotjFgit8AzS3OszpIzxp4Uw/XF1IdckmBUBexg1Boc/7YSwwvCGftoMqanRdesJhoLdXWjcfF+nUOjAdCKNdwNx62cQEQVsoSrWRtXPGfLZlv5u48cCM6Xhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=a+OI7xSa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="a+OI7xSa"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736a7e126c7so218024b3a.3
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744860586; x=1745465386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Joj5OQQtpvqF/0e1Vx6K4gZFDy681Xi6oIXy2ZlnZXc=;
        b=a+OI7xSaaWhIrGPZyKbMxF7W8KkyVUdb8GsGF0FmnmiX+hD/OCtXOgeKwduDI3POYy
         KE4UMOms7h5rJMGGhSh1eX0DqU+lwP/mQ0HwqKk1zO0M+tTEZEN5agNDsFPT/TEYaLdz
         qVkfnu8z8EyRWjHRS6ihZ1vrFTjioQCkriGDQK0x0SUHS0GRa51K4I4dWay1ufmtkAib
         MIySej2XFc6qMdbAXK2qLay06jZg7KQJUi6UJMddnnbqHvU8ZXxdOJc/RehMb0DMsgXK
         T3HU8dPFCuUR1ujKrb/jxhQc0BAv/VRbHKDd/hhDcOX4DQ8CRdocZN30AVhZ/yALs32j
         vklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860586; x=1745465386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Joj5OQQtpvqF/0e1Vx6K4gZFDy681Xi6oIXy2ZlnZXc=;
        b=F8ueK2kyOSAaNHh2nFgaPRlAVqnbJL1SYiWYn3yDuNwrfFqUDyxzxHkfuCcJOYt413
         EWgU5e+6vnd8rs4M3AMYBW75moALTDH9C2hKziF75+bIfPXVS3CSc+ZjxH7k/3AuUQm6
         aTf6pBbjcwrlPP6bm6JcpWPE55aEgMbv2pI7VLy3zLxGedHxHFO9VKrmh3RyHhYv1O4k
         d/Qm65vraHwfrDlMfqZsO/8CL+UKIivcxHzMcXwEAhAO+ZrlOjM5Qnl2oxzxNU3Lk6Jq
         +ixprfO7wz+Pj/sGkpBnhdFphwfg9EJJDLpEpwgBD9+nu1236wuoGNmVyW+xQ0grwKB4
         AByw==
X-Gm-Message-State: AOJu0YwugK3eOBCBPdbwDVnCyJITxCDkiKNrOVJS9e/Yz45zfHKdK0Ia
	aSDTSGVXZvOqAl3SOI1kYxZnCuTYC1H5odsZ335Z0HMp/8dQorMqu4Eq5NVWspUhBVwPDWDpz3s
	8
X-Gm-Gg: ASbGncvWiVVF4ffH48vrISE0eccnF78Z6WmGVntNHeX5VWDfZsy7VPv9LWyQLSuv3rE
	MUI/nqqG7h7lYzZDSNmu/93xF7ObBFBf5d4hIABa/Jz060tZ3ElzJZNRnhOtb31ec8cniohSPNj
	pvvJ8yAb55O2mtkXAQuFsxTQTkz07mh3AK/gXhVX50qdAnJ642SFqcDD5IcrvcKPq0197vyCfFp
	IocJC1HfxPah0+xKiHSb1jBK8L5L8fq/JFTjv1biwLXQmnaaetPxA4/iaIgL6XoSIi9gfvCqO3v
	iLtJyrvnMNkYUKuG+ZT2qon8bZjo2k/EnglWCFXqlHslBdgQj4fI06P97ioCyOazBWVjN9v2r21
	G9ZQPmgrLZzED
X-Google-Smtp-Source: AGHT+IHuznUHrG089A7UdSde/zv+0wP5gqe6hyxLalF+PvrXUWA4LlquP3dAKZZfeWX4LFXifkGJdg==
X-Received: by 2002:a05:6a00:8c0f:b0:736:34a2:8a20 with SMTP id d2e1a72fcca58-73c267eacc2mr5939983b3a.21.1744860586328;
        Wed, 16 Apr 2025 20:29:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21949e5sm11248486b3a.4.2025.04.16.20.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:29:45 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YAs-2q81;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mFm-3iFq;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 24/28] open-by-handle.c: use syncfs() rather than sync()
Date: Thu, 17 Apr 2025 13:01:05 +1000
Message-ID: <20250417031208.1852171-25-david@fromorbit.com>
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

xfs/183 runs bulkstat_unlink_test to create 100 inodes, unlink on
and bulkstat them. It takes a ridiculously long time to run under
check-parallel because it runs sync() multiple times per iteration:

Ten slowest tests - runtime in seconds:
.....
xfs/183 328

When running check-parallel, sync() can take a -long- time to
run as there can be dozens of filesystems that need to be synced,
not to mention sync getting hung up behind all the mount and
unmounts that are also being run.

Convert the sync() calls to syncfs() so that they only try to sync
the filesystem under test and not the entire system. This avoids
interactions and delays with other tests and mount/unmount
operations, hence allowing both the test and the overall
check-parallel operation to run faster:

xfs/183        4s

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 src/bulkstat_unlink_test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/bulkstat_unlink_test.c b/src/bulkstat_unlink_test.c
index d78cc2ac2..62e5bb978 100644
--- a/src/bulkstat_unlink_test.c
+++ b/src/bulkstat_unlink_test.c
@@ -88,7 +88,7 @@ main(int argc, char *argv[])
 		}
 
 		if (chknb) { /* Get the original number of inodes (lazy) */
-			sync();
+			syncfs(fd[nfiles]);
 			if (xfsctl(dirname, fd[nfiles], XFS_IOC_FSBULKSTAT, &a) != 0) {
 				printf("Warning (%s:%d), xfsctl(XFS_IOC_FSBULKSTAT) FAILED.\n", __FILE__, __LINE__);
 			}
@@ -118,7 +118,7 @@ main(int argc, char *argv[])
 			 *The files are still opened (but unlink()ed) ,
 			 * we should have more inodes than before
 			 */
-			sync();
+			syncfs(fd[nfiles]);
 			last_inode = 0;
 			if (xfsctl(dirname, fd[nfiles], XFS_IOC_FSBULKSTAT, &a) != 0) {
 				printf("Warning (%s:%d), xfsctl(XFS_IOC_FSBULKSTAT) FAILED.\n", __FILE__, __LINE__);
@@ -139,7 +139,7 @@ main(int argc, char *argv[])
 			 * The files are now closed, we should be back to our,
 			 * previous inode count
 			 */
-			sync();
+			syncfs(fd[nfiles]);
 			last_inode = 0;
 			if (xfsctl(dirname, fd[nfiles], XFS_IOC_FSBULKSTAT, &a) != 0) {
 				printf("Warning (%s:%d), xfsctl(XFS_IOC_FSBULKSTAT) FAILED.\n", __FILE__, __LINE__);
@@ -150,7 +150,7 @@ main(int argc, char *argv[])
 			}
 		}
 
-		sync();
+		syncfs(fd[nfiles]);
 		last_inode = 0;
 		for (;;) {
 			if ((e = xfsctl(dirname, fd[nfiles], XFS_IOC_FSBULKSTAT, &a)) < 0) {
@@ -173,11 +173,11 @@ main(int argc, char *argv[])
 			}
 		}
 
-		close(fd[nfiles]);
 		sprintf(fname, "rm -rf %s\n", dirname);
 		system(fname);
 
-		sync();
+		syncfs(fd[nfiles]);
+		close(fd[nfiles]);
 		sleep(2);
 		printf("passed\n");
 	}
-- 
2.45.2

