Received: from mx1.redhat.com ([209.132.183.28]:38988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935073AbdIZAvl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 25 Sep 2017 20:51:41 -0400
Date: Tue, 26 Sep 2017 08:51:38 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH v5 3/3] xfs/260: remove per-inode DAX flag test
Message-ID: <20170926005138.rjguykujldz7adxx@XZHOUW.usersys.redhat.com>
References: <1492413255-11146-1-git-send-email-xzhou@redhat.com>
 <1506328847-1669-1-git-send-email-xzhou@redhat.com>
 <1506328847-1669-4-git-send-email-xzhou@redhat.com>
 <20170925165928.GA26723@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925165928.GA26723@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 25, 2017 at 10:59:28AM -0600, Ross Zwisler wrote:
> On Mon, Sep 25, 2017 at 04:40:47PM +0800, Xiong Zhou wrote:
> > This flag has been disabled upstream kernel.
> 
> I am working on patches to re-enable the DAX inode flag in the upstream
> kernel, so I'd prefer that we keep this test.  It currently passes even with
> the per-inode DAX flag in XFS disables, so I don't see the harm in keeping it
> around.

Okay for me. Thanks!
