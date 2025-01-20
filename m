Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295C11494CC
	for <fstests@vger.kernel.org>; Mon, 20 Jan 2025 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737392503; cv=none; b=Ho3aSivZSQnQXwoAjDUgBAgGahrZU5f9tgbh3dmEFP6Vz5aC+6BLYgoTqKrlEFylQhYMdyoKZRvjIA8pGn/B/+iJeyn2po8msOcSwUalkoAgZSS1rfd04xX2Rz0Wl5CTPCUV63DNJe8BYaQv7LK5dLFF1vcw8WvXtXHE6gu3XN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737392503; c=relaxed/simple;
	bh=3ow7rn802RxE1ryIKYxzgc3Ic8faIfyahg4SvzR9vxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bO4ZltERCUvheR5/EylE7D6xgl2soVy3VyJ505OC8S1ahT9O4Vd9je9H6pozk2kamiCjHuG3+gdqUbUNwwIGh3RwvlSCmi6Hu/KlQhhlFB3Ss5GSSJOboVG+blWPrwlEHCYL3JzKPLkx8T76mejzCJT+d4HLQ7lqhPhzscS7Cyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=pMyItjb2; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pMyItjb2"
Received: from cwcc.thunk.org (pool-173-48-114-200.bstnma.fios.verizon.net [173.48.114.200])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50KH1KIZ018111
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 12:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1737392485; bh=0zUUQd7sH0SvlXuvHU361VEnWRMbwvAqwYSuiNgwjUE=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=pMyItjb2dAz6WsWJX+dTfrRKPf333wOsfVDC3tbBMyTseaTZNohgkg7jjMxHYHnHV
	 NJQrQX098qIPhNPkKje0jWS00Bi8ueB/XfZ481kfUsRj1xE5Uu1RniUzn+pCuzIaAi
	 z1J6hjzC4oItx+EMxJ/BfXq6+nkZIc2G5DzLXUeQ3exd8NtPOUQLgA0C/nMmuYOzuv
	 JNK5sKK04Nfm5CVm+/xZWshYm9FlhmNr/TlCVnx+n9OzKFAxiqmz6BoMQOSYy9111R
	 ki3Epf0wNQsTfgBNoTqOq78ru+I6dEAmSlaNq/OU4+D2sLW7w77/MAteyMBeQp616g
	 S9c4oWeJvbW4Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3C9FC15C0176; Mon, 20 Jan 2025 12:01:20 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v2] xfs/32: fix test failure on kernels which don't support bs > ps
Date: Mon, 20 Jan 2025 12:01:09 -0500
Message-ID: <20250120170109.3770633-1-tytso@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117210202.GJ3557695@frogsfrogsfrogs>
References: <20250117210202.GJ3557695@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When trying to mount a file system with a block size > page size on
kernel which doesn't support this, suppress the error messages from
showing up in the output file lest it cause test failures.

Fixes: 0b66f6efd669 ("xfs/032: try running on blocksize > pagesize filesystems")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
v2:
    As Darrick suggested redirect the output of mount(8) to $seqres.full
    instead of /dev/null

 tests/xfs/032 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/032 b/tests/xfs/032
index 41a9134d8..675881d5b 100755
--- a/tests/xfs/032
+++ b/tests/xfs/032
@@ -44,7 +44,7 @@ for ((; SECTORSIZE <= 65536; SECTORSIZE *= 2)); do
 		if [ $? -ne 0 ]; then
 			continue
 		fi
-		if ! _try_scratch_mount; then
+		if ! _try_scratch_mount >> $seqres.full 2>&1 ; then
 			if [ $BLOCKSIZE -le $PAGESIZE ]; then
 				_fail "mount $(_scratch_mount_options $*) failed"
 			fi
-- 
2.45.2

