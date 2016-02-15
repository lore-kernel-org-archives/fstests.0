Received: from mx1.redhat.com ([209.132.183.28]:34290 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbcBOGqG (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Feb 2016 01:46:06 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 34C5DC0BBE7D
	for <fstests@vger.kernel.org>; Mon, 15 Feb 2016 06:46:06 +0000 (UTC)
Date: Mon, 15 Feb 2016 14:46:02 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v4] xfs: new case for test default user/group quota
Message-ID: <20160215064602.GF11419@eguan.usersys.redhat.com>
References: <1455515614-16626-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455515614-16626-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, sandeen@redhat.com, cem@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 15, 2016 at 01:53:34PM +0800, Zorro Lang wrote:
> When default quota is set, all different quota types inherits the
> same default value, include group quota. So if a user quota limit
> larger than the default user quota value, it will still be limited
> by the group default quota value.
> 
> An upstream patch for this bug:
> 
>   xfs: Split default quota limits by quota type
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Looks good to me, only xfs/169 is taken now, the next available slot is
xfs/260 :) Anyway

Reviewed-by: Eryu Guan <eguan@redhat.com>

Thanks!

Eryu
