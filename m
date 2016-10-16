Received: from bombadil.infradead.org ([198.137.202.9]:42648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754441AbcJPHPB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Oct 2016 03:15:01 -0400
Date: Sun, 16 Oct 2016 00:14:58 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] fstests: run xfs_io as multi threaded process
Message-ID: <20161016071458.GA17675@infradead.org>
References: <1476477810-17478-1-git-send-email-amir73il@gmail.com>
 <1476477810-17478-2-git-send-email-amir73il@gmail.com>
 <20161015091126.GA9631@infradead.org>
 <CAOQ4uxhunx5QtWYoSwWrq_FR3hso-GPekKRjCTC_Epc8g3Ld0A@mail.gmail.com>
 <20161015170441.GA23090@infradead.org>
 <CAOQ4uxjumg_VO3LV7rgtHbO=yTmxUp6KdpmrCh8ASEjG6tG3XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjumg_VO3LV7rgtHbO=yTmxUp6KdpmrCh8ASEjG6tG3XA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, eguan@redhat.com, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sat, Oct 15, 2016 at 11:59:22PM +0300, Amir Goldstein wrote:
> So far so good, but then I looked closer at its sister test
> generic/132, which is
> an even more CPU intensive test, also of many small reads and writes
> from few xfs_io runs.
> This is not a 'quick' group test.
> Here the runtime difference was significant 17sec without -M and 20sec
> with -M flag.
> 
> So without looking much closer into other non quick tests, I think
> that perhaps the
> best value option is to turn on -M flag for all the quick tests.
> 
> What do you think?

Sounds like a good idea, now how do we find out in the xfs_io
helper if it's a quick test?
