Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4716F0C7
	for <fstests@vger.kernel.org>; Tue,  7 May 2024 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108870; cv=none; b=OhMjqCxUWXPYJZmmHCW1Tn3/8JylYjHc0AZy1VAAaD0ByBdErn/BlwaqebzJYaHk42GGOdnhDkWgdNCUOBKdyZGFi7Jq3qABLBLP/B6kbp0zBnW+Uc4Ppcu7KxOU8+0c9s58t2Wd88Ee9tPkxzECQPhVhyT35gIk9crYWshwK1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108870; c=relaxed/simple;
	bh=0NUao/gEFdY1TO+f/WA4MFNhUUeKucCQ44/+yK3adxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIT3zTuvKEidQTIvQ0de3IIUbi4K+CChvfTVwhGR7ZfrYUzpw7arD996WskY8CfdyG8F0/F3seKSOaGNHWV7kH77DRs5sRZiOcisWiv6Tv4zd3VKP91P3s2xwsSr9TeY2HnkR0YbX0z4NXgPhNYBqBJl+YUjNPTYgsMh+ndItyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F04B343FE;
	Tue,  7 May 2024 19:07:46 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58921139CB;
	Tue,  7 May 2024 19:07:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QCqaFQJ8OmZpGwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 07 May 2024 19:07:46 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/4] Move shared/298 to generic/746
Date: Tue,  7 May 2024 21:07:45 +0200
Message-ID: <e3ba2cb3b29bd8282852dded32b1a784ce315ba5.1715108589.git.dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715108589.git.dsterba@suse.com>
References: <cover.1715108589.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 5F04B343FE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

The shared/ directory was supposed to host tests that apply to a subset
of all supported filesystems but this is not utilized much and creates a
split from the generic tests. Move the test to generic.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 tests/{shared/298 => generic/746}         | 2 +-
 tests/{shared/298.out => generic/746.out} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/{shared/298 => generic/746} (99%)
 rename tests/{shared/298.out => generic/746.out} (100%)

diff --git a/tests/shared/298 b/tests/generic/746
similarity index 99%
rename from tests/shared/298
rename to tests/generic/746
index 1d4e8d943bdaa6..0e6387fe4d5ece 100755
--- a/tests/shared/298
+++ b/tests/generic/746
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2013 Red Hat, Inc., Tomas Racek <tracek@redhat.com>
 #
-# FS QA Test No. 298
+# FS QA Test No. 746
 #
 # Test that filesystem sends discard requests only on free blocks
 #
diff --git a/tests/shared/298.out b/tests/generic/746.out
similarity index 100%
rename from tests/shared/298.out
rename to tests/generic/746.out
-- 
2.44.0

