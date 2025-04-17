Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE31CAA4
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860570; cv=none; b=tmdJ9GIzQYR/O7BNnuAFMm6Em2cpS2HE/x9rU72gOteBHhtQ0aDKyTidKDWnGmEzQtRcOEwKR0B+96dI1ThQcgnGai9xjQuQOsubHRxET688RZNUY+jrJK9poVeztz2MfnL4SJwFSzziJBjedZlEMzaZOIlmFDNzg9DTtSuzsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860570; c=relaxed/simple;
	bh=QCpL8UQeYTklvq3AytCJaIwv/3lRJyULdt0FwnHFvKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atRtd1IpRd7s08dfQANQBGCghAAKY6Hbj2Y+VE1Cbu/Ld926dv0XEgdLJ9TOofg/TsL3JLHwqd+JejTDtlKXa6izBFSu6AvsW0VLEluARCUg0gY0p+cmQLbvgAx2NrRkCX5TG3fhZhDef2fqnhiRd5pPrqLoax7echZCkHQRvME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=JkFif0M9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="JkFif0M9"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22622ddcc35so4920575ad.2
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744860569; x=1745465369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxUzOCAFF58v3SiRrdJk5JdEY5gOAbxI2rLBmq0esrk=;
        b=JkFif0M9tlAcBge+Bah9J5k1TzVt1hOiR+H9nxjUCnvXPFAPv3NvRU91PpDglrEJnh
         waRFjHk1uOU3oLGRH0tIKl4T/gbDu31ADqRvQ4CvNY8pFXyK7G1jxPn1q6ahkw+Blp85
         cx7N9No0jBepw7c39M5EzD6N6Av0wodo/ANLX9pXfA/RiSLOWJuOK0KpgLAGMQrmu2f9
         4K8KcQa6l/3mIsWns9m+SKGYsp+7AIeXpG0fwqvwRvmdWGVTSgcgKy+VpJM4iZx9yclq
         uygtZuRNmk0rX2et+EXDpYYraSDIt7IYwvJGTXA9qsgKpJAuzTKghDiy7IvqSakMxTEI
         Q6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860569; x=1745465369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxUzOCAFF58v3SiRrdJk5JdEY5gOAbxI2rLBmq0esrk=;
        b=Vz4jPB9i0CG99MxIeC/ICKQBUZ8dYeZCUpbCFdPXYOknYbWQf9gbLt2ijFoB1PIQ6o
         n3BXTNk4JlIYnGxvwR8z+S0EA1fyMEJC4taxDiRUwK9l88ueTkkzKHC9DHRa8ocQeLDc
         WWs5B6CXdFgeut1j8sFhPXmc9LeTw9/alGH4E1bd0swEYXZen1rtSg5Hd36WBdUFni+x
         dsFxbqmaz0b2m9l1ZlosEs4VEuVfnFqRZs8ca2QWh8+Dmrkb75ErsMcgNa/4gXRnmBK2
         RlalEZOUtmVPrG9K9+l30ybuQLF9lyk88x2ybA30qncbsXyYUegIvQFjl8/jueGYbXRQ
         fvGw==
X-Gm-Message-State: AOJu0YxEfJrSB6dOpgp2Xu2iW8UXylMmq6vosiYzVosXMbPl9/2jX7ws
	ifdYiUs6R251kDw3/WxYJ9RZQJG42Fb4WtHyY18PsfTCe1LoxeWbA6uDnAEB0/jH3thZUL9R6LY
	K
X-Gm-Gg: ASbGncsZabd28sseSLwh0AFA9bXEYNLcNfNbaM+VEZkrhOrj+CS2NIbs2p7eV/lN8ez
	KtaARtC4vQ4ewttrPrQDkiCYx26XUCzr3lRjflzmTrCU3PPAJ1WiCadtPVonwRIa4jvgmp8eKqh
	aK3AHSC6G3TwNpjRH0pY5xoXM4E3ZRZ1ZtQgZgHRPuMRB12TuZjOKuulSBUgkwOAZZiHIFKU9pU
	jeMbcvGZ7FezmHpPQ9LuWyUNg5Mno1svidOi5f9/E6Lq9BoYK2IaffVqjEgrf5RGAgqUkiy7Oxn
	ZyPOG0zaV2DQb3eZBfjJZNFLaTJfed60PFVOhhZfMcKYWJIyNP6el9rCigQYIX2MJpdbx28ZZho
	yKtZjMElMMtmG
X-Google-Smtp-Source: AGHT+IGMDu1QC/Pe7cJBqXlotE/ttcavZWarj0peUyz0WgPYaz2Adlzoc2sR+3aW2VFaI2I299/W/g==
X-Received: by 2002:a17:902:d581:b0:224:5a8:ba2c with SMTP id d9443c01a7336-22c35986257mr67645875ad.52.1744860568875;
        Wed, 16 Apr 2025 20:29:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fcad31sm22415895ad.186.2025.04.16.20.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:29:28 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YB7-3Rjd;
	Thu, 17 Apr 2025 13:12:11 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Fff-00000007mG6-05W6;
	Thu, 17 Apr 2025 13:12:11 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 28/28] xfs/259: no need to call sync
Date: Thu, 17 Apr 2025 13:01:09 +1000
Message-ID: <20250417031208.1852171-29-david@fromorbit.com>
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

xfs/259 runs sync every time through it's loop.
It takes a ridiculously long time to run under
check-parallel:

xfs/259        461s

When running check-parallel, sync can take a -long- time to
run as there can be dozens of filesystems that need to be synced,
not to mention sync getting hung up behind all the mount and
unmounts that are also being run.

sync is used at the end of the loop before destroying the loop
device, but the contents of the loop device is completely discarded
at the start of the next loop. i.e. the image file is unlinked and
recreated. Hence the sync call does nothing useful and only slows
down the test. Removing it runs the test much faster:

xfs/259        23s

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/259 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/xfs/259 b/tests/xfs/259
index c2d26381a..c40ba3a0e 100755
--- a/tests/xfs/259
+++ b/tests/xfs/259
@@ -52,7 +52,6 @@ for del in $sizes_to_check; do
 		$MKFS_XFS_PROG -l size=32m -b size=$bs $loop_dev |  _filter_mkfs \
 			>/dev/null 2> $tmp.mkfs || echo "mkfs failed!"
 		. $tmp.mkfs
-		sync
 		_destroy_loop_device $loop_dev
 		unset loop_dev
 	done
-- 
2.45.2

