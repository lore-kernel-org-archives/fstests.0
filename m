Received: from mx0.herbolt.com (mx0.herbolt.com [5.59.97.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B641B369
	for <fstests@vger.kernel.org>; Thu, 30 Apr 2026 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.59.97.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554842; cv=none; b=AmA1yRqXpTFss9xdNpwz58LsyauUy5zZ3zt15WvHgMHMNJK+kyfwJidzcEvOiRnYCl4HoRke7Xwu29USKHxrRKIW4asXXuIzjLx3c9ixgGwKsAXprXvWmxSegcGklMfUJQ0fBa14FcGoSlBPqqU1qtt3aLHGCk9Ezt4Dk9ympKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554842; c=relaxed/simple;
	bh=RcXhpS3dtLAAS/doZBINk+3f4ekRaLAvLJfzHQhPCsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4YeyCCAI0yoegXutzGtEgQTfenRd76WjTkHxZOjfXh/Z+qz+XhGFOJ0YaTmEhBUfjO6YDvoTjYBE9cB8X/4751di/MWLWHOe844tsA2fo1aDN9CKRCidBu01Eyd6fYdPOeBNo4OMa+N9NUuX9+puvrPKP/qeI8sbDPJQPnXxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com; spf=pass smtp.mailfrom=herbolt.com; arc=none smtp.client-ip=5.59.97.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbolt.com
Received: from mx0.herbolt.com (localhost [127.0.0.1])
	by mx0.herbolt.com (Postfix) with ESMTP id E5693180F244;
	Thu, 30 Apr 2026 15:13:52 +0200 (CEST)
Received: from trufa.intra.herbolt.com.com ([172.168.31.30])
	by mx0.herbolt.com with ESMTPSA
	id HBgTK4ZV82m0DRoAKEJqOA:T2
	(envelope-from <lukas@herbolt.com>); Thu, 30 Apr 2026 15:13:52 +0200
From: Lukas Herbolt <lukas@herbolt.com>
To: zlang@kernel.org,
	djwong@kernel.org
Cc: fstests@vger.kernel.org,
	Lukas Herbolt <lukas@herbolt.com>
Subject: [PATCH 1/4] common/rc:  Add helper to calculate percetage of free space available
Date: Thu, 30 Apr 2026 15:13:16 +0200
Message-ID: <20260430131317.693845-4-lukas@herbolt.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430131317.693845-2-lukas@herbolt.com>
References: <20260430131317.693845-2-lukas@herbolt.com>
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
 common/rc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/rc b/common/rc
index 5fe44e2158ff..32c566cdb68a 100644
--- a/common/rc
+++ b/common/rc
@@ -6189,6 +6189,14 @@ _require_fanotify_ioerrors()
 	_notrun "$FSTYP does not support fanotify ioerrors"
 }
 
+# Returns percentage of available space on given mount point.
+# usage example:
+# _mb_pct_of_available_space <mount point> <percents>
+#
+_mb_pct_of_available_space()
+{
+        _df_device $1 | $AWK_PROG -v pct=$2 '{printf "%.f", (($5*(pct/100))/1024)}'
+}
 ################################################################################
 # make sure this script returns success
 /bin/true
-- 
2.53.0

