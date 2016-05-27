Received: from mx1.redhat.com ([209.132.183.28]:49344 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbcE0FqL (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 May 2016 01:46:11 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EE36800A8
	for <fstests@vger.kernel.org>; Fri, 27 May 2016 05:46:11 +0000 (UTC)
Date: Fri, 27 May 2016 13:46:09 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH v2] overlay: test memleak in copy-up error handling path
Message-ID: <20160527054609.GC2933@dhcp12-144.nay.redhat.com>
References: <1462767157-26966-1-git-send-email-xzhou@redhat.com>
 <1462847565-12108-1-git-send-email-xzhou@redhat.com>
 <20160526072426.GZ5140@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160526072426.GZ5140@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 26, 2016 at 03:24:26PM +0800, Eryu Guan wrote:
> On Tue, May 10, 2016 at 10:32:45AM +0800, Xiong Zhou wrote:
> > This memleak leads to panic when unmount the underlying fs.
> > Kernel commit ab79efab0 fixed this issue.
> > 
> > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > ---
> > 
> > Diff to v1:
> > 	set up underlying fs in $SCRATCH_DEV instead of $SCRATCH_MNT
> > 	xfs_io open test_file instead of src/writemod
> > 	use little upper dir to trigger ENOSP failure instead of kill
> > 	clean up in cleanup
> 
> Thanks for the update! And sorry for late review.. Some minor issues
> inline

Thank you very much for the tips! Sending v3.

--
Xiong
