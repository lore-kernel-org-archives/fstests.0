Received: from mx1.redhat.com ([209.132.183.28]:39530 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbcFGDp6 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 6 Jun 2016 23:45:58 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E90F164389
	for <fstests@vger.kernel.org>; Tue,  7 Jun 2016 03:45:56 +0000 (UTC)
Date: Tue, 7 Jun 2016 11:45:55 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfstests: update xfs/096 for new behaviour
Message-ID: <20160607034555.GK5140@eguan.usersys.redhat.com>
References: <1464858659-610-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464858659-610-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 02, 2016 at 11:10:59AM +0200, Jan Tulak wrote:
> Because we recently changed how mkfs behaves when it gets incorrect/invalid
> values, update the expected output to reflect the change.

This will break test with old-behavior xfsprogs. But I'm not sure what
the best solution is..

And it seems that generic/054 and generic/055 are failing because of the
same reason, if so, fix them together?

Thanks,
Eryu
