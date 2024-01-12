Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAFC5EE9D
	for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HeHXXIP1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HeHXXIP1"
Received: from localhost.localdomain (unknown [10.100.128.76])
	by smtp-out2.suse.de (Postfix) with ESMTP id 51E4A1F8D7
	for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 13:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705064631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xwUYiU5Rvwfz3uglZFuX4+oZk7K9EU8NKouG/MB3dJs=;
	b=HeHXXIP1aCD2OpXL+x3hQ9D9QG9T2DCfPJrG9DCfbZx26qH537bHlhrWMb9mXeuwvBVIQL
	twQUdk2zPHhpXQbtx4bQfOKydYPU5HCLtFRvgwzTZekv6dt5Qo1lfAHCZ0dT1oHKVMgWLM
	FP0uqYfSvDW2nit6RSuicHG4OYeqaso=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705064631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xwUYiU5Rvwfz3uglZFuX4+oZk7K9EU8NKouG/MB3dJs=;
	b=HeHXXIP1aCD2OpXL+x3hQ9D9QG9T2DCfPJrG9DCfbZx26qH537bHlhrWMb9mXeuwvBVIQL
	twQUdk2zPHhpXQbtx4bQfOKydYPU5HCLtFRvgwzTZekv6dt5Qo1lfAHCZ0dT1oHKVMgWLM
	FP0uqYfSvDW2nit6RSuicHG4OYeqaso=
From: Anthony Iliopoulos <ailiop@suse.com>
To: fstests@vger.kernel.org
Subject: [PATCH] src/af_unix: drop unused offsetof macro definition
Date: Fri, 12 Jan 2024 14:03:31 +0100
Message-ID: <20240112130331.4079-1-ailiop@suse.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.80
X-Spamd-Result: default: False [3.80 / 50.00];
	 ARC_NA(0.00)[];
	 BAYES_SPAM(0.00)[12.88%];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-0.995];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.11)[-0.547];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+]
X-Spam-Flag: NO

The offsetof macro is causing compiler warnings since it is being
redefined, but it is anyway not used, so drop it completely.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 src/af_unix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/af_unix.c b/src/af_unix.c
index 41037ee4b7ad..89df76586f27 100644
--- a/src/af_unix.c
+++ b/src/af_unix.c
@@ -17,8 +17,6 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 
-#define offsetof(TYPE, MEMBER)	((size_t)&((TYPE *)0)->MEMBER)
-
 int main(int argc, char *argv[])
 {
 	struct sockaddr_un sun;
-- 
2.41.0

