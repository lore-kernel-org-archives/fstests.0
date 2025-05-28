Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE92750FA
	for <fstests@vger.kernel.org>; Wed, 28 May 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423748; cv=none; b=QhQ5uLt/ZBwhm6Eko587dbKBIYKLz0oCXmvItZCF19dV3dpIgWjH3poRYex2xhx6kn0NuzklT1QJUrcu/463J7zsFnLocUltZwRnWmSpEhAtJIsEM8APE2ozAQmjSxihFCBNS94Zd1Pq66v78o2xiiqBgvcfciSKkGcYHng394o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423748; c=relaxed/simple;
	bh=b+dG7zfqEzrMhSKw16Er8jw7VTSFIt0SDj4Kqj+nlG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJeYEM2NBNj3TITNPbASSrxf+nKNUsd8PrTnPUgKgftg9oKdnyHm5Y/J3sYvfqWkfF3kJsI7tyu5gcCwgeVvnJTfStcEJdY4Fhe3gJGFJbfFp3FBiaZyOPLyNO+6qVIEhFpM3iW8y9ZeuEDZhtRC31WKOkM5YNbFdHnPPR2lZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=ly2rtrv+; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="ly2rtrv+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1748423746; x=1779959746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SxJdbVjLJSbkcvmZ+DE2znFtgZJZNOie6F0+DcmRqWE=;
  b=ly2rtrv+Lo29631oIoQi63RHX5y9aqIUC/e08sWZDMS9NOHaaIDzZdqC
   AWfVcHRD2d2b6/b07JabTejrOwXjDxNUaOwrUvNKzfHt6novChcnQ9dgH
   /KeOerEfEVy1XclzTUmwMFo5BGsrW0J60qeEjw2hQj6kC9KHkTINYqKcY
   25s4veuaNaHgS10OPpBOd8d4hnM+656xbJl+XnXk+Ka9qzIBn00ENUMfe
   z9Q253rjNZ2cl8z44ifhuPurSgQyR3qnsiBTd51g4f7QodKEuXJ7AzsdN
   OS1Kx8GncKLUMtIwh9Z1x4HfWz743dMCtHz1XmEFY61UKJ9KdscwtdShY
   g==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 18:15:33 +0900
X-IronPort-AV: E=Sophos;i="6.15,320,1739804400"; 
   d="scan'208";a="534970981"
Received: from unknown (HELO cscsh-7000014390.ap.sony.com) ([43.82.111.225])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 28 May 2025 18:15:33 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	friendy.su@sony.com
Subject: [PATCH v1 6/7] generic/645: add _require_chown
Date: Wed, 28 May 2025 17:15:29 +0800
Message-ID: <20250528091530.1218188-7-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test uses chown to set GID and UID, which requires chown
support, so add _require_chown to check for chown support.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Friendy Su <friendy.su@sony.com>
---
 tests/generic/645 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/645 b/tests/generic/645
index 068a46a9..d6eb75e6 100755
--- a/tests/generic/645
+++ b/tests/generic/645
@@ -15,6 +15,7 @@ _begin_fstest auto quick idmapped mount
 
 _require_idmapped_mounts
 _require_test
+_require_chown
 _wants_kernel_commit dacfd001eaf2 \
 	"fs/mnt_idmapping.c: Return -EINVAL when no map is written"
 
-- 
2.25.1

