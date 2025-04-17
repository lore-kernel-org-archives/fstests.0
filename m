Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E71CAA4
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860557; cv=none; b=cbuHu4kOGbLkVfTLTBoZ9STzqRCimNOm7fl8IrAMNFP0M25QVTmX2Uo6A4e7QOQSgFCQI9+45Mq57E1zRIWmyncm1zlHMjQDgRuoh9zQQpkS57zqEokWA6DluinIxE4nSuSErqlM7cOwUxKBJ5BJPlhWF/W/Ov+d4WIYxNofKTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860557; c=relaxed/simple;
	bh=T6vv+H4PRnqYnFNeZBAztoKH14uH5JMJ5lxexBasC5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7GdrYvi/UPWP5e9VW+reisrAI8q0N54ZS0gMU8uXcMRHTgNqAMuQTZkHiEKMz8sdIuXesoOBcyRjbRyo4tp/9l8UHeNxNtur3CHcundgw6ZJsVaTXnIiplzGBskEw4iq9i87VCREPBGy8ekaSKACP/YV5K3IF7WPH6Sm9uKlv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=koLR7f8s; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="koLR7f8s"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227b828de00so3504275ad.1
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744860554; x=1745465354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p27qDupzlIlpwREeaJPedTyKnwWoq9NVuiIxTJXOnwA=;
        b=koLR7f8slLEwb+1Y5dl/SOYCNF7Z6rmnUcUbok6iwb+3Z5aFBF9LelcPsn4kygUbCB
         h+jhSADtvAOSjsmRg3Qw2rAVohKZwKyyvl6P1a1cLSXgpuukMjCAtnnxKSt/cRbRRk59
         ifbTFz89b6Cw4/RJbQuEQvXeZ8dzHHRzeSoveaKE+LAwTD1gJLrM7QiQPmgxLL4F4uKB
         aXuryqSFJId0VHCYdQtbxfs3znWcfk25VP7wYjIRlvnibCSdnh/J1OjA5R48anvA8SLX
         XiTuOmKK3m0Wr6gd4Rl224sd29b+Jm2gIPDFf4tEDiwLt+doPbtL9tXTPSlbz8FyEtU4
         ZhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860554; x=1745465354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p27qDupzlIlpwREeaJPedTyKnwWoq9NVuiIxTJXOnwA=;
        b=gM7up4fL5fliFOtdO4Ef9Lg+UMx5DKyXBWINYMCYJVAwOfwhiIcSDmPOk3gbj01Yy2
         2RezcLRGelYw90eYyMcw3kjuBXtitk//d7d9+pD0sXjSUHtMUY35LQ2+BJbsoP94enzn
         u3Bj30DuDlO5HmIsN5KLn9iMaxvBZ8W3GfhEgZesQGlXW9/PkoAmZPsj+vCU7b2tjtt1
         yGWQLo1gwjP1O4b/qsjq71KM08gjD6tXgDKSMgrvT06MZs5ZVi0RgL2qd6J8UuhYZbL4
         +I/fe+uWtC3L+ViDjwbUSTJdx9ngrI1hYRgeqGmhpI1zCDjXiVyJ9GaZgl59FLZ3ouAO
         zDSg==
X-Gm-Message-State: AOJu0YznR09yfKXsFD2K9HGlyTUSCVhtMzy8fViOu7d9qCuB7iZRY4oe
	iez46BD6gWCM4Olvh5PaNknxhJ2yUemUiUE0+gvXs4Ag7Z/W3bYyioq3rukyXyQ/Cx/uTcHhI7D
	A
X-Gm-Gg: ASbGncs4wGKnxpIcx7fWlznZWkXM/x2Y5MWrdv8ABP+b2CZbTJV1Gff+NqdPhZ0NU6J
	TBJWEts34J+3T8R0wYaOPXM02ct3RrxkhqSwsxNH3gSQ+AzYOSOAWDHAYUMt2T6JP1w1GynCDFx
	ZKu4YHFx3KeXIsGz6aoHCbreDaNloa5syj0YP1cgfTKIohG6KutLdDGlNudol6RtkqGQvbZ44Qy
	rDkdfnmTysSiVFlCw794tXY9J1duZJF7dGymU71STpRtNWe98RUU72KdwuPzuhOcWDIPOcnzBm6
	ThEKVmutguU5QwvHvXw7uLC5b5W1ooORq5XHkKzjJE+1jyBzGRJWUjLkmfznKlcmbfEmQc3RIi9
	qHA==
