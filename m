Received: from mga07.intel.com ([134.134.136.100]:22607 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752224AbdDKSwh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 11 Apr 2017 14:52:37 -0400
Date: Tue, 11 Apr 2017 12:52:35 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v2 3/3] DAX: mmap write readonly file
Message-ID: <20170411185235.GA32027@linux.intel.com>
References: <20170407171600.GA29489@linux.intel.com>
 <1491804353-1326-1-git-send-email-xzhou@redhat.com>
 <1491804353-1326-3-git-send-email-xzhou@redhat.com>
 <20170411114619.GK22845@eguan.usersys.redhat.com>
 <x498tn7jbep.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x498tn7jbep.fsf@segfault.boston.devel.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Eryu Guan <eguan@redhat.com>, Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 11, 2017 at 09:56:14AM -0400, Jeff Moyer wrote:
> Eryu Guan <eguan@redhat.com> writes:
> 
> > On Mon, Apr 10, 2017 at 02:05:53PM +0800, Xiong Zhou wrote:
> >> Regression case that one can write to read-only
> >> file in a DAX mountpoint.
> >> 
> >> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> >> ---
> >> 
> >> v2:
> >>   compile test programme manually in this test because default
> >> cc option -O2 prevents this issue reproduction;
> >
> > Hmm, this looks.. ugly to me :) Better to find out the exact reason that
> > prevents the bug from reproducing and update the c program accordingly.
> 
> The compiler probably optimizes this bit out:
> 
> +	/* fault in the page */
> +	foo = *buf;

Yep, verified this with objdump.  You can prevent the compiler from
optimizing out this bit by making 'foo' volatile.  Patch at the end of this
mail, and I also verified that this works with objdump.

In my setup at least this test passes both with v4.10.0 (which does not
contain the fix we are testing for, and should fail) and with v4.10.3 (which
does contain the kernel fix, and should pass).

So, I think the test still needs a little love. :)

---

diff --git a/src/t_mmap_write_ro.c b/src/t_mmap_write_ro.c
index cce6e0d..3960815 100644
--- a/src/t_mmap_write_ro.c
+++ b/src/t_mmap_write_ro.c
@@ -11,7 +11,8 @@ int
 main(int argc, char **argv)
 {
        int fd, pfd, ret;
-       char *buf, foo;
+       char *buf;
+       volatile char foo;
        int pagesize = getpagesize();
 
        if (argc < 2) {
