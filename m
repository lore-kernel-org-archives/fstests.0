Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0EF23ED6F
	for <fstests@vger.kernel.org>; Mon,  6 Jul 2026 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318266; cv=none; b=QJbrKLy4OMIeJhmh83n6XqHOIVE4gtLrEei/V5u+JT6UdzUoSPZC83rUZ5XdUwXU7wD/fBrEjXDREf5Ur7V1QnzGBha8vI0YI0nryf+Gp7Lu/oayjYF7yVjGzieH8o7CIUGCjc3f5TwOl5/pIKSZnpjENfAqQsWVaeVymUQd/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318266; c=relaxed/simple;
	bh=ktWZVyl1sfVAKpr0zbM+V0zQEQz8Xn9cB+JeqLls4L4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHANbITMe5i/rcrVTvSsaWR0BTY/mgOVLm1mxgQk27yjVdjPipE24GcNfQLwP799YGbjPihs5TN+Uo6gT9+9G7X55mmZLcKpXL6grtlrMdBhgbMS50MGOHAU2p67EE/S/opE+yL5mtuYTbp7rcvNYe9vRNuM+lSHXO/NJCZYLFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YRW7h2X3; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YRW7h2X3"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47dc6e04367so134207f8f.1
        for <fstests@vger.kernel.org>; Sun, 05 Jul 2026 23:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783318263; x=1783923063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BzrgO1pxOk+UkUk9QiYJgPGUjKt/ic9fF9lyI4jG9Kw=;
        b=YRW7h2X3wcnsOZ03mEmBntHWAwPoqyA8CYeNBqH2877le0FAoTIow60UZvP1mTV2yo
         RcIySjiw+vNb38YAm6PPHk4rNXskCw8FNARkQE8KvU5wVqFJaaegVrjxk5hco0rLLHit
         IGnstAtYZSpuf/rjf3aVGflvfh3keNLpbGKYToMZwLlTV3nmNSVeTcP/RjmFwznE9ro2
         o9pkVG1w5DAcXz1vUp5ZEgoO4MSwmHT9rgfXP0uwafAomdgAkYDBWUf9pFrQcmAT+LB9
         OWjDAxEabOK9NbeyNZnf/kSLhpfXIFBexa+buRaWdA3coVCAGLsrZ6NMHe4tv4WXrpwS
         Olbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783318263; x=1783923063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzrgO1pxOk+UkUk9QiYJgPGUjKt/ic9fF9lyI4jG9Kw=;
        b=iwqQmnGRkhqRKZHzhWWwinFTUEyS0ylcNbAqxg3Da4qo8Wib7ZfdU46tyws5sB/wZi
         cIta729eiFSL2F18fdVYmPe3T19fcH3m9ZLoEV4Bh/A0ZeCsh4A0VWqj6tfM4V2vhnIY
         Jex5uNLhfdCiPkz+4jVFNNBHEs9owaeA+bDZFPHlkJ7YWg4c6UnYjBeu5TmJzzbagyrg
         ofKkn/gppCa6jM3Y54v4R/p0QWzN6Jz369EwJu/4hRWyIEK0tdqzSq/Frg5hD8dQ5P9I
         07KlD9KSlW43soktv2gzmUc6cQk6TRht6KMRr9UGb+XUCZIj74wyHRS56ycVO7CLFO4H
         UFOg==
X-Gm-Message-State: AOJu0Yw2x3wY6CRdFhMxNapRBWHYMQ7X+FjaRkOu9M/BpSsaGFYj5vow
	EGTYk6iJEAWBWaWSeR0o8xwgj2XufecoCvfY5s+8XBPhY9qJmTSo41z1c1QHArGMTbWQWc5OHt6
	TN/mCnMQ=
X-Gm-Gg: AfdE7cmSTa3CI5OJm9m/n33W0bcx06/jZ0A39EyuTUpOnZmcGmdRjsdV8q0NfV1Lh+q
	5P5HKPXavHnCzoe8mH+YjmvNVnz6ZuQeUZa5cRr+xdRxOsS+UYaQHIKIZUqXXi3ECpB00RofCw9
	xd6wTzSKF3B7SRkzgPj8qP8WMkNcD0ijd/hoomz0Ow40tqPUaONYawhYCKjOArqVF+kHjKEVTx2
	mNeujpOxheSQuwHj5Ip4kLUECCA//ues/pUPd+qoDxO4maWE6pcJ1DfhiuNkffzUCsYmlMKzKSr
	jFcH+2TUvRVp9tx8VKaO9sEguEDinzHhZuW81G6SXtYUHYWV1f/w1Ao+SWK6+cBIcnggoZySq6C
	lKcnbDOprxo9Ky7EsafH3PUfzemfiQUE19YDk6YI1iu8N7vYfCOtEnYWPFNXge5sBvxnBiY6gNz
	0=
X-Received: by 2002:a05:6000:2485:b0:47d:e01c:c28 with SMTP id ffacd0b85a97d-47de01c0c9dmr3589050f8f.36.1783318263138;
        Sun, 05 Jul 2026 23:11:03 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f213e8sm19343179f8f.34.2026.07.05.23.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 23:11:02 -0700 (PDT)
From: Avinesh Kumar <avinesh.kumar@suse.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH] generic/062: filter setfattr --restore symlink-safety warning
Date: Mon,  6 Jul 2026 08:11:00 +0200
Message-ID: <20260706061102.90603-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avinesh Kumar <avinesh.kumar@suse.com>

attr 2.6.0 (CVE-2026-54371 fix)[0] makes "setfattr --restore" warn when
used without -P and the dump contains a symlink, which generic/062 does.
The warning leaks into the compared output via the setfattr() wrapper
and fails the test. Adding -P isn't portable (older attr doesn't have it),
so filter the warning in the wrapper instead.

[0] https://cgit.git.savannah.nongnu.org/cgit/attr.git/commit/?id=3fb06b9ba314d37035d0877e6de313de754f1ac8

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 tests/generic/062 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/generic/062 b/tests/generic/062
index 89659040..9ccfde36 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -30,7 +30,13 @@ getfattr()
 
 setfattr()
 {
-    $SETFATTR_PROG $@ 2>&1 | _filter_scratch
+	# attr >= 2.6.0 (CVE-2026-54371 fix) warns that "setfattr --restore" without
+	# -P/--physical is unsafe because it can traverse symlinks. Older attr does
+	# not accept -P, so just filter the warning to stay version-agnostic.
+	$SETFATTR_PROG $@ 2>&1 | \
+	sed -e '/^setfattr: .*--restore.* is unsafe without option/d' \
+	    -e '/^Warning: option --restore=.* is unsafe without option/d' | \
+	_filter_scratch
 }
 
 _create_test_bed()
-- 
2.54.0

