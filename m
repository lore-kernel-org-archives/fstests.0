Date: Fri, 16 Dec 2016 12:11:09 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic: make sure file size resource limit is honored
 by fs
Message-ID: <20161216041109.GK28577@eguan.usersys.redhat.com>
References: <20161203062600.25471-1-eguan@redhat.com>
 <20161215173635.GB5355@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161215173635.GB5355@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 15, 2016 at 09:36:35AM -0800, Darrick J. Wong wrote:
> On Sat, Dec 03, 2016 at 02:26:00PM +0800, Eryu Guan wrote:
> > If a file size limitation is set, underlying filesystem should not
> > break the limit and exceed the max file size.
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
[snip]
> > +
> > +# set max file size to 1G (in block number of 1k blocks), so it should be big
> > +# enough to let test run without bringing any trouble to test harness
> > +ulimit -f $((1024 * 1024))
> > +
> > +# exercise file size limit boundaries
> > +do_truncate $((1024 * 1024 * 1024 - 1))	$TEST_DIR/$seq.$$-1
> > +do_truncate $((1024 * 1024 * 1024))	$TEST_DIR/$seq.$$
> > +do_truncate $((1024 * 1024 * 1024 + 1))	$TEST_DIR/$seq.$$+1 2>&1 | \
> > +	grep -o "File size limit exceeded"
> 
> So I tried this out in a shell and was very surprised to get a core dump
> in addition to the 'File size limit exceeded' message.  Other than that
> little surprise it looks ok to me....

Ah, default action to SIGXFSZ is coredump.. and I didn't see a coredump
because my shell doesn't allow it by default

# ulimit -a
core file size          (blocks, -c) 0
...

Perhaps I can add a "ulimit -c 0" to avoid coredump & leaving a core
file in your fstests dir.

> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks for the review!

Eryu
