Received: from mx1.redhat.com ([209.132.183.28]:49878 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbcDUDTu (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Apr 2016 23:19:50 -0400
Date: Thu, 21 Apr 2016 11:19:47 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2 V2] dm-thinp helpers in common/dmthin
Message-ID: <20160421031947.GA4675@eguan.usersys.redhat.com>
References: <5717DA92.4030003@redhat.com>
 <5717DAD2.6020708@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5717DAD2.6020708@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>, Mike Snitzer <msnitzer@redhat.com>, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 20, 2016 at 03:38:58PM -0400, Eric Sandeen wrote:
> Basic dm-thinp helpers to set up, tear down, grow, check,
> and set no-space behavior for a single thin dm volume built
> on $SCRATCH_DEV.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks good to me. We're planning to add more thinp tests using this
framework, and we can always improve the dmthin framework if needed.

Reviewed-by: Eryu Guan <eguan@redhat.com>
