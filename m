Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3333523E22A
	for <fstests@vger.kernel.org>; Tue, 18 Feb 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890231; cv=none; b=ICu8s7QQMEaQfgX+p/gkOW+rldqeYTY0ibi/Yd61R7Y8ukpgnKUCmwAQkfvFTL6N1kuU75ZkvYgJuAXEwIvxHofLmy4AlfP2y8k1mg6oI11+TqKNoIx4Md2K75ixKKAaTCLbBdO4/VFO4Ev/UTShEqmsCvRy3zU45dvdqQM9ZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890231; c=relaxed/simple;
	bh=joXpTSzsTz7Q+MifMzea/fdu6y41R/4GnM6Z1UyMxYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzqXipof8j8yy+3auYeXgQDrFEJL1aFXkczQIskMd8PgKwlLZQh9rZVjN/mFyXO+smQXiMOwBBrChpUBGFjHZsgFF1wsqG6haP3hyC64WEGGjfmvWLNNAqLQIrw8BLU2lwMwvXs0u5XWO7sJ70WMNslSITpeoHKlpDPIsSVVEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-113.bstnma.fios.verizon.net [108.26.156.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 51IEoKk7013980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 09:50:20 -0500
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id EE53E2E011A; Tue, 18 Feb 2025 09:50:19 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] fsx: add missing #include for sys/uio.h
Date: Tue, 18 Feb 2025 09:50:12 -0500
Message-ID: <20250218145012.382965-1-tytso@mit.edu>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The <sys/uio.h> header is needed to provide the function declarations
for preadv2() and pwritev2().

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 ltp/fsx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 2c19fff88..9a3d4cce0 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -38,6 +38,7 @@
 #include <liburing.h>
 #endif
 #include <sys/syscall.h>
+#include <sys/uio.h>
 
 #ifndef MAP_FILE
 # define MAP_FILE 0
-- 
2.47.2

