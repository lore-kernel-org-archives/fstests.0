Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B3E242D7B
	for <fstests@vger.kernel.org>; Thu, 23 Jul 2026 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787990; cv=none; b=R+pVuizYRXx7cMDaNkVZWVsDQ5lQKTujfUrPOFNeoc7z/LnPRRQGX44QIHhhC8JbwMuhu3ebh6IByL8VB232SnV0EmQUusvMoWytjNTtdYbkPsXOqO4MKc2J5ADCXwomC+zFvpm2uAWExwDWy9ZnbmbOD2f5YFh81W2ThRc4TWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787990; c=relaxed/simple;
	bh=pA0lLImSgJVRevmunC2Vpg+EibYOh+Ztt0tHkPfy2tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t0cvKnvphk6IR/gE9+Lghk0ZHVjZLQgCSYKDQ83RD7he+dnQqONmTDqvtyMuBP8cr8RcQpeTz/nEYcEves4FX4ZWsgOlqI6ijdyYk3pIDnhop5jLEOUOq1OKnlkogTBQpxoguerZZikr4Y2WX1jZ899FconWVMXyFhfgjK+v6kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKHuJIjT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHfw2l5Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKHuJIjT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHfw2l5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784787986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gsxqc3C17W6Vy4U8Xn5ssOEk0JR4LMMuxg4hsQ5Gx0Y=;
	b=HKHuJIjTzS6TFPMREn5VFDYgHb4UL9Kq1fd2nZD34fgW6HVdzHhg/wdujMNwWt38eP0SF0
	JhHRCosZ2+aClE/kBjc2ePBhlg8ojWpsDahwKPBRx4/GX9Bh814QPUiCjPost374eK1pBO
	K6F5YPqi8xatFa5DgP8mWumct1MfJlE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-MQpgKheJPVyRo-U_eV_WtA-1; Thu, 23 Jul 2026 02:26:25 -0400
X-MC-Unique: MQpgKheJPVyRo-U_eV_WtA-1
X-Mimecast-MFC-AGG-ID: MQpgKheJPVyRo-U_eV_WtA_1784787984
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8486c3411c8so515242b3a.2
        for <fstests@vger.kernel.org>; Wed, 22 Jul 2026 23:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784787984; x=1785392784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gsxqc3C17W6Vy4U8Xn5ssOEk0JR4LMMuxg4hsQ5Gx0Y=;
        b=GHfw2l5QTPciDay9RtDTSK7L6F7ZLKJImjIfD1QVH8eKUObNwd+HCi4ZcH2/08bGJ+
         21snraYClnCCbvqbKIlKzn3pzYzj3/KifXs+WD5vSL/HPNGAYE7FO5cyI/m8L84YLu0G
         kwPPxA6T1vZabeaFd3zexkIRknaQtd4ynxslVeTh8CgEgSEBEEG4W1P4mxrM/lvP7KU7
         7Q9gxA2+qEfY3GJcJLAB4EpFPbzeq/toUQ0YEW4pF3YlZUu1xdw/qq945lERAxahfY3R
         697BUN6klyEgYRTWKrK6n6zJ6A+8RXa4Cd7Lywcwl82G85HoEjeFOtprv96TSWKzHZnb
         FZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784787984; x=1785392784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gsxqc3C17W6Vy4U8Xn5ssOEk0JR4LMMuxg4hsQ5Gx0Y=;
        b=MIuN5y7m2rvOppbR4nGMwiIki1Zg/XnXvus/lind5iosYEZunOw9nEpJYoUsaU5pZS
         YE6POky885cJsU7MSHvgAyKiS+qVgM671FilZuleAyBU0jG2yHo/99prCXHV8VzEgJ3d
         wFIGu7AgH10gZZ/xt7QfsGr0zcdUVf37J1ycU1lCmuKnkbnbX0xC8KV6w3L+RrSihKc8
         Qk77BOXIzeSPOWsvXO9sb3vQc2rvp6L5CMk0vWG1A5gjHN5IH0OhLUuvynrnjT4zkN3t
         GWjjE8jDfUCcLCHH5vM/YP9FgkCDQ+Cfgis7tHsdU1+oduO20HD9rMTGgfaG7yM0X9r+
         uNSQ==
X-Forwarded-Encrypted: i=1; AHgh+RrY9APbSwNMvM7IqiD6462ccgtXo/8dCu+0/7iBgG0sUckMp2pVOIVd/r51F2AvrwrWnFbSKJYK@vger.kernel.org
X-Gm-Message-State: AOJu0YwXpF5znYbCIiNbvKaaYGH6ln8EtXrOaBcttLTO0RT+t4mky8R2
	04MUwJduh4kWkp4rwfp3KMYbT+rpEDZZYR3Q5tPoDJem7sQJ1ZHnfJ9OkD5MrxJci6WESX3dGlp
	1pf/X3pjZTdk+D1YbqWwc5FO2fH1cpHAc1rkG/I9FuF9EWk3tQPJ0nYedwd2t7mmqhng=
