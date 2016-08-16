Received: from mx1.redhat.com ([209.132.183.28]:54196 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106AbcHPD0W (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Aug 2016 23:26:22 -0400
Date: Tue, 16 Aug 2016 11:26:20 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/263: test xfs_quota "state" command
Message-ID: <20160816032620.GL27776@eguan.usersys.redhat.com>
References: <ae59c7a8-321c-42c4-70e4-8d9e8dca80b8@redhat.com>
 <20160815053626.GF27776@eguan.usersys.redhat.com>
 <5efd2e7f-5cd9-2a01-4a8f-b9308f3bd13d@sandeen.net>
 <6979e124-ee73-94e3-1c09-1dfb2d0b368a@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6979e124-ee73-94e3-1c09-1dfb2d0b368a@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 15, 2016 at 10:15:17PM -0500, Eric Sandeen wrote:
> > strange, that's the kind of thing the kernel patch was intended to fix.
> > 
> > I meant to retest from scratch on bleeding-edge upstream, but too many
> > things got in the way today.  Will try again tomorrow...
> 
> Can you recheck?  I built everything from scratch on a freshly-installed
> box, and with the patches mentioned, it passes for me.
> 
> oh, but try V2 of the xfsprogs patch ;)  (I'll send that in a minute).

The v2 patch of xfsprogs works! Test passed for me too this time.

Thanks,
Eryu
