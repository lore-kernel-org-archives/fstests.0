Received: from mx1.redhat.com ([209.132.183.28]:59776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbdDLCxC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 11 Apr 2017 22:53:02 -0400
Date: Wed, 12 Apr 2017 10:52:59 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH v2 3/3] DAX: mmap write readonly file
Message-ID: <20170412025259.6duxlnabxem23mlc@XZHOUW.usersys.redhat.com>
References: <20170407171600.GA29489@linux.intel.com>
 <1491804353-1326-1-git-send-email-xzhou@redhat.com>
 <1491804353-1326-3-git-send-email-xzhou@redhat.com>
 <20170411114619.GK22845@eguan.usersys.redhat.com>
 <x498tn7jbep.fsf@segfault.boston.devel.redhat.com>
 <20170411185235.GA32027@linux.intel.com>
 <20170411224542.GA12746@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411224542.GA12746@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, Eryu Guan <eguan@redhat.com>, Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org, dan.j.williams@intel.com
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 11, 2017 at 04:45:42PM -0600, Ross Zwisler wrote:
> On Tue, Apr 11, 2017 at 12:52:35PM -0600, Ross Zwisler wrote:
> > On Tue, Apr 11, 2017 at 09:56:14AM -0400, Jeff Moyer wrote:
> > > Eryu Guan <eguan@redhat.com> writes:
> > > 
> > > > On Mon, Apr 10, 2017 at 02:05:53PM +0800, Xiong Zhou wrote:
> > > >> Regression case that one can write to read-only
> > > >> file in a DAX mountpoint.
> > > >> 
> > > >> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > > >> ---
> > > >> 
> > > >> v2:
> > > >>   compile test programme manually in this test because default
> > > >> cc option -O2 prevents this issue reproduction;
> > > >
> > > > Hmm, this looks.. ugly to me :) Better to find out the exact reason that
> > > > prevents the bug from reproducing and update the c program accordingly.
> > > 
> > > The compiler probably optimizes this bit out:
> > > 
> > > +	/* fault in the page */
> > > +	foo = *buf;
> > 
> > Yep, verified this with objdump.  You can prevent the compiler from
> > optimizing out this bit by making 'foo' volatile.  Patch at the end of this
> > mail, and I also verified that this works with objdump.
> > 
> > In my setup at least this test passes both with v4.10.0 (which does not
> > contain the fix we are testing for, and should fail) and with v4.10.3 (which
> > does contain the kernel fix, and should pass).
> > 
> > So, I think the test still needs a little love. :)
> 
> Umm...never mind, my testing was broken. I was accidentally testing with the
> upstream generic/422.  :(  Will retest tomorrow.

Thank you very much Ross, your patch is working fine.
