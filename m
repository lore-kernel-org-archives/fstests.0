Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737823D7C7
	for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035543; cv=none; b=PaK+twAbCkp/jW1nIf44Do+65dqvdAWllCyTNcYD8Rh6hi1IH/xLGSidW6teH4cBnOicwKfwJfHjvX02ht+qpYCI0aqblhuGZ4JzFhnlx4bQWmQsEwsw7sfmn+TCAEFz6dUuktodhhIPkpJySpVLdbP4gnVjvH8KgeMgcvvXWCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035543; c=relaxed/simple;
	bh=shJnxipfBLTZUEsYxtt5nBOTVhzHJUyJI9KpFQ+oIDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qAoMxRFfVeWL6EuGzEG2MMusT+NGFwl5HWU2vjw9Sxssca3N/y1TQdAFTDKMnXiUrUtlrm7Wis/+weQNHfVKxYGL080i+WkTEupjnXpet3xJDXp4jyzKGJDOnh0j1D44ChullczeNh/QvPDk1AznVbLAVoeMPvovjX9msnVMhZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sfwr9ItQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sfwr9ItQ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-266fa7a0552so21026565ad.3
        for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758035541; x=1758640341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qb2mdwudAX666QSHLbQ+Cm03d1XmYp7BsMy78ix8Ooc=;
        b=Sfwr9ItQWJsgTPLKT8Ejvv5HFPnaCP9N8R1DIRIY8caX6zMtckmp9q65AT45PDwajB
         Yv6xljPX5d68DkRw3q04ht9rU1IOilmIFCZeNjQtz+4NlR30LZySzrwpRGVJl7IhK3Nn
         5YkLcUPOVvEe/wFHcclYMEdnEauZqvHa5JjWXJjMvGmwpXE6yNHp6bRH4WOZLnhUAu+8
         vejtjEe+krLUT9JveP1e5gBb0u5OkIWSMjaYivAzkr6hJN4deNZ2gCwf4s0KzmaecF9d
         aIM7rPi69Om4pZfBB/NN+maanNV67oGk74blvNswmOPKdgbojqCdA1WiUprPJ4rKwCLk
         symg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035541; x=1758640341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qb2mdwudAX666QSHLbQ+Cm03d1XmYp7BsMy78ix8Ooc=;
        b=pDIhG3ZLGphex4Z09DVym1hHDFh3+EJtDlSmjmNOUjYXAp2IkndZbRvTzD8YS9Y8Tr
         QxNx2hGHHNCpxWkJXLJ2KGQ4iutN8ILcR8QBqLv1M4fRZTvDHb2ozUjfr75saa2qgOXA
         mGFYYTJ1dDDa8jFIKisDtKHQv4mfN4h/bRTbAmQhJY5BzBlDK19x0/gq2p/PFq44NE7N
         AF8wKd5Ajxc+fl5A84R7bEyYsanBjNhm6yuuAQiJWnlOZ8gbCNtJO+YeOKDXvwtAvMe1
         jVTeXjwWU45hLvuS3AHFE1ban0kfDxeGIdZ+3ljYm65ogRGVyS75tF7kO57yc4qIlBur
         u4Jw==
X-Gm-Message-State: AOJu0YwwF6MM8CatmHLKFaxIE2RIb6B2aPrCIIyPjYQ6N6h60PwAJi7c
	i/lJGpavRqGc8xVEGliLnLKaLuqCBUm1mvX5jcyGA4mIPQZrfOuD5Qah8yUWCg==
X-Gm-Gg: ASbGnctrKaUZVRvd3U5/UIzTW9Ncols64i9ZS2HM8uIjnBtqOll0J6law1LaBgP7Hw8
	k0xu471MDFvLaCX6yrt2QZrHxpeTE4w5lOAUzY42U8IqS/sSLuVtoffcDSXK2zSP9Ny74qQ1ngh
	OwSqo9QloPervnQH2v6wyivgUC9UjSO89wkAdpZCFlM3aZDBEtzb0g3VX2Exl9Vllvm/CvwQQYz
	hKJnT8up+20ZU0Za4gqcVUnTjkI2cpkB8IwPEY1VwNJ4/rFHpJoL4ITLpbli2+NPoWOWG+6wXe8
	ESAN6jGMGjIWov+dPc8sjWkjN+789Cs+TB3FD31+GKG50ubAhaEwovylaUE21ykgcRh+ANFzsrT
	DB4IUDl+SD2ZWtGWzchYG/fNDX9o=
X-Google-Smtp-Source: AGHT+IGnIGP44hd1Wh+KQ3hKMW3Fmgu6OuRiBWGWTz0WX2g+qxNS7d0Ut1BcXvt0QxLWSpFYm0Lkzw==
X-Received: by 2002:a17:903:384b:b0:24e:95bb:88b1 with SMTP id d9443c01a7336-25d267641f0mr180595395ad.34.1758035540895;
        Tue, 16 Sep 2025 08:12:20 -0700 (PDT)
