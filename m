Return-Path: <jtulak@redhat.com>
Date: Thu, 2 Apr 2015 10:41:34 -0400 (EDT)
From: Jan Tulak <jtulak@redhat.com>
Message-ID: <35967469.6829911.1427985694256.JavaMail.zimbra@redhat.com>
In-Reply-To: <550C6DAD.4060602@sandeen.net>
References: <550C46B2.8060407@sandeen.net> <550C4951.1030804@sandeen.net> <550C6DAD.4060602@sandeen.net>
Subject: Re: [PATCH 2/2] fstests: Add overlayfs support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



----- Original Message -----
> From: "Eric Sandeen" <sandeen@sandeen.net>
> To: fstests@vger.kernel.org
> Sent: Friday, 20 March, 2015 7:57:49 PM
> Subject: Re: [PATCH 2/2] fstests: Add overlayfs support
> 
> On 3/20/15 11:22 AM, Eric Sandeen wrote:
> > If OVERLAYFS=1 is set, then every time we mount the scratch or
> > test device, set up overlayfs directories under it, and switch
> > the directory under test to the upper directory.
> > 
> > This doesn't specifically or directly test overlayfs, it simply
> > runs the existing tests over it.  As such, a few tests fail,
> > and may be expected to fail due to overlayfs limitations and
> > caveats.  I haven't sorted through the results yet.
> > 
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> 
> Zach has almost convinced me that this is the wrong approach and/or
> not worth doing, or at least not merging.
> 
> Many of the failures are as a result of this being tacked on, and
> several tests wouldn't be expected to work at all.
> 
> So I dunno.  What do people think; it's at least interesting on the
> side, to see what falls off.
> 
> Good news is, no oopses yet! :)
> 

Well, I agree with Zach. It would be good to have overlayfs, but I think it should be a standalone FS. Overlayfs has some specific things, though. As it needs more directories for work, we can suppose lowerdir is going to be TEST_DIR/SCRATCH_DIR, but what about upperdir? And o we need to be able to explicitly set what filesystem they should be on? Your patch put it all into a single directory, but I think we should be able to test it on different devices.

So I would say we need have both, something like 

_require_test_overlay # basically what your patch do, a single step to make $TEST_DIR in overlay

and

OVERLAY_UPPER_FS="tmpfs"
OVERLAY_LOWER_FS="xfs"
_require_scratch_overlay

I think we should be able to manipulate with underlying directories directly - though this can be the case only for some specific tests that will do all the work around overlayfs manually. I don't feel to answer this question myself.

I'm afraid I'm bringing more question than answers, though. :-)

-- 
Jan Tulak
jtulak@redhat.com
