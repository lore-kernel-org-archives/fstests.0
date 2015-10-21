Received: from mx1.redhat.com ([209.132.183.28]:44752 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755122AbbJUUsC (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 21 Oct 2015 16:48:02 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 2DD4DC0BEA88
	for <fstests@vger.kernel.org>; Wed, 21 Oct 2015 20:48:02 +0000 (UTC)
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 0/2] dm-thinp helpers and demo test
Message-ID: <5627FA00.70003@redhat.com>
Date: Wed, 21 Oct 2015 15:48:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
Cc: Mike Snitzer <snitzer@redhat.com>
List-ID: <fstests@vger.kernel.org>

Patch one adds common/dmthin to create & manipulate a dm-thin device

Patch two is a POC test which uses that harness; it may not be
at all what we want to test, just putting it out there as a demo.
