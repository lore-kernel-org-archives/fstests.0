Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53519 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbbCKLPl (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 11 Mar 2015 07:15:41 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2BBFeUr023332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 11 Mar 2015 07:15:40 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 0/4] some random small fixes
Date: Wed, 11 Mar 2015 19:15:30 +0800
Message-Id: <1426072534-12246-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Eryu Guan (4):
  new: fix template for new case to use a single tab not four spaces
  generic/027: discard mkdir error message
  common: append -d option to XFS_COPY_PROG when testing v5 xfs
  xfs/073: be quiet about mouting with nouuid option

 common/rc         | 5 +++++
 new               | 4 ++--
 tests/generic/027 | 6 +++---
 tests/xfs/073     | 2 +-
 tests/xfs/073.out | 1 -
 5 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.1.0