X-Google-Smtp-Source: AGHT+IFMy8ToyIbdNBZlmdUcSGELHXIgtMoJIt2u3uzRS+WIz5MDlR0b4MLk2Oo4gKDrbHZI9SgE1w==
X-Received: by 2002:a17:902:f605:b0:210:fce4:11ec with SMTP id d9443c01a7336-22c358c2c24mr70572735ad.1.1744860554233;
        Wed, 16 Apr 2025 20:29:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fa5e74sm22516975ad.151.2025.04.16.20.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:29:13 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YAw-33cv;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mFs-3scx;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 25/28] bulkstat_unlink_test_modified.c: remove unused test code
Date: Thu, 17 Apr 2025 13:01:06 +1000
Message-ID: <20250417031208.1852171-26-david@fromorbit.com>
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

The built binary is not used by any test. Remove the dead code.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 .gitignore                          |   1 -
 src/Makefile                        |   2 +-
 src/bulkstat_unlink_test_modified.c | 193 ----------------------------
 3 files changed, 1 insertion(+), 195 deletions(-)
 delete mode 100644 src/bulkstat_unlink_test_modified.c

diff --git a/.gitignore b/.gitignore
index 4fd817243..feb011c46 100644
--- a/.gitignore
+++ b/.gitignore
@@ -65,7 +65,6 @@ tags
 /src/btrfs_encoded_write
 /src/bulkstat_null_ocount
 /src/bulkstat_unlink_test
-/src/bulkstat_unlink_test_modified
 /src/checkpoint_journal
 /src/chprojid_fail
 /src/cloner
diff --git a/src/Makefile b/src/Makefile
index 6ac72b366..6a31ceb01 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -26,7 +26,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
 	locktest unwritten_mmap bulkstat_unlink_test deduperace \
-	bulkstat_unlink_test_modified t_dir_offset t_futimens t_immutable \
+	t_dir_offset t_futimens t_immutable \
 	stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test \
 	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
 	renameat2 t_getcwd e4compact test-nextquota punch-alternating \
