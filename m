Date: Fri, 5 Aug 2016 16:14:21 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic: test accurate shared extent reporting
Message-ID: <20160805081421.GX27776@eguan.usersys.redhat.com>
References: <20160805072147.GG25565@birch.djwong.org>
 <20160805074607.GW27776@eguan.usersys.redhat.com>
 <20160805080212.GH25565@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160805080212.GH25565@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: dedekind1@gmail.com, mfasheh@suse.de, fstests@vger.kernel.org, xfs@oss.sgi.com, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 05, 2016 at 01:02:12AM -0700, Darrick J. Wong wrote:
> On Fri, Aug 05, 2016 at 03:46:07PM +0800, Eryu Guan wrote:
> > On Fri, Aug 05, 2016 at 12:21:47AM -0700, Darrick J. Wong wrote:

> > > +_count_holes $testdir/file2
> > > +echo "file1 shared extents"
> > > +$XFS_IO_PROG -c 'fiemap -v' $testdir/file1 | awk '{print $5}' | grep '0x.*[2367aAbBfF]...$' -c
> > 
> > Missing a command at the end?
> 
> Nope, it echoes the number of shared extents (that's what that awk and grep
> globule does), which /should/ be exactly 2.
> 
> (Unless I'm missing something?)

Ah, thanks! I saw "-c" at the end and thought it was part of xfs_io
command without looking at it carefully.

Thanks,
Eryu
