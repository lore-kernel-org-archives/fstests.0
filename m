Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FEB28DBE
	for <fstests@vger.kernel.org>; Fri, 19 Jan 2024 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705653782; cv=none; b=of3i38AKiD6p/pnAyHQnoyN/1+NrXQ+Xj6t29DF++BJ9B57YB3oV8ZEtBtpnJFtoo8phIfKzRMEfA+DsLKUpuwceAnhi9ofAXEzFKLhgAwaqG0OHuB2jXu2BWS/EBT+MgJXrtmUBPjCddUd5hiPFdCNK00uAyDgLEOgqvvK479w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705653782; c=relaxed/simple;
	bh=qBlIzXY/VFIAUc7GfHGIBBaoPZNCqhvUfOgmqH2Tj98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sH4aYArT3XsEgOJSXOGz9uwZWqIG+K81NhGjEC0Ti5SuoZesfrNS/89ES8vndWDZh58udgQaWyt6tqYLHTwHB1RzbbEwjnPf/fstK4HNLEcq7y+r7L8E+5434FW2Ckl857nzWzF6TmkMcSPJbysXvVrx3iDR/7g6X2WCi/tvN4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W-vOXl7_1705653766;
Received: from localhost(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0W-vOXl7_1705653766)
          by smtp.aliyun-inc.com;
          Fri, 19 Jan 2024 16:42:49 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: fstests@vger.kernel.org
Cc: Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH 0/1] add 'mv' errmsg filter and apply in generic/682
Date: Fri, 19 Jan 2024 16:42:43 +0800
Message-Id: <20240119084244.56373-1-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all:

I have noticed that after coreutils 9.4+, generic/682 will meet the same mismatch output
just like generic/245 (commit d9323ad :'generic/245: Filter mv error message').
To fix this, we can seperate the filter ,move it into common 
directory as '_filter_mv_err_msg' and apply it to similar cases.

Attention: in generic/419 and generic/369, there also exists "cannot move ... to ..." 
output. After testing, generic/419 don't need to apply filter. But I don't know how to 
enable 'richacl' on my filesystem, so I can't verify if generic/369 needs to be fixed.

Ferry Meng (1):
  generic/682: apply 'mv' error message fitler.

 common/filter         | 13 +++++++++++++
 tests/generic/245     |  9 ++++-----
 tests/generic/682     |  2 +-
 tests/generic/682.out |  2 +-
 4 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.19.1.6.gb485710b

