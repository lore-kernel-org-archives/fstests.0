Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD543DB655
	for <fstests@vger.kernel.org>; Mon, 13 Jul 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934246; cv=none; b=KOmpalj0toB1eVaCMJ+5tqGUeS0nrDSp8LvwX1piG2oIZP6yeK6gXeZYEuUPz+hWQ7/0RUhfnfsKi3HRwG4tbxRvZa+5oFkWRyrvtS/okOEKoYf72Ll54c6lwYvpben+BQ6175ZfYkYHHQBvth/FtuKm0ZLhZTvNcOykRa8NNkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934246; c=relaxed/simple;
	bh=nGJVNWIGTlh3Ve2rtxXhO8Lwyjsbz0tmH8VzXSPm6zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiOWl4j2q165aPlWkVBPTbGf45KMcPJZeSmpvGf5yr7qkynNaCT7I0NDmLr3O1GD27FnajEo/d5vJfUe+dOpTElKCmTP7ZUsQiMvc/sCElkcCim3hSg4LtCLVm2m5Ihk+u1BplAQK/A+wUekO0bLt07B54pcfdj2TQLRoesYgd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojNH0b8s; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojNH0b8s"
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3814e2e7d79so304336a91.1
        for <fstests@vger.kernel.org>; Mon, 13 Jul 2026 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783934243; x=1784539043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YS9HSQYLWxfpBGl81FLqKvaHWT/gifA7Uzz1bJeYLjU=;
        b=ojNH0b8sYyIJR6EIfay50FOmQkM2jpj2qkVfWPxLUDO1SiN8qzHdD4kIQlKIYGdL/f
         mR4KVjUSl1XHgLX9zPSeMoVVnZGQCXxa5u+JoXhhZeh91035gJsUvbW4NiJ2mob//oMs
         7C6Fd5YKAK6WPSPKVRqxIo6YxAhZG34aOi0d7/va1T6dHSTYr0+xeg1vYYNC/+byr9Vo
         h5FgqZu1iayYJh2jpdE5FIiD94aBdsr0vD0IXu4d7uJ/NY+mQLtT/X/CPoxzYeDOtl7r
         /ovpGh4HkiNFlCBAz5bFmPHD33192JEex3FunOr5RAeFFqkuXueFaw+JaOI9ekurScgw
         r6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783934243; x=1784539043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YS9HSQYLWxfpBGl81FLqKvaHWT/gifA7Uzz1bJeYLjU=;
        b=clAir9vl85QFEgSZ56AKn6H2WReowDmKujdE0Ex9DXHaZyemg4MnAB6KtD+NpswGXH
         o13Cm2arnOWze/rlBcOIUMUE793ZIglKXaCCZVGssjNpqVFJemhcXefsZT7OuCZPADFZ
         /Nx9bjL3y86NiONwDN3xA/p8a+ZZCL3T0H82Rp7Tp0NxAdPMl+Etyq3oCrJIAh3+54z+
         nSfWMQwIXS9UYqg5zS1LtSqecCNtwJPEyofYfkvYKgYmmnrv0P3PAPhGE6wz3cTMIJ21
         9QUYQjWnrYH/eLLtFJ4JrHrGnzBzG5/LiK9n9QjSlLU1f+YBayrEzFEeuX+t3840Zh34
         Y/Ew==
X-Forwarded-Encrypted: i=1; AHgh+Rqk+qBCCKwppGTPDTNnx/+cxDEYQbTuI0U/sKofDHVa/7MCO+UOHAaA1azilTv1HdQQ8pEzxbLJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyosS2mMu/8C7kwZSOBtDIfjYJuQehET0R5+ocFfCjo3J183WS6
	hnQIdkSQK7Xz22dVvYvrWTzZsdgPx2vn7XlPh4fRA87WhiAYx4ZWZ9SpcGmXSSwQAsSNVw==
X-Gm-Gg: AfdE7cmJVXWrmPetDSBda0UH1HgQJbIfzqwPXnaYpi4wUqLDOiUJUWmzjWWgUmxIj5Z
	XgW+sLqTLHnwevlZyE5Mvg9UIn3S0reWG3oEt4aV+ZpvewYciNO6KJdDGTibhVzrYL6aP1F8LTF
	dX/Fp68MhHROD04CPmUQm29YRLBmL3WS6kDswFwq1Dp1RWVSWrZik/b+UYk26lR1YOmVe+hDtfZ
	ezYa9eXGec6BlYBx1JABoPXI+VeTxYTNeyfi/eg5sKDGbO8I1Q0pOeO9q5EWUpMA/VnadU7dhiv
	eQiPXys2VV3qqALONzQeZgnT7Ujw0+4UBcBfVbQHLF8LZ21YRJOskV3NI5iM34kS10Pc3VHWvCL
	QIoIW9d3ntN41osYhJe3xBXx1tLYHGntcZyT49WcwTgHcO46gJI8w6kFJ8DBPfG6lHzxLZaNzxm
	WihruvJ7vVynxgCGuIzEXhkAckmD/VMSFIhCb1s+pi
X-Received: by 2002:a05:6a00:4b4e:b0:848:7e85:f210 with SMTP id d2e1a72fcca58-8488985ddf7mr5437136b3a.4.1783934242683;
        Mon, 13 Jul 2026 02:17:22 -0700 (PDT)
