Received: from mx1.redhat.com ([209.132.183.28]:50195 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbcDUDWy (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Apr 2016 23:22:54 -0400
Date: Thu, 21 Apr 2016 11:22:51 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2 V2] dm-thinp demo test
Message-ID: <20160421032251.GB4675@eguan.usersys.redhat.com>
References: <5717DA92.4030003@redhat.com>
 <5717DB06.2060004@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5717DB06.2060004@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>, Mike Snitzer <msnitzer@redhat.com>, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 20, 2016 at 03:39:50PM -0400, Eric Sandeen wrote:
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

Tested with ext2, ext4, v5 xfs, v4 xfs and btrfs, all look good.

Reviewed-by: Eryu Guan <eguan@redhat.com>

Xiong Zhou helped resend v2 of this patch back in Feb., but seems that
patch got lost. Thanks Eric for resending!

Eryu
