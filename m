Date: Mon, 20 Mar 2017 13:24:57 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v5 0/5] Add copy_file_range() tests
Message-ID: <20170320052457.GH14226@eguan.usersys.redhat.com>
References: <20170317195233.4042-1-Anna.Schumaker@Netapp.com>
 <20170317220246.GA12585@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170317220246.GA12585@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>, Anna Schumaker <Anna.Schumaker@Netapp.com>
Cc: fstests@vger.kernel.org, linux-nfs@vger.kernel.org, hch@infradead.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 17, 2017 at 03:02:46PM -0700, Darrick J. Wong wrote:
> On Fri, Mar 17, 2017 at 03:52:28PM -0400, Anna Schumaker wrote:
> > These tests exercise the copy_file_range() system call, and check copying
> > data to both a new file and overwriting data inside an existing file.
> > 
> > Sorry it took so long to get this version out.  I forgot about these patches
> > after the last submission.
> 
> Hooray, tests finally!
> 
> I had to bump the numbers up due to conflicts (it's usually best to pick
> a really high number and let Eryu mvtest them to their real numbers),
> but these mostly look ok.

Usually the test numbers are not a problem, as long as the patchset is
based on latest master and there's no test number conflicts :)

Overall the tests look fine to me too.

> 
> However, I do see that something isn't triggering an EINVAL return code:

Same results here, tested with xfs/ext4/btrfs on 4.11-rc2 kernel.

And another nitpick is the year in copyright, s/2016/2017/ ?

Thanks,
Eryu
