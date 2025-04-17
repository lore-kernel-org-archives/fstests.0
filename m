Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED5A1CAA4
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860549; cv=none; b=fc/ENvStZiplRJmmb4BXYHHBOlILddgf85uSGPejEM+C99OU9jhOSXCXP/YGwivpS+wGKI0xePuDJ7aplemf69iD2mgSmyaln+vtR5go7G8udpr1i97edxsf9kRzIbDRsGEO81Sk014apThSr9+7+2c2kmA3fhp5Q/jX9H07ikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860549; c=relaxed/simple;
	bh=M3NrHdhat+x/45tm2DDJHQKffA/0cZDHjADuVSXupnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgnFTXFZO67ZzmoG7ot5Z8UeAiZkDtBUPLUQPflBaQL7jVRu0EVpxOfter26ishnSRYaOePBOztvgfHGwV3100zuHs5KRuUZoCvxI7KeAX0FN0GX69djcMu5rRe+WBp3o5P4cYmNjipABtn+aya+MGNyseOLzDknFRJZ4xG8nzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=CQVYMPtn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="CQVYMPtn"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7376dd56f60so193258b3a.3
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744860547; x=1745465347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iCmLQP7aPAZkadCa4VQktEgtwEAhIC7e5S8tD3y/zY=;
        b=CQVYMPtnu0ZkezJy6e5p/H4Dr3Hb91xemCUwiDqhHv0CZt/VWLJhzVpKH0I/j8ulXv
         1ss66k0lFKTchrjkvoD4KlTRbdW/JhJt0vMHm8bTVjPEb035REcHt3t5odlWjxtQJHf7
         90DxBlnsNodRjDSdGyun8nVrpT4Ai4ruZIoC51UNo/9ywN/YelZaygZVn+sKkiu1j4CP
         cFSzq9jt4j1rU8WRzfwswKXvnoezlF/GvOVHkQ5sSFo0tVzOHtJi2AW6qa3rtjYx4BMQ
         +xXnprkIcBXQO06LvgT9bxJnaAjhNAgwoX/H4rDAH3Bf6PwvA6Al2kYaTKIRDW/366Q8
         HemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860547; x=1745465347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iCmLQP7aPAZkadCa4VQktEgtwEAhIC7e5S8tD3y/zY=;
        b=plWc2XCeZJXVHvPRPBz3epay82a+ozXmrcjSnjLQ2fba8DFbBajGkHYAgjI0P+s0BQ
         4BSxcszPJ0Ld1I5QsS4X19+LyKHH1wRv84yMn24mRXkxSv44zlTvQ9xU0pfoJ7PZg/oO
         71sAvo1zwTO9sW1ZzefkFNQN2GNtTiXuHPBhCsAvSlrA4G+qajviadyRe4ZhwfApjMBB
         e9obWpBiO2x47zps0Ib99HhKNeKlE5U8MwGZQccf7eO6ye0SZMN6GLZvPHlVSLxPtY81
         QiTIIMbmSnvrjifhcwysXv/UNxipLERWe2Wr4Vq2yOOmmv5+X8hnZNst2OlWxZ+oX8Fu
         ONfg==
X-Gm-Message-State: AOJu0Yw4w3dEvH/6X9oKL4goeGQykVP0AgCmVJeZf869/HLXKlED5v9B
	Wrg8w5VVBIqfdT8QI3mtlho11WEO+4bCaq/iJGpk/FJtnhznvTmS4Gy/h/m/oFsUalSiNvMHHbG
	+
