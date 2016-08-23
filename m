Date: Tue, 23 Aug 2016 23:23:02 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [GIT PULL] fstests: updates on 2016-08-20
Message-ID: <20160823152302.GN27776@eguan.usersys.redhat.com>
References: <201608201444.u7KEi22g015351@int-mx14.intmail.prod.int.phx2.redhat.com>
 <20160823065447.GY19025@dastard>
 <20160823071608.GL27776@eguan.usersys.redhat.com>
 <20160823151042.GC8265@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160823151042.GC8265@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 23, 2016 at 08:10:43AM -0700, Darrick J. Wong wrote:
> > > Hi Eryu,
> > > 
> > > I just pulled this all in and got an unexpected surprise - this new
> > > test killed all of my test machines. From your description ("normal
> > > update") I didn't expect to see something like this occur - I pulled
> > > it, confirmed commits match, then pushed it to my test machines
> > > and started a test cycle. I expected to see it complete without any
> > > significant problems.
> > 
> > I saw only mount failures from this case in my testings (4.8-rc2
> > kernel), I didn't expect any crash either.
> 
> Is this in reference generic/323?  For whatever reason I get a flood
> of overlapping kernel stack smeared all over ttyS0.

If you're using my github tree, it should be generic/375. Dave hasn't
pushed this update to upstream tree yet, so you shouldn't see it if
you're using upstream tree.

Thanks,
Eryu
