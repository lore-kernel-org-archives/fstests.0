Received: from mx1.redhat.com ([209.132.183.28]:35558 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932249AbcE0GnF (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 May 2016 02:43:05 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C73F75CB
	for <fstests@vger.kernel.org>; Fri, 27 May 2016 06:43:04 +0000 (UTC)
Date: Fri, 27 May 2016 14:43:03 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] overlay: test memleak in copy-up error handling path
Message-ID: <20160527064303.GF5140@eguan.usersys.redhat.com>
References: <1464329580-23709-1-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464329580-23709-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 27, 2016 at 02:13:00PM +0800, Xiong Zhou wrote:
> This memleak leads to panic when unmount the underlying fs.
> Kernel commit ab79efab0 fixed this issue.
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>

Looks good to me, thanks!

Reviewed-by: Eryu Guan <eguan@redhat.com>
