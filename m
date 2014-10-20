Return-Path: <david@fromorbit.com>
Date: Tue, 21 Oct 2014 10:57:19 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Can't build RPM of xfstests
Message-ID: <20141020235719.GQ17506@dastard>
References: <648473255763364B961A02AC3BE1060D03C7940C13@MX19A.corp.emc.com>
 <20141020014750.GL7169@dastard>
 <54448313.7040602@sandeen.net>
 <30CA1845-C213-49EA-8809-F1E7A98AE7F9@gmail.com>
 <54451427.9060306@sandeen.net>
 <20141020230840.GP17506@dastard>
 <CAGpXXZJ1A=Zq74KGveo5D=uAr6GTdA_1=DqXYwm2x9rG8ggDBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGpXXZJ1A=Zq74KGveo5D=uAr6GTdA_1=DqXYwm2x9rG8ggDBA@mail.gmail.com>
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, "Kaul, Yaniv" <Yaniv.Kaul@emc.com>, Eric Sandeen <esandeen@redhat.com>, fstests@vger.kernel.org, "xfs@oss.sgi.com" <xfs@oss.sgi.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 20, 2014 at 07:31:50PM -0400, Greg Freemyer wrote:
> --
> Greg Freemyer
> 
> 
> On Mon, Oct 20, 2014 at 7:08 PM, Dave Chinner <david@fromorbit.com> wrote:
> > On Mon, Oct 20, 2014 at 08:54:47AM -0500, Eric Sandeen wrote:
> >> On 10/20/14 6:55 AM, Greg Freemyer wrote:
> >>
> >> > Opensuse is building rpms of 1.1.1 so the build infrastructure isn't
> >> > too badly broken.  I don't know if they are following FHS, but I
> >> > doubt they use /opt.
> >>
> >> The build works fine, it's the "Makepkgs" that I think is a bit odd,
> >> at least for RPM packaging.
> >
> > It's just odd, regardless of what it is packaging.
> >
> >> Also, if we really want to encourage packaging, we should probably start
> >> sticking official version numbers on it.  "1.1.1" was tagged in Dec 2012,
> >> and there have been no "releases" since.
> >
> > There are more recent tags than that. There were some linux-v3.[6-8]
> > tags added when kernels v3.[6-8] we released. Those tags are
> > basically meaningless from a release perspective, though.
> >
> > As it is, for the purpose of the discussion I'll argue that we don't
> > need official release versions or tarballs and that anyone who needs
> > packages for xfstests is Doing it Wrong(tm).
> 
> A potential use case with openSUSE and why I "think" they packaged it
> is to include a subset of xfstest in there automated testing.

Sure - i'm just pointing out that you don't need RPM to do that -
git it just as good for deploying automated testing infrastructure
;)

....

> Notice for example that ext4 is a testsuite selection in the testsuite
> pull down.  I assume that testsuite uses xfstests to exercise ext4
> prior to an automated release of factory.
> 
> The 2014-10-17 build of a couple days ago is an example of a build
> that failed the ext4 testsuite:
> https://openqa.opensuse.org/tests/27955

That doesn't appear to anything to do with xfstests. It appears to
be a "can we install opensuse" installer test that happens to be run
on ext4. i.e. it's really product level testing (i.e. whether the
opensuse build worked) not whether the filesystem works as it's
supposed to.

> I don't see automated tests for xfs or btrfs which is a surprise since
> both of them are default filesystem choices for factory.  (btrfs is
> the default choice for / and xfs is the default for /home).

Seeing as it's not actually doing filesystem level testing, it
probably doesn't matter at all.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
