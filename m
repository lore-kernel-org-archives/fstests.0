Received: from mx1.redhat.com ([209.132.183.28]:37738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753238AbdDKLqW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 11 Apr 2017 07:46:22 -0400
Date: Tue, 11 Apr 2017 19:46:19 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 3/3] DAX: mmap write readonly file
Message-ID: <20170411114619.GK22845@eguan.usersys.redhat.com>
References: <20170407171600.GA29489@linux.intel.com>
 <1491804353-1326-1-git-send-email-xzhou@redhat.com>
 <1491804353-1326-3-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491804353-1326-3-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 10, 2017 at 02:05:53PM +0800, Xiong Zhou wrote:
> Regression case that one can write to read-only
> file in a DAX mountpoint.
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
> 
> v2:
>   compile test programme manually in this test because default
> cc option -O2 prevents this issue reproduction;

Hmm, this looks.. ugly to me :) Better to find out the exact reason that
prevents the bug from reproducing and update the c program accordingly.

Thanks,
Eryu
