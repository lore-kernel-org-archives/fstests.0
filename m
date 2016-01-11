Received: from mx1.redhat.com ([209.132.183.28]:58716 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759698AbcAKLcX (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 11 Jan 2016 06:32:23 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 8F94519CF3E
	for <fstests@vger.kernel.org>; Mon, 11 Jan 2016 11:32:23 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 0/3] some random fixes and cleanups
Date: Mon, 11 Jan 2016 19:32:01 +0800
Message-Id: <1452511924-21872-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Just some random fixes and cleanups.

Eryu Guan (3):
  generic/23[23]: some cleanups
  common: no need to parse config file in new
  new: create a default .out file

 common/config     |  5 +++++
 new               |  6 ++++++
 tests/generic/232 | 17 ++++-------------
 tests/generic/233 | 20 ++++----------------
 4 files changed, 19 insertions(+), 29 deletions(-)

-- 
2.5.0

