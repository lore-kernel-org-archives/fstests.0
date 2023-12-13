Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2vEZ1ua"
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3852B7
	for <fstests@vger.kernel.org>; Wed, 13 Dec 2023 01:21:02 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77f35b70944so404337885a.0
        for <fstests@vger.kernel.org>; Wed, 13 Dec 2023 01:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702459262; x=1703064062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWdKzoibSqsQvlvQsp6fHPkW+Qs5gKs7uO7ZxxJgrCQ=;
        b=l2vEZ1uag+zS/GD/gBP50Rk8/DvJTG8I7dwa/+Q4mWB7j4Qm9RnkBhKhMZrUBdnltn
         7EeNxZiA15S1xe4QPrOy9xfutqJb4ld7fjzEkMW0u5+ZcqHow4qDI3YZbPhJ0GZ4fl7/
         q2JHDCGlidhP+y0Nb/XhSH80Vu28mdnsua9Fyp50yBVMaVhOIJhu3zqioRkKzsvmwsUx
         TIwkYrutdZPu7Yiv1IuanKTGumYYJBEI3cvGc+SgZt28Z+cX7CIHu4q2peQIFL5pXIUj
         duj0UlnrdvA23sv75eWlFzxDC/X6yH5J/NQp5aovrs5jKNK81a1OIVC5U3Lb5PWtxchR
         IJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702459262; x=1703064062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWdKzoibSqsQvlvQsp6fHPkW+Qs5gKs7uO7ZxxJgrCQ=;
        b=llS0KWafgi60IhsrH2jBMNdqRzIXI5hQUvhcfZJ80m/VTJuY4pWkfCTBs4OlNXAbvy
         ngMCtp93Ocu8PU6EZ9RGnmkZg67SR/tuTuDT53aw81eAvgp8ad5FfUE4EANl6fwR8sK+
         II7FnWpitdvY+9ghAe7IPL55r8AjeN/K4CNv4gnXqBrzEPO1L9cGDqpMoD7CzmQ7v8CS
         Gb368Bbw9atJOSpkVob2o03p5IZfUqRuiCmrn97opU3ifZtVBIEX99oLqZIWK/efMsgs
         zAOKo7Rf5RO9sYiVTtZJpb+qewnComfl3sGz8Cp6kHQ+Sn9MMiEvZxqrzu3HeEHWo7TE
         eC8w==
X-Gm-Message-State: AOJu0YwnsdNm096VcGU6R2dHk7BKRGbOwnF9iTQqUg60//2yciIjL4Cl
	YXbj25OTlVSBEFmT6NEKXGwMP9bMrJw=
X-Google-Smtp-Source: AGHT+IEHv7gQMoWQnzK+qYYvHGIk+ifEEg9fw0f5a9qojfB22UYd6oVBck4rrtv1QufM/wqOsLTUAw==
X-Received: by 2002:a05:620a:491a:b0:77f:4c28:7c8e with SMTP id vy26-20020a05620a491a00b0077f4c287c8emr8688220qkn.66.1702459261792;
        Wed, 13 Dec 2023 01:21:01 -0800 (PST)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
        by smtp.gmail.com with ESMTPSA id dt8-20020a05620a478800b007749dc7881dsm4347681qkb.48.2023.12.13.01.21.01
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 01:21:01 -0800 (PST)
From: Murphy Zhou <jencce.kernel@gmail.com>
To: fstests@vger.kernel.org
Subject: [PATCH] generic/new: drop caches while freeze
Date: Wed, 13 Dec 2023 17:20:43 +0800
Message-Id: <20231213092043.1621684-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 tests/generic/734     | 34 ++++++++++++++++++++++++++++++++++
 tests/generic/734.out |  2 ++
 2 files changed, 36 insertions(+)
 create mode 100755 tests/generic/734
 create mode 100644 tests/generic/734.out

diff --git a/tests/generic/734 b/tests/generic/734
new file mode 100755
index 00000000..8ca91930
--- /dev/null
+++ b/tests/generic/734
@@ -0,0 +1,34 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test 734
+#
+# Test possible deadlock of umount and reclaim memory
+# when there are EOF blocks in files.
+#
+. ./common/preamble
+_begin_fstest freeze auto quick
+
+_supported_fs generic
+_require_scratch
+
+$XFS_IO_PROG -fc "pwrite 0 64k" $SCRATCH_MNT/testfile >> $seqres.full
+cat $SCRATCH_MNT/testfile >> $SCRATCH_MNT/testfile1
+cat $SCRATCH_MNT/testfile >> $SCRATCH_MNT/testfile1
+
+sync
+
+fsfreeze -f $SCRATCH_MNT
+
+# This will hang if bug reproduces
+echo 3 > /proc/sys/vm/drop_caches &
+
+# Manually unfreeze after a while
+sleep 5
+fsfreeze -u $SCRATCH_MNT
+
+wait
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/734.out b/tests/generic/734.out
new file mode 100644
index 00000000..4299839b
--- /dev/null
+++ b/tests/generic/734.out
@@ -0,0 +1,2 @@
+QA output created by 734
+Silence is golden
-- 
2.31.1

