Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A598DF56
	for <fstests@vger.kernel.org>; Tue,  6 Feb 2024 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241064; cv=none; b=bBxxeYkbZ7HBVY9iVmJ7Y4ZVDPVFxkPyOb6j3F1U4HVfEjEbEpONf2V9VHQ8kTdB3fWIcuTg47d3mzvXk6LUCBFGV4BSZpk4FSD9BnZ0gs0AxuYpmlD57q7otxrJJj5dupZrqr0YfOSqBRUya7SSWymZQqTIeamPSMofZoLNTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241064; c=relaxed/simple;
	bh=ScUbqvsjCmu4V6erhlYMKST3zPwdzkj6+/0whR+CZEQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ok81b+a8zuvoxmIyAbabFPOyYg+DIhuV7Sl6YdekMyUmN9MPUiMc3mJA5oRoVgb5n8qtysW4QQDp32U68fEpWrIplSLz6cjRDGZ3D6Y1POH9g59EvxqCQ3HhkOR57jSWKdeZyLKQhWjZ2+/r+J7DG4cc+BFj6TLk2XggoJOOerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ajXGWa74; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ajXGWa74; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ajXGWa74";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ajXGWa74"
Received: from localhost.localdomain (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id B476B22124
	for <fstests@vger.kernel.org>; Tue,  6 Feb 2024 17:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707241060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oAFpqUwk7I/3p0ShvgA19aRFC97OB/W2wqIxDSvVnFQ=;
	b=ajXGWa74PuBaTKpwxUtLHEEbq0EbdQyTzMUtGYEhgZVh4iFaa+CK7VWC3Np/VL27a769B5
	24tIFoYqO7XRjHD16uc1iPCW3y8JHKqDBns4/aWxXX9ZwCk/hyP2KuRdBCCmvq9wAR3y5B
	k2L9o+Ygsh4HI93YW/ZCfJ+YC+jWa6M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707241060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oAFpqUwk7I/3p0ShvgA19aRFC97OB/W2wqIxDSvVnFQ=;
	b=ajXGWa74PuBaTKpwxUtLHEEbq0EbdQyTzMUtGYEhgZVh4iFaa+CK7VWC3Np/VL27a769B5
	24tIFoYqO7XRjHD16uc1iPCW3y8JHKqDBns4/aWxXX9ZwCk/hyP2KuRdBCCmvq9wAR3y5B
	k2L9o+Ygsh4HI93YW/ZCfJ+YC+jWa6M=
From: Anthony Iliopoulos <ailiop@suse.com>
To: fstests@vger.kernel.org
Subject: [PATCH v2 0/2] generic/681 and generic/682 fixes
Date: Tue,  6 Feb 2024 18:36:23 +0100
Message-ID: <20240206173625.18623-1-ailiop@suse.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[26.66%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

A couple of fixes on g/68[12].

v2:
  - add Andrey's rvb in first patch (no changes)
  - consolidate g/245 and g/682 mv filter into common/filter

Anthony Iliopoulos (2):
  generic/68[12]: use the dir blocksize for xfs filesystems
  generic/682: update and fix-up golden output

 common/filter         | 14 ++++++++++++++
 common/rc             | 11 +++++++++++
 tests/generic/245     | 14 +-------------
 tests/generic/681     |  2 +-
 tests/generic/682     |  4 ++--
 tests/generic/682.out |  2 +-
 6 files changed, 30 insertions(+), 17 deletions(-)

-- 
2.41.0

