Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C67383C9C
	for <fstests@vger.kernel.org>; Fri, 17 Apr 2026 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776449332; cv=none; b=IAGDdcgeYK+5bRxLUHK84RleWXEHyt54cDir9Wow6KuChqi0kgAnFrAXI2FZlxxQIT4Y0AJH6pRH+H7LpIX3UNodbabkjOcw7wDta98BMaIsd5nplb4+E9HXqHKdSuy/ylFR6F6T8D7kQNPgmKR8eAk7T1Wgjw8msFP4pPKkFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776449332; c=relaxed/simple;
	bh=Z+p8YNuV56l+svLHnkBI+GSBRitXAux6DMow+x0aBk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQY66x/dlLriokS9Ae9m2ir4J+H6/0R8P3/jKP5+gqcA8EU5tz5M8QoJyi+WtR3BnQoDsic5pCN4+EzO08FNkMgKIFBTLMxeTTNu+mm5xrxXDR3nIZwrwCAj/Oc9AKRW76pGY1uwe2hBMzh5Nybmv/o60NBz1hcXNKG1zRJjle4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rC6AgkXm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rC6AgkXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23748C19425;
	Fri, 17 Apr 2026 18:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776449331;
	bh=Z+p8YNuV56l+svLHnkBI+GSBRitXAux6DMow+x0aBk8=;
	h=From:To:Cc:Subject:Date:From;
	b=rC6AgkXmvYlM4jEy/ygzAt/jDFYVpFY+wS4BJKi5BlJ7evMcOUzoy5mvh+ZY4PWcy
	 l+1YVRB2Aq1GsdUjaOeoVBaS9qNvpRqYbqwP0bxeczGPQP5X/J/+OzVMjHbt4Imkzx
	 n8TxoLzJYHXHIBUO9trchLFORIyHuxZO4RYujPgKNfrPlRJsVJuYzf8+8GPwbAneue
	 7gbICZOKgU+eHqbOILO0kM+Ok5JQ17c/S9jvE5K/98fqW/Kdq4sur7vWlm/McCAicN
	 dJOI8w/Q7jLIY3DsWQ18yAAVFSFS39uJWVzGVgqCa/gIqP2y7DQL3oz1GoHiMQNO3B
	 BiKlKU64fA6rg==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: Dave Chinner <dgc@kernel.org>
Subject: [PATCH] xfs/227: fix bad variable expansion
Date: Sat, 18 Apr 2026 02:08:39 +0800
Message-ID: <20260417180839.282768-1-zlang@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The create_data() set cmd_str to "-c \"resvsp $((off * 4096)) 4096\".
That cause xfs_io can't split the command line properly, it fails as:

  command ""resvsp" not found

Fixes: aaf40fb7 ("fstests: xfs/227 is really slow")
Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 tests/xfs/227 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/xfs/227 b/tests/xfs/227
index 7f8ee2db..ed505b18 100755
--- a/tests/xfs/227
+++ b/tests/xfs/227
@@ -78,13 +78,13 @@ create_attrs()
 create_data()
 {
 	local blocks=$1
-	local cmd_str
+	local cmd_args=()
 
 	for off in `seq $blocks -1 0`; do
-		cmd_str="-c \"resvsp $((off * 4096)) 4096\" $cmd_str"
+		cmd_args+=("-c" "resvsp $((off * 4096)) 4096")
 	done
 	$XFS_IO_PROG -f -c "truncate $((($blocks + 1) * 4096))" \
-			$cmd_str $2 >> seqres.full 2>&1
+			"${cmd_args[@]}" $2 >> $seqres.full 2>&1
 }
 
 # create the designated file with a certain number of attributes and a certain
-- 
2.52.0

