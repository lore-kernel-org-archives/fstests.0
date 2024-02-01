Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D9B15F32E
	for <fstests@vger.kernel.org>; Thu,  1 Feb 2024 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804267; cv=none; b=VDDUwFou+GW44xG5xpyd+IdzPOX+8/2hWfi0W2XoEWT3PJhQenOiTGHJ7g4UxB14py3UWDf0p6XSSt6toCkPq/3fYLbKUvl3GwRpMUjTbA9Zyplp+01lb/Qno4R/84gaephx3jgV6VKxwIAAO9EJFS9h0pOA/y4LMrV9bDatz9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804267; c=relaxed/simple;
	bh=D6RpJUqtXPGX/9Cy2zAcMAmCDIdwBH24WDBVt/qY67M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sClXsIE1a7TfK4elP5D0tu0XvSXFl0yUBDN7mac0ZTyKR46fdYPa+WyYy9QFde0rAvLF/bji8ZUIoSZ4DQC96UdRQImEdt4KuMKy+dPNQd2nzY0aA0epfKU8o12CAFJcaFgG4EU0Odi4JC4NY92F5xwT3oyt+B/F9VuntDgrSNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LJNbDiy9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LJNbDiy9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LJNbDiy9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LJNbDiy9"
Received: from localhost.localdomain (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id ABF8521DF0
	for <fstests@vger.kernel.org>; Thu,  1 Feb 2024 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706804261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UUAasQn2GqvZG8qxT9o4vWuPuKOf6NLHJvS9x1mhCak=;
	b=LJNbDiy9/dQK1cisK99B2b54IG3eadclxJ4PIPDwE+T3lyhNkid+XlG5j7WBywcxe8E9D5
	+tEPOYHlmyPUKJBp47nrAh9VqjF3kc+QqhfeVxB86fYbCLVF++qkCLKM+XT73tgs4O7fKO
	mapdaFLVjq1RHNYngh3eiMBEWCfiUww=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706804261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UUAasQn2GqvZG8qxT9o4vWuPuKOf6NLHJvS9x1mhCak=;
	b=LJNbDiy9/dQK1cisK99B2b54IG3eadclxJ4PIPDwE+T3lyhNkid+XlG5j7WBywcxe8E9D5
	+tEPOYHlmyPUKJBp47nrAh9VqjF3kc+QqhfeVxB86fYbCLVF++qkCLKM+XT73tgs4O7fKO
	mapdaFLVjq1RHNYngh3eiMBEWCfiUww=
From: Anthony Iliopoulos <ailiop@suse.com>
To: fstests@vger.kernel.org
Subject: [PATCH 0/2] generic/681 and generic/682 fixes
Date: Thu,  1 Feb 2024 17:17:30 +0100
Message-ID: <20240201161732.6126-1-ailiop@suse.com>
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
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[13.80%]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

A couple of fixes on g/68[12].

Anthony Iliopoulos (2):
  generic/68[12]: use the dir blocksize for xfs filesystems
  generic/682: update and fix-up golden output

 tests/generic/681     |  6 +++++-
 tests/generic/682     | 14 ++++++++++++--
 tests/generic/682.out |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.41.0
