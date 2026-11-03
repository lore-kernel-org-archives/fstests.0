Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698350;
	b=zZ/pCkaG/zxXw2jcTAwUb3ySw7gl2uPLsIQ/WorUA5PEuLUkjXRWLyphYbbxfZ2MXKpX
	 yh4vhDApirk7GZN8OAV4R7GyRDz8oMfTmn8rdnnBvFc2n4gTYnX24Rzpid5IS16iR+2mD
	 Pk6U7Bx11Xm3kpUfsyOaR9Kj5q/uS0APb4a0cYvqthowS3uCKSwNAQlJyAUmzNiuyUTRq
	 xs8NiDu+jONZAB+U2woMWWe23Y93zF8kXpO1ZToWNmTlSPUNhD9dhEE/eX6rs2nB16Cs2
	 00aLjjGZe5rSGiATkVSIxSK4Umuu/BdD8EajF3bOScV+OQRFrjIAvH4lpkcUlApo//g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698350;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JxXjWe9vvyaz6j9kDj8sxfpn+qLRhC3I9m59HF71uQE=;
	b=z37N6+/LpDi37X+aRIKoffoUDwvPn/s3c5fyn/Ey4Cz7GS/zZ8bcSQCrmBD98Tt7Afm/
	 9xPzEbC2GnIQR6w7VSWZdiibQ9t8pMb2aK/GqJoOppHmftJoeU8ZkcS7dzGb7ga34yOCB
	 1XRHMH7A21rLHUG7q5cRCw5tXsl3xnuwRV3VfApRyPOHr8z8Uiu8VRWuK3wAGyGDVFPCK
	 h43DiDUtfayTBdrY/7IGadxUiCbP0B73Xy7ctAWhJGTMk0zrzvfaOpq3DLKFu4HERuhB3
	 XxlNNUwy4VroTqKwm4u8qQUzg5qWnoLjB3RjXrHbc1Mr4OmhkPue2joyLFhhGhE8yeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6DrGD4V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2DD606A324
	for <fstests@vger.kernel.org>; Tue,  3 Nov 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6DrGD4V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEEA1F00919;
	Tue,  3 Nov 2026 09:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698350;
	bh=JxXjWe9vvyaz6j9kDj8sxfpn+qLRhC3I9m59HF71uQE=;
	h=From:To:Cc:Subject:Date;
	b=A6DrGD4VPzP9QzDCvJuQPlgtKRAaPo1Z0dps5VCALpVw4crdU5vGIIUsMQFEC1JLP
	 wuDOk3SbauAvNpZ4eZGb00Vr7hygY2nuc4tFX+/15srUDvfmW7s+41vnO3Nq+/u6vs
	 rPXc/tw0/36NKBd2YS23nCumZJ2Y0czVXC8d8uL8Nk4Ou8zzJ/c6r3DmNMlP3Wv2f+
	 ZflYVI5p8Yvn6XnQWoYFVl58h8NyQKmnti88iPGHdnE0f4mFMI9feJVOA9FUu+EM+r
	 wwO62FINFlOSW2iWn8myg1GsQQ/IDrOqdDf0t1Z270YX/F4FxFna58LwJHSR1Bn/3x
	 m3eZz22XaLreA==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: ojaswin@linux.ibm.com,
	hch@lst.de,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH v2] check: set seqres before calling init_rc which could write there
Date: Tue,  3 Nov 2026 10:31:17 +0100
Message-ID: <20261103093116.2850916-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's path where >>$seqres is used in init_rc:

-> init_rc
	-> _test_mount
		-> _prepare_for_eio_shutdown
			->_xfs_prepare_for_eio_shutdown
				-> _set_fs_sysfs_attr

Which will try to write to .full because $seqres is not set. Fix this by
setting seqres first, this way it should go to $RESULT_DIR/check.full.

The init_rc is called in the top context and then per section, however,
for top context we don't have environment set up yet. These logs are
just a few sysfs_attr writes and aren't that important, so, let's save
those to /tmp/xxx.check.full just in case.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
Changes in v2:
- remove The before init_rc in the comment
---
 check | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 534c2cdf7a06..afe855bcf0ed 100755
--- a/check
+++ b/check
@@ -534,6 +534,10 @@ if ! . ./common/rc; then
 	_fatal "check: failed to source common/rc"
 fi
 
+# init_rc could write to the $seqres.full, however we don't have any context
+# here yet, and no RESULT_BASE is setup. These logs aren't that important but
+# let's keep them in /tmp anyway.
+seqres=$tmp.check
 init_rc
 
 # If the test config specified a soak test duration, see if there are any
@@ -932,8 +936,6 @@ function run_section()
 		_test_unmount 2> /dev/null
 	fi
 
-	init_rc
-
 	seq="check.$$"
 	check="$RESULT_BASE/check"
 	seqres="$check"
@@ -941,6 +943,8 @@ function run_section()
 	# don't leave old full output behind on a clean run
 	rm -f $check.full
 
+	init_rc
+
 	[ -f $check.time ] || touch $check.time
 
 	# print out our test configuration
-- 
2.54.0

