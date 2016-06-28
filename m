Received: from mx1.redhat.com ([209.132.183.28]:57525 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbcF1FlW (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 28 Jun 2016 01:41:22 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4F953B728
	for <fstests@vger.kernel.org>; Tue, 28 Jun 2016 05:41:21 +0000 (UTC)
Date: Tue, 28 Jun 2016 13:41:20 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v7 2/3] generic/093,099,237 shared/051: Add / use
 _require_runas and _runas
Message-ID: <20160628054120.GZ23649@eguan.usersys.redhat.com>
References: <1467067222-18286-1-git-send-email-agruenba@redhat.com>
 <1467067222-18286-3-git-send-email-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467067222-18286-3-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 28, 2016 at 12:40:21AM +0200, Andreas Gruenbacher wrote:
> Add _require_runas and _runas functions instead of open-coding it in
> test cases.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks good to me.

Reviewed-by: Eryu Guan <eguan@redhat.com>