Received: from SaltyKitkat ([154.83.91.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b975a0sm13768349b3a.14.2026.07.13.02.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 02:17:22 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Sun YangKai <sunyangkai@fnnas.com>
Subject: [PATCH] btrfs: test POSIX ACL changes for RO btrfs property
Date: Mon, 13 Jul 2026 17:06:45 +0800
Message-ID: <20260713091659.4981-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709082500.17907-2-sunk67188@gmail.com>
References: <20260709082500.17907-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sun YangKai <sunyangkai@fnnas.com>

Test creation, modification and deletion of POSIX ACLs for a btrfs
filesystem which has the read-only property set to true.

Re-test the same after the read-only property is set to false.

This complements btrfs/275, which covers the generic ->setxattr path.
POSIX ACLs are set and removed through the ->set_acl inode operation
(btrfs_set_acl), which is a separate code path that is not covered by
the RO check added for security xattrs in commit b51111271b03 ("btrfs:
check if root is readonly while setting security xattr").  As a result,
ACLs could still be modified on a read-only subvolume, bypassing the RO
protection that applies to every other xattr.

The test exercises the set, get and remove cycle of an access ACL on a
regular file, and expects all modifications to fail with EROFS while the
subvolume is read-only.

Signed-off-by: Sun YangKai <sunyangkai@fnnas.com>
---
 tests/btrfs/353     | 97 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/353.out | 39 ++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100755 tests/btrfs/353
 create mode 100644 tests/btrfs/353.out

diff --git a/tests/btrfs/353 b/tests/btrfs/353
new file mode 100755
index 00000000..60059d4a
--- /dev/null
+++ b/tests/btrfs/353
@@ -0,0 +1,97 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 YOUR NAME HERE. All Rights Reserved.
+#
+# FS QA Test No. 353
+#
+# Test that POSIX ACLs cannot be changed once a btrfs subvolume has the
+# read-only property set.
+#
+# Setting or removing a POSIX ACL goes through the ->set_acl inode
+# operation, which is a different code path from the generic ->setxattr
+# one covered by btrfs/275.  It used to be allowed on a read-only
+# subvolume and thus bypassed the RO protection.  Such modifications must
+# fail with EROFS, just like any other xattr.
+#
+. ./common/preamble
+_begin_fstest auto quick acl attr
+
+. ./common/filter
+. ./common/attr
+
+# TODO: fill in the kernel commit hash that fixes the ->set_acl path once
+# it is merged.
+# _fixed_by_kernel_commit <HASH> \
+#	"btrfs: check if root is readonly when setting posix acl"
+
+_require_acls
+_require_btrfs_command "property"
+_require_scratch
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+FILENAME=$SCRATCH_MNT/foo
+
+set_acl()
+{
+	local perm=$1
+
+	# Use -n so setfacl does not recalculate the mask, keeping the
+	# golden output deterministic regardless of the named user's
+	# permissions.
+	setfacl -n -m u:$acl2:$perm,m::rwx $FILENAME 2>&1 | _filter_scratch
+}
+
+get_acl()
+{
+	getfacl --absolute-names -n $FILENAME | _filter_scratch | _getfacl_filter_id
+}
+
+del_acl()
+{
+	setfacl -b $FILENAME 2>&1 | _filter_scratch
+}
+
+_acl_setup_ids
+
+# Create a test file.
+echo "hello world" > $FILENAME
+
+# Set an initial ACL while the subvolume is writable.
+set_acl rwx
+
+# Attempt to change the ACL once the subvolume is read-only.  This must
+# fail with EROFS.
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro true
+$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
+
+set_acl r--
+
+# The ACL must not have changed.
+get_acl
+
+# Attempt to remove the ACL from the read-only subvolume.  This must
+# fail with EROFS as well.
+del_acl
+
+# The ACL must still be present.
+get_acl
+
+# Make the subvolume writable again.
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro false
+$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
+
+# Now changing the ACL must succeed.
+set_acl r--
+
+get_acl
+
+# And removing it must succeed too.
+del_acl
+
+# Check the ACL is really gone.
+get_acl
+
+status=0
+exit
diff --git a/tests/btrfs/353.out b/tests/btrfs/353.out
new file mode 100644
index 00000000..66f4a0e5
--- /dev/null
+++ b/tests/btrfs/353.out
@@ -0,0 +1,39 @@
+QA output created by 353
+ro=true
+setfacl: SCRATCH_MNT/foo: Read-only file system
+# file: SCRATCH_MNT/foo
+# owner: 0
+# group: 0
+user::rw-
+user:id2:rwx
+group::r--
+mask::rwx
+other::r--
+
+setfacl: SCRATCH_MNT/foo: Read-only file system
+# file: SCRATCH_MNT/foo
+# owner: 0
+# group: 0
+user::rw-
+user:id2:rwx
+group::r--
+mask::rwx
+other::r--
+
+ro=false
+# file: SCRATCH_MNT/foo
+# owner: 0
+# group: 0
+user::rw-
+user:id2:r--
+group::r--
+mask::rwx
+other::r--
+
+# file: SCRATCH_MNT/foo
+# owner: 0
+# group: 0
+user::rw-
+group::r--
+other::r--
+
-- 
2.54.0

