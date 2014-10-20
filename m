Return-Path: <david@fromorbit.com>
Date: Tue, 21 Oct 2014 10:08:40 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Can't build RPM of xfstests
Message-ID: <20141020230840.GP17506@dastard>
References: <648473255763364B961A02AC3BE1060D03C7940C13@MX19A.corp.emc.com>
 <20141020014750.GL7169@dastard>
 <54448313.7040602@sandeen.net>
 <30CA1845-C213-49EA-8809-F1E7A98AE7F9@gmail.com>
 <54451427.9060306@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54451427.9060306@sandeen.net>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, "Kaul, Yaniv" <Yaniv.Kaul@emc.com>, esandeen@redhat.com, fstests@vger.kernel.org, "xfs@oss.sgi.com" <xfs@oss.sgi.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 20, 2014 at 08:54:47AM -0500, Eric Sandeen wrote:
> On 10/20/14 6:55 AM, Greg Freemyer wrote:
> 
> > Opensuse is building rpms of 1.1.1 so the build infrastructure isn't
> > too badly broken.  I don't know if they are following FHS, but I
> > doubt they use /opt.
> 
> The build works fine, it's the "Makepkgs" that I think is a bit odd,
> at least for RPM packaging.

It's just odd, regardless of what it is packaging.

> Also, if we really want to encourage packaging, we should probably start
> sticking official version numbers on it.  "1.1.1" was tagged in Dec 2012,
> and there have been no "releases" since.

There are more recent tags than that. There were some linux-v3.[6-8]
tags added when kernels v3.[6-8] we released. Those tags are
basically meaningless from a release perspective, though.

As it is, for the purpose of the discussion I'll argue that we don't
need official release versions or tarballs and that anyone who needs
packages for xfstests is Doing it Wrong(tm).  Realistically, the
current head commit ID works just fine as a release version and so I
don't think we don't need tarballs or released versions of xfstests.
xfstests is developer rather than end user focussed and so it is
assumed that you understand git if you have a need for running
xfstests...

i.e. this works as a test machine deployment method and is easily
scriptable and deployable on test machines:

# <install prereq packages>
# cd /opt
# git clone <xfstests git repo on build server>
# cd xfstests
# make
# <grab config file from build server>
# ./check -g auto

And with that, there is no need for packaging....

That said, xfstests needs to be flexible so it can operate in all
sorts of different environments, so how I do things really doesn't
matter that much. If people really need xfstests to build RPMs so
they can deploy RPMs, then like I said I'll take patches to make
that work...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
