Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAB92575A
	for <fstests@vger.kernel.org>; Wed,  5 Jun 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605146; cv=none; b=bXTulTfWA64pGZc/M1WxDaZ2+9mYQobuBsQc+KecXxIQmuK5A6GoYiIBKBMvalhI1pafhT1ZPEx4Jb6Fr4VDVfPcPU053tQtBUkbvHat/5chlJJBzJYwI+L497a3fBezegGTSU2Xb5sOCaBQW3XkJKtMWrhNzqk8Bsi4RQkD2ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605146; c=relaxed/simple;
	bh=Ge3V0RQLlpwjzw5GK8UjJuhHqEzWW+VP4c3I0pQXULA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dEW6clb0TtQFE5gXF9qd1jdU7xe5+eZuGA0h2hVvkj/AdotCuQaBdwL4WyXSOFvnLq5hTxOqzFVbsHHVmOhh81yXfCgo12Kk8ZjcoXQhapTWC1nZHz1o/gKWENLbWmJ0qaBoVb3S2AjHGtHy74uk3+z3uXlpEJr4HVBsLtYrY1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TowX5nPd; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TowX5nPd"
X-Envelope-To: fstests@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717605138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2h4aA2T0/KKdD2I3NI1+kEymt0amWWhe0yeAMSWJc6o=;
	b=TowX5nPdNXz2lnKCauzpkDK9sp59M3vXmPMC1BoV0+DiCmw9Ka/PIBN/DJjojSfdAu47ve
	qPXs4KKMaqURTHaBWpPyUKLzecmEcukeM/xz9Ib78ozF3du0uu9aqTuQc0b1dEMtdRO529
	3j6pBPKHgxFtkNbQ3iGqwvoqFnfdcpA=
X-Envelope-To: luis.henriques@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: fstests@vger.kernel.org
Cc: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH] generic/077: ignore errors occurred while accessing the filler files
Date: Wed,  5 Jun 2024 17:32:10 +0100
Message-ID: <20240605163210.18450-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When looking for data to fill in the filesystem, errors accessing files
may occur.  This will cause the test to fail as it'll show in the output
lines such as:

    du: cannot read directory '/usr/etc/sudoers.d': Permission denied

Ignoring these errors should be safe, so simply redirecting the stderr of
'du' to $seqres.full fixes it.  Unfortunately, this exposed a different
issue, which was the truncation of the $seqres.full file while copying files
into the filesystem.  This patch also fixes that.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 tests/generic/077 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/077 b/tests/generic/077
index 2624e88f1456..4d66f1055403 100755
--- a/tests/generic/077
+++ b/tests/generic/077
@@ -12,13 +12,13 @@ _begin_fstest acl attr auto enospc
 # Something w/ enough data to fill 256M of fs...
 filler=""
 [ -d /lib/modules ] && \
-	[ $(( $(du -h -m /lib/modules | tail -1| cut -f1) * 2 )) -ge 256 ] && \
+	[ $(( $(du -h -m /lib/modules 2>> $seqres.full | tail -1| cut -f1) * 2 )) -ge 256 ] && \
 	filler=/lib/modules
 
 # fall back in case /lib/modules doesn't exist or smaller
 [[ -z $filler ]] && \
 	[ -d /usr ] && \
-	[ $(( $(du -h -m /usr | tail -1| cut -f1) * 2 )) -ge 256 ] && \
+	[ $(( $(du -h -m /usr 2>> $seqres.full | tail -1| cut -f1) * 2 )) -ge 256 ] && \
 	filler=/usr
 
 # Override the default cleanup function.
@@ -58,10 +58,10 @@ echo "*** set default ACL"
 setfacl -R -dm u:fsgqa:rwx,g::rwx,o::r-x,m::rwx $SCRATCH_MNT/subdir
 
 echo "*** populate filesystem, pass #1" | tee -a $seqres.full
-cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
+cp -rf $filler $SCRATCH_MNT/subdir >>$seqres.full 2>&1
 
 echo "*** populate filesystem, pass #2" | tee -a $seqres.full
-cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
+cp -rf $filler $SCRATCH_MNT/subdir >>$seqres.full 2>&1
 
 _check_scratch_fs
 
