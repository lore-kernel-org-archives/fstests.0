Received: from mx1.redhat.com ([209.132.183.28]:58513 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257AbcDTTh5 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Apr 2016 15:37:57 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBAA57F36F
	for <fstests@vger.kernel.org>; Wed, 20 Apr 2016 19:37:55 +0000 (UTC)
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 0/2 V2] simple dm-thinp infra & test
Message-ID: <5717DA92.4030003@redhat.com>
Date: Wed, 20 Apr 2016 15:37:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

V2 of this, renumbered, with fixes suggested by Eryu on round one.

Thanks,
-Eric
