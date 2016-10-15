Received: from bombadil.infradead.org ([198.137.202.9]:35876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753071AbcJORFH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 15 Oct 2016 13:05:07 -0400
Date: Sat, 15 Oct 2016 10:04:41 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] fstests: run xfs_io as multi threaded process
Message-ID: <20161015170441.GA23090@infradead.org>
References: <1476477810-17478-1-git-send-email-amir73il@gmail.com>
 <1476477810-17478-2-git-send-email-amir73il@gmail.com>
 <20161015091126.GA9631@infradead.org>
 <CAOQ4uxhunx5QtWYoSwWrq_FR3hso-GPekKRjCTC_Epc8g3Ld0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhunx5QtWYoSwWrq_FR3hso-GPekKRjCTC_Epc8g3Ld0A@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, eguan@redhat.com, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sat, Oct 15, 2016 at 06:13:29PM +0300, Amir Goldstein wrote:
> I can't say that I have made a statistics analysis of the affect of the flag
> on xfstests runtime, but for the -g quick group on small SSD partition,
> I did not observe any noticable difference in runtime.
> 
> I will try to run some micro benchmarks or look for specific tests that
> do many file opens and little io, to get more performance numbers.

Yes, if there is no effect at least that's not a problem.  I'd just want
confirmation for that.  In the end we probably don't use xfs_io heavily
parallel on the same fd a lot.
