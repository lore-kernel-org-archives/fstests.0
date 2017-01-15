Received: from mx1.redhat.com ([209.132.183.28]:42762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbdAOF5b (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 15 Jan 2017 00:57:31 -0500
Date: Sun, 15 Jan 2017 13:57:29 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common/rc: use /bin/bash in _user_do()
Message-ID: <20170115055729.GB1859@eguan.usersys.redhat.com>
References: <1484325496-3995-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484325496-3995-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jan 13, 2017 at 05:38:16PM +0100, Christoph Hellwig wrote:
> Without this the epressions in generic/256 will fail on a system
> where /bin/sh is the Default (e.g. modern Debian versions).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I dropped the generic/256 fix and applied this one.

Thanks,
Eryu
