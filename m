Received: from mx1.redhat.com ([209.132.183.28]:57587 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbcBED6t (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 4 Feb 2016 22:58:49 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 7D4C3A1473
	for <fstests@vger.kernel.org>; Fri,  5 Feb 2016 03:58:49 +0000 (UTC)
Date: Fri, 5 Feb 2016 11:58:43 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] fstests: dm-thinp demo test
Message-ID: <20160205035843.GS11419@eguan.usersys.redhat.com>
References: <5628F457.7020605@redhat.com>
 <1454580261-29218-1-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454580261-29218-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: sandeen@redhat.com, fstests@vger.kernel.org, snitzer@redhat.com
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 04, 2016 at 06:04:21PM +0800, Xiong Zhou wrote:
> From: Eric Sandeen <sandeen@redhat.com>
> 
> Fairly trivial test to use the dm-thin infrastructure.
> 
> Right now it exhausts space in queue-on-error mode,
> adds more space, does a bit more IO, then unmounts &
> checks the fs.
> 
> Not sure if that's valid to test, but it works here and
> demonstrates the common/dmthin helpers.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>

Looks good to me. Thanks!

Reviewed-by: Eryu Guan <eguan@redhat.com>
