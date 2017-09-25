Received: from mga14.intel.com ([192.55.52.115]:31432 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934032AbdIYQ7j (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 25 Sep 2017 12:59:39 -0400
Date: Mon, 25 Sep 2017 10:59:28 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v5 3/3] xfs/260: remove per-inode DAX flag test
Message-ID: <20170925165928.GA26723@linux.intel.com>
References: <1492413255-11146-1-git-send-email-xzhou@redhat.com>
 <1506328847-1669-1-git-send-email-xzhou@redhat.com>
 <1506328847-1669-4-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506328847-1669-4-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 25, 2017 at 04:40:47PM +0800, Xiong Zhou wrote:
> This flag has been disabled upstream kernel.

I am working on patches to re-enable the DAX inode flag in the upstream
kernel, so I'd prefer that we keep this test.  It currently passes even with
the per-inode DAX flag in XFS disables, so I don't see the harm in keeping it
around.