Received: from citest-1.. ([49.207.211.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a750sm164780175ad.83.2025.09.16.08.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:12:20 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: nirjhar.roy.lists@gmail.com,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	bfoster@redhat.com,
	david@fromorbit.com,
	hsiangkao@linux.alibaba.com,
	zlang@kernel.org
Subject: [RFC 2/3] xfs: Add parallel back to back grow/shrink tests
Date: Tue, 16 Sep 2025 15:11:31 +0000
Message-Id: <9d54a448d58666196ae5c665b0cfddd5ca0bf3b8.1758035262.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1758035262.git.nirjhar.roy.lists@gmail.com>
References: <cover.1758035262.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test makes several parallel back to back
shrink/grow requests and makes sure that at
the end of all operations, the filesystem is in
a consistent state with no corruptions and crashes.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/xfs/611     | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/611.out |  2 ++
 2 files changed, 91 insertions(+)
 create mode 100755 tests/xfs/611
 create mode 100644 tests/xfs/611.out

diff --git a/tests/xfs/611 b/tests/xfs/611
new file mode 100755
index 00000000..605beddb
--- /dev/null
+++ b/tests/xfs/611
@@ -0,0 +1,89 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>.  All Rights Reserved.
+#
+# FS QA Test 611
+#
+# This test is similar to xfs/163. It creates NUM_PROCS number of processes.
+# Some will  pass, some will fail with
+#    a) operation in progress
+#    b) no space available
+#    c) size unchanged.
+# The primary difference of this test with xfs/163 is that all the back to back
+# xfs_growfs requests are made without recreating the filesystem in between 2
+# requests. This test ensures that even after several grow/shrink requests, the
+# filesystem is in a consistent state and there are no crashes or metadata
+# corruptions.
+
+. ./common/preamble
+_begin_fstest auto quick growfs shrinkfs
+
+. ./common/filter
+_require_scratch_xfs_shrink
+
+AGCOUNT=16
+FSSIZE=$((2 * 1024 * 1024 * 1024)) # 2G
+NUM_LOOP=500
+NUM_PROCS=$((4 * LOAD_FACTOR))
+_require_scratch_size $((FSSIZE / 1024)) #KB
+
+_stress_scratch()
+{
+	procs=4
+	nops=9999
+	# -w ensures that the only ops are ones which cause write I/O
+	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -w -p $procs \
+	    -n $nops`
+	_run_fsstress_bg $FSSTRESS_ARGS >> $seqres.full 2>&1
+}
+
+setup()
+{
+	_scratch_unmount >> $seqres.full 2>&1
+	# agcount in an xfs filesystem >= 2
+	_scratch_mkfs -dsize="$FSSIZE" -dagcount="$AGCOUNT" 2>&1 | \
+		tee -a $seqres.full | _filter_mkfs 2>$tmp.mkfs >/dev/null
+	. $tmp.mkfs
+	_scratch_mount >> $seqres.full
+}
+
+run_loop() {
+	for ((i=0; i<"$NUM_LOOP"; i++)); do
+		numag=$(( RANDOM % 17 ))
+		nblocksag=$(( numag * agsize ))
+		numblksoff=$(( RANDOM % agsize ))
+		nblkstot=$(( nblocksag + numblksoff ))
+		xfs_growfs -D "$nblkstot" $SCRATCH_MNT >> $seqres.full 2>&1
+	done
+}
+
+start_test()
+{
+	for ((j=0; j<"$NUM_PROCS"; j++)); do
+		run_loop "$j" &
+	done
+	if [[ "$1" -eq 1 ]]; then
+		_stress_scratch
+	fi
+}
+
+# We want to test with and without stress. The reason is that, if stress
+# fills up the filesystem such that all the AGs are non-empty, then all
+# the shrink commands will fail and we won't be able to test. So to cover all
+# the types of scenarios, we are testing with and without stress.
+for stress in 0 1
+do
+	setup
+	if [[ "$stress" -eq 1 ]]; then
+		echo "Testing with stress" >> $seqres.full 2>&1
+	else
+		echo "Testing without stress" >> $seqres.full 2>&1
+	fi
+	start_test "$stress"
+	wait
+	sleep 2
+	_check_scratch_fs
+done
+echo "Silence is golden"
+# success, all done
+_exit 0
diff --git a/tests/xfs/611.out b/tests/xfs/611.out
new file mode 100644
index 00000000..b8a44164
--- /dev/null
+++ b/tests/xfs/611.out
@@ -0,0 +1,2 @@
+QA output created by 611
+Silence is golden
-- 
2.34.1

