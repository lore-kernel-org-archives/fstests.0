Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03731EF366
	for <fstests@vger.kernel.org>; Tue, 18 Mar 2025 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292531; cv=none; b=ZkdE9KZtMdHWxVqsxdq8Ryh10J5bbnOluwyZQsrFWTjQ9ZyZInxWxq2WBBIWETJYDk8w/ldZPBkC5dZnA5EAHPWmhpcwmbRTtKN727PXBqn0sUn/tFNREdVK3mdpLWbQCRbFkKvZ3+Ows4LEq4j+TnLsknUxkn4sIrx/5HyR56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292531; c=relaxed/simple;
	bh=moaGJwlVeGpPCuhd4Yy9qK2ktR0HZ79JjcGi7HjckH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TKCddo2+BYAseP7FPpquQKtBISpfEkjVaTbB2dsqj9B8Mop3hEwd4mfDv9B1vtq5PCCIqrKoN6QRoKG7pYl6mWDs9TUxo0Nfv9pVQgPtUnEeYlzl/Fg9o0tNA3mFNZA7W439nDfv8RwGJVoW1FJIQhlAoYhCa3EQhKkv9bSDycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUKf6koL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUKf6koL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E20AC4CEDD;
	Tue, 18 Mar 2025 10:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742292531;
	bh=moaGJwlVeGpPCuhd4Yy9qK2ktR0HZ79JjcGi7HjckH4=;
	h=From:To:Cc:Subject:Date:From;
	b=kUKf6koLvbujVu9IyhZF9JeC+sRjOgqs5hbsPIA83Xi0J8F26VFzt3ZaxC0gfyB3Z
	 iLheLvu+O1hnLUGhAhRhczQ0XU6f1wKlqje5kwlzYMwc6iaBOwKQbP+wgn9iAiqEoo
	 rr27bYPOpIFZUloz/x6vjZwQn8r/pWwSMcfqciFMafvKBZUO3fy98rhmgj5cquw7Nk
	 iEpByNRGK4k+Cg5/8WoVHvY6D71bOIXPClYi8ft3Bh5Hw8HfviLyY82z+f4rrMuo4s
	 2KIYLme/Qz5YzRVAszNXMgdVEYkF2re+538fFng3v8oHulj5QvoaBoIHL8IIEuG6Zg
	 Z+Dzl7+BtGUYg==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org
Subject: [PATCH] common/rc: explicitly test for engine availability in _require_fio
Date: Tue, 18 Mar 2025 18:08:48 +0800
Message-ID: <20250318100848.114915-1-zlang@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Sandeen <sandeen@sandeen.net>

The current test in _require_fio (--warnings-fatal --showcmd) does not
fail if an invalid/unavailable io engine is specified.

Add an explicit test that every requested io engine in the job file
is actually available.

Also, remove the "ioe_e4defrag" entries in the [global] stanza of several
ext4 tests which use fio jobfiles. While ioengines can be set in the
[global] section, they can also be overridden in individual, subsequent
stanzas. In each affected test (ext4/301, ext4/302, ext4/303, and
ext4/304) every individual stanza after [global]re-specifies an ioengine;
either with ioengine=e4defrag or ioengine=libaio.

Because of this re-specification, the ioengine in the [global] section
is ignored. This is a good thing, because ioe_e4defrag is not a valid
ioengine, and would fail this new hand-rolled check, even though fio
did not complain.

So rather than over-complicate this new check, simply remove the unused,
invalid "ioengine=ioe_e4defrag" lines in these tests.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 common/rc      | 7 +++++++
 tests/ext4/301 | 1 -
 tests/ext4/302 | 1 -
 tests/ext4/303 | 1 -
 tests/ext4/304 | 1 -
 5 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index dcdfa86e4..e51686389 100644
--- a/common/rc
+++ b/common/rc
@@ -3985,12 +3985,19 @@ _require_scratch_dev_pool_equal_size()
 _require_fio()
 {
 	local job=$1
+	local eng
 
 	_require_command "$FIO_PROG" fio
 	if [ -z "$1" ]; then
 		return 1;
 	fi
 
+	# Explicitly check for every ioengine listed in the job
+	for eng in `sed -n "s/ioengine=\(.*\)/\1/p" $job | sort -u`; do
+		grep -wq $eng <($FIO_PROG --enghelp 2>/dev/null) || \
+			_notrun "fio engine $eng not available"
+	done
+
 	$FIO_PROG --warnings-fatal --showcmd $job >> $seqres.full 2>&1
 	[ $? -eq 0 ] || _notrun "$FIO_PROG too old, see $seqres.full"
 }
diff --git a/tests/ext4/301 b/tests/ext4/301
index abf47d4b7..a05b8e8a8 100755
--- a/tests/ext4/301
+++ b/tests/ext4/301
@@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
 cat >$fio_config <<EOF
 # Common e4defrag regression tests
 [global]
-ioengine=ioe_e4defrag
 iodepth=1
 directory=${SCRATCH_MNT}
 filesize=${FILE_SIZE}
diff --git a/tests/ext4/302 b/tests/ext4/302
index 87820184e..e0f5f2f98 100755
--- a/tests/ext4/302
+++ b/tests/ext4/302
@@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
 cat >$fio_config <<EOF
 # Common e4defrag regression tests
 [global]
-ioengine=ioe_e4defrag
 iodepth=1
 directory=${SCRATCH_MNT}
 filesize=${FILE_SIZE}
diff --git a/tests/ext4/303 b/tests/ext4/303
index 2381f0477..0a83e86cd 100755
--- a/tests/ext4/303
+++ b/tests/ext4/303
@@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (3+1))))
 cat >$fio_config <<EOF
 # Common e4defrag regression tests
 [global]
-ioengine=ioe_e4defrag
 iodepth=1
 directory=${SCRATCH_MNT}
 filesize=${FILE_SIZE}
diff --git a/tests/ext4/304 b/tests/ext4/304
index 53b522ee8..5f2ae4bdc 100755
--- a/tests/ext4/304
+++ b/tests/ext4/304
@@ -32,7 +32,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
 cat >$fio_config <<EOF
 # Common e4defrag regression tests
 [global]
-ioengine=ioe_e4defrag
 iodepth=1
 directory=${SCRATCH_MNT}
 filesize=${FILE_SIZE}
-- 
2.47.1

