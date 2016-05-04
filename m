Received: from mx1.redhat.com ([209.132.183.28]:37030 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbcEDJ0j (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 4 May 2016 05:26:39 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90603C06C9E1
	for <fstests@vger.kernel.org>; Wed,  4 May 2016 09:26:38 +0000 (UTC)
Date: Wed, 4 May 2016 17:26:36 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] overlay: test copy up by changing mode bits
Message-ID: <20160504092636.GC5140@eguan.usersys.redhat.com>
References: <1461241438-24238-1-git-send-email-xzhou@redhat.com>
 <1462344796-8172-1-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462344796-8172-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 04, 2016 at 02:53:16PM +0800, Xiong Zhou wrote:
> Changing file attr in overlayfs triggers copy up.
> Test this by changing mode bits then check both mode
> bits and copy up results.
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>

Looks good to me.

Reviewed-by: Eryu Guan <eguan@redhat.com>
