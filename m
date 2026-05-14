Received: from mx0.herbolt.com (mx0.herbolt.com [5.59.97.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6F53C2B82
	for <fstests@vger.kernel.org>; Thu, 14 May 2026 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.59.97.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758819; cv=none; b=kNqPrbdVcIhzkjlkKATd7LO/BPAk9DikLUlrTftnf/MlAUfiV3DN0F2/CUAy9bD0u3uMYrj5eAzj1A7QK6132iWvOMDaMdwzih67vvlBXba0kdDx8h1Wb/cHdpyT56LWJUFQgrKPqZUmqoeqKXVTPzuae3qIjHGEIQU0y6YV1HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758819; c=relaxed/simple;
	bh=K5wK5LWuc3BpsFCbTU2h4PEJlsJvjfeRVKuTP/eI8G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1lWgILVd6Rm/f0IFYrehuEKm6LPov5BDtDC79j+35X+xxQhrYpb1Zb5+LQl5FLMmBm9DxSA92m4jJjX58HI9BULSnhsx+Q3u1FkPrd3FdFxebBbkd8muiXAgR80gCOwXHu1FbX8tojclp9JviddI+5i0EErJ2MyEzbC0irL0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com; spf=pass smtp.mailfrom=herbolt.com; arc=none smtp.client-ip=5.59.97.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbolt.com
Received: from mx0.herbolt.com (localhost [127.0.0.1])
	by mx0.herbolt.com (Postfix) with ESMTP id 76353180F2D5;
	Thu, 14 May 2026 13:40:10 +0200 (CEST)
Received: from trufa.intra.herbolt.com.com ([172.168.31.30])
	by mx0.herbolt.com with ESMTPSA
	id uaW8NIm0BWoNiioAKEJqOA:T2
	(envelope-from <lukas@herbolt.com>); Thu, 14 May 2026 13:40:10 +0200
From: Lukas Herbolt <lukas@herbolt.com>
To: zlang@kernel.org,
	djwong@kernel.org
Cc: fstests@vger.kernel.org,
	xfs-linux@kernel.org,
	Lukas Herbolt <lukas@herbolt.com>
Subject: [PATCH v2 1/4] common/rc: Add helper to calculate percentage of free space available
Date: Thu, 14 May 2026 13:39:09 +0200
Message-ID: <20260514113910.866888-4-lukas@herbolt.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514113910.866888-2-lukas@herbolt.com>
References: <20260514113910.866888-2-lukas@herbolt.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It calculates percentage of filesystem available space and returns it
in MB. This helper will be used in the following test/generic fixes.

Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
---
 changes v2:
	spelling and description
 common/rc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/common/rc b/common/rc
index 5fe44e2158ff..9fc733ebdcf4 100644
--- a/common/rc
+++ b/common/rc
@@ -6189,6 +6189,16 @@ _require_fanotify_ioerrors()
 	_notrun "$FSTYP does not support fanotify ioerrors"
 }
 
+# Computes a percentage of the available space in a filesystem and
+# returns that quantity in MB. The percentage must not contain a percent
+# sign ("%").
+# usage example:
+# _mb_pct_of_available_space <mount point> <percent>
+#
+_mb_pct_of_available_space()
+{
+        _df_device $1 | $AWK_PROG -v pct=$2 '{printf "%.f", (($5*(pct/100))/1024)}'
+}
 ################################################################################
 # make sure this script returns success
 /bin/true
-- 
2.54.0

