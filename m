Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EBB2DF96
	for <fstests@vger.kernel.org>; Fri, 15 Dec 2023 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEjvFwsZ"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5cd81e76164so4816717b3.1
        for <fstests@vger.kernel.org>; Fri, 15 Dec 2023 03:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702641313; x=1703246113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJcMakTxGdPd6L09yRsD1e+0r7r+bAZLY3Ow8M9n4Cc=;
        b=aEjvFwsZbydIoWz8y0FLCfVNgAH6T/KFpfagmJoVlVDb8xE1XcBXcL8iLkv1Z4+XOB
         x7Etc5uZ3MFzuSUuyafbFx/imNMBiT+DUnYlRnf/LFYTUAdLlfV6IGSMgTut4uGiE/IK
         YxLh0WgfUCJMEdICloFiA/hl0TjYIMZ904XxdK4dV/Zss+LmN0t4kcygZgJvAUFB3lP4
         /14ZbdxY8Ir0cP+dn3JRsyTejhBgVZFwPLzS9KvzXhSgSyg/xk9RdR8NF3stCtiqn0bJ
         RY7mQDNXRuI31QZoVVpvwggaG4ojs/tSEwo+lHBmQMBFOZf7xs+amtTgyJST0yPBlk3o
         cpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702641313; x=1703246113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJcMakTxGdPd6L09yRsD1e+0r7r+bAZLY3Ow8M9n4Cc=;
        b=hoOWq9iBJzDIFwrIUfBIb9fKhGPIfV4NdHp4LS3eduWV4HK3em4vS+VB6cPtRwphMa
         ulA5Ls/+6QsMbvHVz/fxqXu5UURCKtno8DuA5jAzILz6GT+miwa8WWNMWNk7Hg1zOMMj
         gBVK6tOnUKEcwUGQmgeMiy2X1MPkakYkopKxuareBFMalyW20vvbK3jfijkqXpSK3gv5
         e+v/V8YPW/3yMRxyq4l/1/t9kEvWjk6xu6KvE9MdEL0Aw7U5gsW7yogyND7qBsEVMA7u
         qdNiMqyPSZI+eUS2WP6HXS/EO1xPYwoIqwJe+W7u6Ygkg7zB9r0b4QlDKElagcI4ocfa
         Co8A==
X-Gm-Message-State: AOJu0YzBJBOhk8ydz6eQInSnjWULQcyM/UwHcJJ+kvUz4Bsm6SzEHYbV
	HwOap25ZZLOlOgb3BRfn/+DeqPI1vLs=
X-Google-Smtp-Source: AGHT+IEBVwQwjIv1wDzbii3Q68Lf1afIuEtmiXfKwhoIsmzy2N7A+YOATdduNTiqVSx66DDdbv6vyQ==
X-Received: by 2002:a0d:d812:0:b0:5e3:347b:e864 with SMTP id a18-20020a0dd812000000b005e3347be864mr2983280ywe.26.1702641313428;
        Fri, 15 Dec 2023 03:55:13 -0800 (PST)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
        by smtp.gmail.com with ESMTPSA id l3-20020a056214028300b0067f14aeaf46sm706789qvv.25.2023.12.15.03.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:55:13 -0800 (PST)
From: Murphy Zhou <jencce.kernel@gmail.com>
To: fstests@vger.kernel.org
Cc: zlang@redhat.com
Subject: [PATCH v2] generic/new: drop caches while freeze
Date: Fri, 15 Dec 2023 19:55:05 +0800
Message-Id: <20231215115505.1826465-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CADJHv_t4fzLjNBfabTSVgSW8QAjq7V=s_wW7cOJ8UPo+t9vdNw@mail.gmail.com>
References: <CADJHv_t4fzLjNBfabTSVgSW8QAjq7V=s_wW7cOJ8UPo+t9vdNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
v2:
  re-number to 738
  mkfs and mount scratch in the begining
  create more files and comment why
  unfreeze in cleanup

 tests/generic/738     | 54 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/738.out |  2 ++
 2 files changed, 56 insertions(+)
 create mode 100755 tests/generic/738
 create mode 100644 tests/generic/738.out

diff --git a/tests/generic/738 b/tests/generic/738
new file mode 100755
index 00000000..9f1f9d6b
--- /dev/null
+++ b/tests/generic/738
@@ -0,0 +1,54 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test 738
+#
+# Test possible deadlock of umount and reclaim memory
+# when there are EOF blocks in files.
+#
+. ./common/preamble
+_begin_fstest freeze auto quick
+
+_cleanup()
+{
+	xfs_freeze -u $SCRATCH_MNT
+	wait
+	cd /
+	rm -r -f $tmp.*
+}
+
+_supported_fs generic
+_require_scratch
+_require_freeze
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+create_eof_block_file()
+{
+	# Create several EOF blocks in the new file
+	for j in $(seq 1 5); do
+		cat $SCRATCH_MNT/testfile >> $1
+	done
+}
+
+$XFS_IO_PROG -fc "pwrite 0 64k" $SCRATCH_MNT/testfile >> $seqres.full
+
+# Create enough files to make sure there is enough cache
+for i in $(seq 0 1024); do
+	create_eof_block_file $SCRATCH_MNT/$i
+done
+
+sync
+
+xfs_freeze -f $SCRATCH_MNT
+
+# This will hang if bug reproduces
+echo 3 > /proc/sys/vm/drop_caches &
+
+# Wait a while before exiting and unfreezing.
+sleep 3
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/738.out b/tests/generic/738.out
new file mode 100644
index 00000000..5719515a
--- /dev/null
+++ b/tests/generic/738.out
@@ -0,0 +1,2 @@
+QA output created by 738
+Silence is golden
-- 
2.31.1

