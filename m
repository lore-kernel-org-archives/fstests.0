Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A73143C61
	for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990849; cv=none; b=WypI47Q23z+hXvzzhdQ5x6LVatmrxDDjWWaDzdsj/j2cJS3dmLlz9KSQ05KCQWJFaHMFmgvcdi73XmV0QTtZQKWUHL3FDup7ah76FfbFrodYVNxkUsFzHEk7QD0wuOfmdBQAtZkNNt0S22Nek1M/2qe8A9zh6uR1JQLpesZawzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990849; c=relaxed/simple;
	bh=zYMR+txw7D8MKhJSX3sYZ9zAmPCvprnZqq/wwb4OIA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzLNbMuKXT7c3RC3VKQW/+qsEpWiKSRGNmq3UyXadBCqvpA7Ki0qjdOYdxS7ZBzi0+wvbDUa2DXyQdBk8+4djPJel80IbXADMD6NG5IteVc7JxD54ISZGv2Bx/lcZXctSXFdIVMq8y9EhCQj4IpiSC14zeP5kB7koA+HwKc5+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=debVmzwW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="debVmzwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48796C4CEF5;
	Wed, 17 Dec 2025 17:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765990847;
	bh=zYMR+txw7D8MKhJSX3sYZ9zAmPCvprnZqq/wwb4OIA8=;
	h=From:To:Cc:Subject:Date:From;
	b=debVmzwWshKOw0sI2l+ynz8y+pYEsjgYlLyNjjQ2/tF1593/rKf8t5+7H77+Da2Ww
	 50pw02nbiftmNmV0sIjPMndFbJ4fTSHcANyCEB1t9U2ZNahMaBimar3dRPkY+aquoS
	 SdmKxobHa1q1joK2LmTU4MwpRhITjBNW4i4CUeG8tkrMnuMW6HF49JBDoMPJtN9f9i
	 tvg9ALulhXeXko4JqD5WtPIa4cv4RJeC3LsBK19BoNmaOPTiBqCz0Fs9gDqTFFX50q
	 3AthKvjX+DHy3iP2PeeFn5WrEfs4/6SeRiKu+jFV0F/VhJBL7zenszHgASmkwZuUDd
	 8LOjYzsJbudHw==
From: Anand Jain <asj@kernel.org>
To: zlang@kernel.org
Cc: hch@lst.de,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: fix flaky device name in _cleanup_flakey
Date: Thu, 18 Dec 2025 01:00:22 +0800
Message-ID: <6025643af0c6a7d7d377aef22a53f23f24f06db6.1765988375.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no device named flakey-test, which _cleanup_flakey() currently
uses. The actual device name is stored in $FLAKEY_NAME and is set to
flakey-test.$seq. Use $FLAKEY_NAME instead.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 (apply this on top of the patchset
	'stop overriding SCRATCH_{,LOG,RT}DEV v2')
 common/dmflakey | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/dmflakey b/common/dmflakey
index cb0359901c16..6ac666f5b61e 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -76,7 +76,7 @@ _cleanup_flakey()
 	# otherwise the umount will hang
 	test -n "$NON_FLAKEY_LOGDEV" && $DMSETUP_PROG resume $FLAKEY_LOGNAME &> /dev/null
 	test -n "$NON_FLAKEY_RTDEV" && $DMSETUP_PROG resume $FLAKEY_RTNAME &> /dev/null
-	test -n "$NON_FLAKEY_DEV" && $DMSETUP_PROG resume flakey-test > /dev/null 2>&1
+	test -n "$NON_FLAKEY_DEV" && $DMSETUP_PROG resume $FLAKEY_NAME &> /dev/null
 
 	_unmount $SCRATCH_MNT > /dev/null 2>&1
 
-- 
2.43.0