X-Gm-Gg: ASbGncvnmyqGXkisBZdTYlesNxQjW3H/hE5WUE8F01oDdaq4WeZjPmCDxTPJ27p5kkP
	desW9LMr4cC/MV/x/hyWAv1XG5+aeLdZXYgbt37TDeV6ZYqz9Ra37l/W5V8ZkNvpn0vFA+4YIZ+
	Zydm6PaFPtlgVRAhmgpzqzYkOTvOtpVbxxUn30DB3RBKVekQ/XVVsMERhF81xP3OT5PaQVQR8qY
	V50rBBmagMaJmNBdWHWS2EZ2bTcy3l8aowGdSY2cr0icVX6rk1t7frr7ULhf4oSnvEwjcd6JDQi
	UJd4e7lV7sHn6tl6dACfKSmfd5qu03W9hXQ4gfkb2P1yI715mK4Ca4MT2YTGhjGwNMWz0oV4K80
	czg==
X-Google-Smtp-Source: AGHT+IEjw2s3B87WfxRjGPQjBxD545LKuNxiROvBM4ymbZBA2jpvEFfL2Cv3HGHL3qsthH9f7MG/2A==
X-Received: by 2002:a05:6a00:929e:b0:736:69aa:112c with SMTP id d2e1a72fcca58-73c266df3eamr5178022b3a.9.1744860547213;
        Wed, 16 Apr 2025 20:29:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd23351fbsm11645670b3a.171.2025.04.16.20.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:29:06 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YB0-3Avv;
	Thu, 17 Apr 2025 13:12:11 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mFx-40yc;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 26/28] stale-handle.c: use syncfs() rather than sync()
Date: Thu, 17 Apr 2025 13:01:07 +1000
Message-ID: <20250417031208.1852171-27-david@fromorbit.com>
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

xfs/238 runs stale_handle to create 1000 inodes, grab their file
handles, unlink them and then try to open them from the stored file
handles.  It takes a ridiculously long time to run under
check-parallel because it runs sync() multiple times:

xfs/238        144s

When running check-parallel, sync() can take a -long- time to
run as there can be dozens of filesystems that need to be synced,
not to mention sync getting hung up behind all the mount and
unmounts that are also being run.

Convert the sync() calls to syncfs() so that they only try to sync
the filesystem under test and not the entire system. This avoids
interactions and delays with other tests and mount/unmount
operations, hence allowing both the test and the overall
check-parallel operation to run faster:

xfs/238        5s

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 src/stale_handle.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/src/stale_handle.c b/src/stale_handle.c
index 2acd4968c..fd8b3ec61 100644
--- a/src/stale_handle.c
+++ b/src/stale_handle.c
@@ -21,7 +21,7 @@
 int main(int argc, char **argv)
 {
 	int	i;
-	int	fd;
+	int	fd, test_dir_fd;
 	int	ret;
 	int	failed = 0;
 	char	fname[MAXPATHLEN];
@@ -44,6 +44,12 @@ int main(int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
+	test_dir_fd = open(test_dir, O_RDONLY|O_DIRECTORY);
+	if (test_dir_fd < 0) {
+		perror(test_dir);
+		return EXIT_FAILURE;
+	}
+
 	ret = path_to_fshandle(test_dir, (void **)fshandle, &fshlen);
 	if (ret < 0) {
 		perror("path_to_fshandle");
@@ -66,7 +72,7 @@ int main(int argc, char **argv)
 	}
 
 	/* sync to get the new inodes to hit the disk */
-	sync();
+	syncfs(test_dir_fd);
 
 	/* create the handles */
 	for (i=0; i < NUMFILES; i++) {
@@ -89,10 +95,10 @@ int main(int argc, char **argv)
 	}
 
 	/* sync to get log forced for unlink transactions to hit the disk */
-	sync();
+	syncfs(test_dir_fd);
 
 	/* sync once more FTW */
-	sync();
+	syncfs(test_dir_fd);
 
 	/*
 	 * now drop the caches so that unlinked inodes are reclaimed and
@@ -120,6 +126,7 @@ int main(int argc, char **argv)
 		free_handle(handle[i], hlen[i]);
 		failed++;
 	}
+	close(test_dir_fd);
 	if (failed)
 		return EXIT_FAILURE;
 	return EXIT_SUCCESS;
-- 
2.45.2

