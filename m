Received: from mx1.redhat.com ([209.132.183.28]:42658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751949AbdATBY0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 19 Jan 2017 20:24:26 -0500
Date: Fri, 20 Jan 2017 09:15:45 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH v2 1/2] xfs: test per-inode DAX flag by IO
Message-ID: <20170120011545.eq72oj33467uigb5@XZHOUW.usersys.redhat.com>
References: <20170119055405.GT1859@eguan.usersys.redhat.com>
 <1484820838-5098-1-git-send-email-xzhou@redhat.com>
 <1484820838-5098-2-git-send-email-xzhou@redhat.com>
 <20170119204925.GB28456@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170119204925.GB28456@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Xiong Zhou <xzhou@redhat.com>, eguan@redhat.com, linux-nvdimm@ml01.01.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 19, 2017 at 01:49:25PM -0700, Ross Zwisler wrote:
> On Thu, Jan 19, 2017 at 06:13:57PM +0800, Xiong Zhou wrote:
...snip..
> > +	ret = munmap(map, len);
> > +	if (ret < 0)
> > +		err_exit("munmap", len, argv[4]);
> 
> Small nit: you munmap() to clean up the mmap(), but you don't close fd or fd2.

Thanks Ross and Eryu reviewing!

I'll send v3 of this patch shortly.

--
Xiong