X-Gm-Gg: AR+sD11xsGpY/zBLCoMNu714kvrQN5ps49TDp3vErhmd+L5XYP2AyMkq8cYk8WyXSZi
	AulNZU+Iotxkk2TF/MAnOvGr90AnuCXtAPYe8ERRagWxt4CyxwzfpjK836mCfa9P5KugOI9B9LD
	ZfvJEcsPNI9c7qXUcbcEs4mPnjKe3DdQL9MAOyqzN91o8EiZX3xPBlJU5NNJG1YleLXxSC5fhPB
	gEiWcKCwlQNRsa2C73JYSH771SHZPiCumZBwERf6oYac6FaWZO1EpljGRCzij4PL9QXgVZEo4HF
	pwRYJAzTGCy8yohl81QosrKVm5Aa9tDBRP2qRo7ppYH+24NNyzJN2Jnm4u62M4iXKPLStKBR/F/
	/4+5537u6kek=
X-Received: by 2002:a05:6a00:2388:b0:846:7fb0:4ca2 with SMTP id d2e1a72fcca58-84e2bb462e4mr2122048b3a.61.1784787984157;
        Wed, 22 Jul 2026 23:26:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:2388:b0:846:7fb0:4ca2 with SMTP id d2e1a72fcca58-84e2bb462e4mr2122023b3a.61.1784787983547;
        Wed, 22 Jul 2026 23:26:23 -0700 (PDT)
Received: from anathem.redhat.com ([2001:8003:4b1b:d900:266e:8be8:569:ffa6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175cf946sm2489965b3a.49.2026.07.22.23.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:26:22 -0700 (PDT)
From: Donald Douwsma <ddouwsma@redhat.com>
To: linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Donald Douwsma <ddouwsma@redhat.com>
Subject: [PATCH v2] xfs: test xfsdump subtree restores
Date: Thu, 23 Jul 2026 16:26:17 +1000
Message-ID: <20260723062617.424905-1-ddouwsma@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regression test for cumulative restores where a directory has been
renamed outside of the subtree being restored triggering the assert:

  xfsrestore: tree.c:1421: noref_elim_recurse: Assertion 'isrealpr' failed

Signed-off-by: Donald Douwsma <ddouwsma@redhat.com>
---
Changes since v1
- Fix use of _do, including label quoting
- Update test output
- Add tests for additional edge cases
---
 tests/xfs/995     | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/995.out |  8 +++++++
 2 files changed, 66 insertions(+)
 create mode 100755 tests/xfs/995
 create mode 100644 tests/xfs/995.out

diff --git a/tests/xfs/995 b/tests/xfs/995
new file mode 100755
index 000000000..bba0bcd52
--- /dev/null
+++ b/tests/xfs/995
@@ -0,0 +1,58 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Red Hat.  All Rights Reserved.
+#
+# FS QA Test 995
+#
+# Regression test for cumulative restores where a directory has been
+# renamed outside of the subtree being restored resulting in
+#
+#   xfsrestore: tree.c:1421: noref_elim_recurse: Assertion 'isrealpr' failed
+#
+. ./common/preamble
+_begin_fstest auto dump
+_do_die_on_error="always"
+
+_fixed_by_git_commit xfsdump dd63de5 \
+	"xfsrestore: only process subtrees that are selected"
+
+# Override the default cleanup function.
+_cleanup()
+{
+	_cleanup_dump
+	cd /
+	rm -r -f $tmp.*
+}
+
+# Import common functions.
+. ./common/dump
+
+# Modify as appropriate.
+_require_scratch
+_scratch_mkfs_xfs >>$seqres.full
+_scratch_mount
+
+mkdir -p $SCRATCH_MNT/a/b/c/d/e/f/g
+mkdir -p $SCRATCH_MNT/restore_me/B/C/D/E/F/G
+
+_do "Creating l0 dump" "$XFSDUMP_PROG -L lab_l0 -M test -l0 -f $tmp.dump.l0 $SCRATCH_MNT"
+
+mv $SCRATCH_MNT/a/b/c $SCRATCH_MNT/1
+
+_do "Creating l2 dump" "$XFSDUMP_PROG -L lab_l2.0 -M test -l2 -f $tmp.dump.l2.0 $SCRATCH_MNT"
+
+dir=$(mktemp -d $SCRATCH_MNT/restore_XXX)
+_do "Cumulative restore l0" "$XFSRESTORE_PROG -f $tmp.dump.l0 -r $dir"
+_do "Cumulative restore l2" "$XFSRESTORE_PROG -f $tmp.dump.l2.0 -r $dir"
+
+dir=$(mktemp -d $SCRATCH_MNT/restore_XXX)
+_do "Cumulative subtree restore l0" "$XFSRESTORE_PROG -f $tmp.dump.l0 -r -s restore_me $dir"
+# The next command core dumps prior to xfsdump v3.3.0 when noref_elim_recurse attempts to
+# rename directories outside of the subtree when their parent has not been created.
+_do "Cumulative subtree restore l2" "$XFSRESTORE_PROG -f $tmp.dump.l2.0 -r $dir"
+
+dir=$(mktemp -d $SCRATCH_MNT/restore_XXX)
+_do "Restore l2 on its own" "$XFSRESTORE_PROG -f $tmp.dump.l0 -r -s restore_me $dir"
+
+# success, all done
+_exit 0
diff --git a/tests/xfs/995.out b/tests/xfs/995.out
new file mode 100644
index 000000000..9a620eb31
--- /dev/null
+++ b/tests/xfs/995.out
@@ -0,0 +1,8 @@
+QA output created by 995
+Creating l0 dump... done
+Creating l2 dump... done
+Cumulative restore l0... done
+Cumulative restore l2... done
+Cumulative subtree restore l0... done
+Cumulative subtree restore l2... done
+Restore l2 on its own... done
-- 
2.52.0

