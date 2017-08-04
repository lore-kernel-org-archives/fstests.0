Received: from mx1.redhat.com ([209.132.183.28]:50424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751286AbdHDG4Q (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 4 Aug 2017 02:56:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDA8E6147F
        for <fstests@vger.kernel.org>; Fri,  4 Aug 2017 06:56:15 +0000 (UTC)
Date: Fri, 4 Aug 2017 14:56:14 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] fstests: remove tmp files properly
Message-ID: <20170804065614.GD1991@eguan.usersys.redhat.com>
References: <20170803043304.17274-1-eguan@redhat.com>
 <20170803121030.GF62447@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170803121030.GF62447@bfoster.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 03, 2017 at 08:10:31AM -0400, Brian Foster wrote:
> On Thu, Aug 03, 2017 at 12:33:04PM +0800, Eryu Guan wrote:
> > Some tests and common helpers don't properly clean up tmp files and
> > leave them behind in /tmp dir, and these tmp files are accumulating
> > over time.
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
> > v2:
> > - fix tmp_dir usage in _mkfs_dev as well
> > 
> 
> FWIW, there are a couple tests that do 'tmp=$$' instead of 'tmp=/tmp/$$'
> as well. I'm not sure how appropriate that is. That aside:

Ah, they're generic/436 and generic/445 that I didn't notice in review.
Not a big problem but still worth fixing, perhas in another cleanup
patch along with other similar fixes (if there're any).

> 
> Reviewed-by: Brian Foster <bfoster@redhat.com>

And thanks a lot for all the reviews!

Eryu