diff --git a/src/bulkstat_unlink_test_modified.c b/src/bulkstat_unlink_test_modified.c
deleted file mode 100644
index a106749dc..000000000
--- a/src/bulkstat_unlink_test_modified.c
+++ /dev/null
@@ -1,193 +0,0 @@
-/*
- * $Id: bulkstat_unlink_test_modified.c,v 1.1 2007/10/03 16:23:57 mohamedb.longdrop.melbourne.sgi.com Exp $
- * Test bulkstat doesn't returned unlinked inodes.
- * Mark Goodwin <markgw@sgi.com> Fri Jul 20 09:13:57 EST 2007
- *
- * This is a modified version of bulkstat_unlink_test.c to reproduce a specific
- * problem see pv 969192
- */
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <xfs/xfs.h>
-#include <unistd.h>
-#include <string.h>
-
-int
-main(int argc, char *argv[])
-{
-    int e;
-    int fd = 0;
-    int i;
-    int j;
-    int k;
-    int nfiles;
-    int stride;
-    struct stat sbuf;
-    ino_t *inodelist;
-    __u32 *genlist;
-    struct xfs_fsop_bulkreq a;
-    struct xfs_bstat *ret;
-    int iterations;
-    char fname[MAXPATHLEN];
-    char *dirname;
-
-    if (argc != 5) {
-    	fprintf(stderr, "Usage: %s iterations nfiles stride dir\n", argv[0]);
-    	fprintf(stderr, "Create dir with nfiles, unlink each stride'th file, sync, bulkstat\n");
-	exit(1);
-    }
-
-    iterations = atoi(argv[1]);
-    nfiles = atoi(argv[2]);
-    stride = atoi(argv[3]);
-    dirname = argv[4];
-    if (!nfiles || !iterations) {
-	fprintf(stderr, "Iterations and nfiles showld be non zero.\n");
-    	exit(1);
-    }
-
-    inodelist = (ino_t *)malloc(nfiles * sizeof(ino_t));
-    genlist = (__u32 *)malloc(nfiles * sizeof(__u32));
-    ret = (struct xfs_bstat *)malloc(nfiles * sizeof(struct xfs_bstat));
-
-    for (k=0; k < iterations; k++) {
-	xfs_ino_t last_inode = 0;
-	int count = 0;
-	int testFiles = 0;
-
-	printf("Iteration %d ... \n", k);
-
-	memset(inodelist, 0, nfiles * sizeof(ino_t));
-	memset(genlist, 0, nfiles * sizeof(__u32));
-	memset(ret, 0, nfiles * sizeof(struct xfs_bstat));
-	memset(&a, 0, sizeof(struct xfs_fsop_bulkreq));
-	a.lastip = (__u64 *)&last_inode;
-	a.icount = nfiles;
-	a.ubuffer = ret;
-	a.ocount = &count;
-
-	if (mkdir(dirname, 0755) < 0) {
-	    perror(dirname);
-	    exit(1);
-	}
-
-	/* create nfiles and store their inode numbers in inodelist */
-	for (i=0; i < nfiles; i++) {
-	    sprintf(fname, "%s/file%06d", dirname, i);
-	    if ((fd = open(fname, O_RDWR | O_CREAT | O_TRUNC, 0644)) < 0) {
-		perror(fname);
-		exit(1);
-	    }
-	    write(fd, fname, sizeof(fname));
-	    if (fstat(fd, &sbuf) < 0) {
-		perror(fname);
-		exit(1);
-	    }
-	    inodelist[i] = sbuf.st_ino;
-	    close(fd);
-	}
-	
-	sync();
-	
-	/* collect bs_gen for the nfiles files */
-	if ((fd = open(dirname, O_RDONLY)) < 0) {
-	    perror(dirname);
-	    exit(1);
-	}
-
-	testFiles = 0;
-	for (;;) {
-	    if ((e = xfsctl(dirname, fd, XFS_IOC_FSBULKSTAT, &a)) < 0) {
-		perror("XFS_IOC_FSBULKSTAT1:");
-		exit(1);
-	    }
-
-	    if (count == 0)
-		break;
-
-	    for (i=0; i < count; i++) {
-		for (j=0; j < nfiles; j += stride) {
-		    if (ret[i].bs_ino == inodelist[j]) {
-			genlist[j] = ret[i].bs_gen;
-			testFiles++;
-		    }
-		}
-	    }
-	}
-	close(fd);
-	
-	printf("testFiles %d ... \n", testFiles);
-
-	/* remove some of the first set of files */
-	for (i=0; i < nfiles; i += stride) {
-	    sprintf(fname, "%s/file%06d", dirname, i);
-	    if (unlink(fname) < 0) {
-	    	perror(fname);
-		exit(1);
-	    }
-	}
-
-	/* create a new set of files (replacing the unlinked ones) */
-	for (i=0; i < nfiles; i += stride) {
-	    sprintf(fname, "%s/file%06d", dirname, i);
-	    if ((fd = open(fname, O_RDWR | O_CREAT | O_TRUNC, 0644)) < 0) {
-		perror(fname);
-		exit(1);
-	    }
-	    write(fd, fname, sizeof(fname));
-	    close(fd);
-	}
-
-	sync();
-	last_inode = 0; count = 0;
-
-	if ((fd = open(dirname, O_RDONLY)) < 0) {
-	    perror(dirname);
-	    exit(1);
-	}
-
-	for (;;) {
-	    if ((e = xfsctl(dirname, fd, XFS_IOC_FSBULKSTAT, &a)) < 0) {
-		perror("XFS_IOC_FSBULKSTAT:");
-		exit(1);
-	    }
-
-	    if (count == 0)
-		    break;
-
-	    for (i=0; i < count; i++) {
-		for (j=0; j < nfiles; j += stride) {
-		    if ((ret[i].bs_ino == inodelist[j]) &&
-			(ret[i].bs_gen == genlist[j])) {
-			/* oops, the same inode with old gen number */
-			printf("Unlinked inode %llu with generation %d "
-			       "returned by bulkstat\n",
-				(unsigned long long)inodelist[j],
-				 genlist[j]);
-			exit(1);
-		    }
-		    if (ret[i].bs_ino == inodelist[j] &&
-			ret[i].bs_gen != genlist[j] + 1) {
-			/* oops, the new gen number is not 1 bigger than the old */
-			printf("Inode with old generation %d, new generation %d\n",
-			genlist[j], ret[i].bs_gen);
-			exit(1);
-		    }
-		}
-	    }
-	}
-
-	close(fd);
-
-	sprintf(fname, "rm -rf %s\n", dirname);
-	system(fname);
-
-	sync();
-	sleep(2);
-	printf("passed\n");
-    }
-
-    exit(0);
-}
-- 
2.45.2

