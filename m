Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627883;
	b=UODKP5ekitoA+YNnt1/COHmhwiGHZSGaBTPLP9VI4YNK6K/GUeS9eI2q3FQd0P5I/3hA
	 WAaVc/uVA48Kkvd3KzMQEQcHNSc5xoCTtn39VjNgqe21B1DPBGMPzcPNTuHy6WawJC76v
	 nIHQinGd5TzSppDGCKlvXQiRzeiQyJ52UegV/3rYRQmKgdUEjHjMfx8oIwrTvVGTeiSOu
	 mn8mqlyCQpWbezdaljE4K9O+fphkUcVBjM80nXJYXpvKbQqKeW9mxHVXb8gOZun0KtyTM
	 OPd9+YvDcoLB7Vm9mq02E+ODZ6ZZProFtDgANrAEXnsOuL7I4NpJVavugkDY5kOkTBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627883;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iMMEhJRBgs9kKWN6y+JGRrzIlOVn3cdfNcULBxWDsNc=;
	b=hO87SUvKrKVqXLBy4DrHn7GL4AF9oRMLn86zRr2CD4vI85KgovqcL235hZU0saiLv2Gv
	 czj2dJEAfVNkPjoO9nyoRwEzcLgDGveNOxmXJ1Hxl8vLvidwbcas+jnotirZmgf6OI4W5
	 MWgikO3y+ZIjyjJhPPlFmr04gqZHwclewc1uf4pZdZ1bXskqwztj94CUZqjqgMJHJMVrL
	 GtoStQCiy671NV1LBj3hK9T191aL9CN7Tg/qWXfWBcmcNxzd2jsp36zUsX4ZYTzG0g4Uy
	 5sI+KTxs9Dql941RhISn63cS5byMrqtvzzdlNr4r2Qz0KsPeQmyac8iaJFBA1e5kHyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZAYqGlP9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E97606A32C
	for <fstests@vger.kernel.org>; Mon,  2 Nov 2026 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZAYqGlP9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CE91F00A16;
	Mon,  2 Nov 2026 13:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793627882;
	bh=iMMEhJRBgs9kKWN6y+JGRrzIlOVn3cdfNcULBxWDsNc=;
	h=From:To:Cc:Subject:Date;
	b=ZAYqGlP9qDwmJlAwW86loSE7eJVARfu6zdI5UmLngFaRnzTX/2K+t9HRXtAvqcKyr
	 FLCIiBBgxGn+ND7oLVizo4wWi260Yob3RWn/lH6iGOjpscrpB3wa9jxaT0oSVNSr0U
	 FIv/YrePB6Om9NkcncRZKGzB9/ZDHFMCRdmAJzTP2lg6UgBfWkd2sdRkkxTGaWfRUI
	 vnlMDFETRKmUMCeWinvXYe5zP8o3RKlqDEth4WSCP9ChVGfQeHsOx+P+Qt9kh97bIP
	 IOuM6CtMYJP+fQNpbBypTXKmgzlEyq3JdmFifM5Kn4ACvAgiEdIgOSiRwvAghq1GnA
	 uzC+wBn9KrxAw==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: ojaswin@linux.ibm.com,
	hch@lst.de,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH] check: set seqres before calling init_rc which could write there
Date: Mon,  2 Nov 2026 14:57:31 +0100
Message-ID: <20261102135730.2143873-2-aalbersh@kernel.org>
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

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 check | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 534c2cdf7a06..52e4ace34fd7 100755
--- a/check
+++ b/check
@@ -534,6 +534,10 @@ if ! . ./common/rc; then
 	_fatal "check: failed to source common/rc"
 fi
 
+# The init_rc could write to the $seqres.full, however we don't have any context
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

