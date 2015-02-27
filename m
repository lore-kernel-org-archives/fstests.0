Return-Path: <lczerner@redhat.com>
Date: Fri, 27 Feb 2015 12:03:46 +0100 (CET)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] generic/065: f2fs serves 64KB size with
 zero data
In-Reply-To: <CAL3q7H7Tb4Jk1Unf3ZxMFG509-KieLpPcexgfQiwEaSYh7Bm=A@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1502271202590.2188@localhost.localdomain>
References: <1425000227-69601-1-git-send-email-jaegeuk@kernel.org> <54EFDA67.1060606@sandeen.net> <alpine.LFD.2.00.1502271049050.2188@localhost.localdomain> <CAL3q7H7Tb4Jk1Unf3ZxMFG509-KieLpPcexgfQiwEaSYh7Bm=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1159346363-1425035029=:2188"
To: Filipe David Manana <fdmanana@gmail.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, Filipe Manana <fdmanana@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1159346363-1425035029=:2188
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 27 Feb 2015, Filipe David Manana wrote:

> Date: Fri, 27 Feb 2015 10:31:02 +0000
> From: Filipe David Manana <fdmanana@gmail.com>
> To: Lukáš Czerner <lczerner@redhat.com>
> Cc: Eric Sandeen <sandeen@sandeen.net>, Filipe Manana <fdmanana@suse.com>,
>     Jaegeuk Kim <jaegeuk@kernel.org>, Dave Chinner <david@fromorbit.com>,
>     fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 1/2] generic/065: f2fs serves 64KB size with
>     zero data
> 
> On Fri, Feb 27, 2015 at 9:54 AM, Lukáš Czerner <lczerner@redhat.com> wrote:
> > On Thu, 26 Feb 2015, Eric Sandeen wrote:
> >
> >> Date: Thu, 26 Feb 2015 20:45:59 -0600
> >> From: Eric Sandeen <sandeen@sandeen.net>
> >> To: Jaegeuk Kim <jaegeuk@kernel.org>, Dave Chinner <david@fromorbit.com>
> >> Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
> >>     Filipe Manana <fdmanana@suse.com>
> >> Subject: Re: [PATCH 1/2] generic/065: f2fs serves 64KB size with zero data
> >>
> >> On 2/26/15 7:23 PM, Jaegeuk Kim wrote:
> >> > The f2fs provides 64KB size with 0 data after fsync was done to directory file.
> >> >
> >> > Cc: Filipe Manana <fdmanana@suse.com>
> >> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >> > ---
> >> >  tests/generic/065 | 4 ++++
> >> >  1 file changed, 4 insertions(+)
> >> >
> >> > diff --git a/tests/generic/065 b/tests/generic/065
> >> > index b5a296d..3d2b437 100755
> >> > --- a/tests/generic/065
> >> > +++ b/tests/generic/065
> >> > @@ -139,6 +139,10 @@ ext3)
> >> >     # a 64Kb file, with all bytes having the value 0xff
> >> >     [ $hello_digest == "ecb99e6ffea7be1e5419350f725da86b" ] && digest_ok=yes
> >> >     ;;
> >> > +f2fs)
> >> > +   # a 64Kb file, with all bytes having the value 0
> >> > +   [ $hello_digest == "fcd6bcb56c1689fcef28b57c22475bad" ] && digest_ok=yes
> >> > +   ;;
> >>
> >> whoa... I will admit to having poorly reviewed this test.  Given that this file was
> >> never fsynced, I don't think the test should be looking at file contents *at all*
> >> I'll do an ex post facto review, I think, and really, I think all of the above should
> >> just be removed from the test.  Without fsync, we don't know what's in the file.
> >> (ext3 could be mounted with writeback mode, for example).
> >
> > wow :D
> >
> > Different mdsums for different file systems and
> >
> > "file 'hello' has expected size and content"
> >
> > You have to have some fun from time to time ;)
> 
> My bad.
> 
> >
> > I can not tell whether the content of the file is important, or
> > whether the explicit fsync on the file defeats the purpose of the
> > test, but the easier would be to just fsync the file and then print
> > out md5sum since it should be always the same no matter what file
> > system you use.
> 
> I added this check because while doing the btrfs fix I came into a
> scenario where the file's metadata was inconsistent (i.e. the dir
> fsync would cause metadata inconsistency for non-empty child files).
> This was detected by fsck alone, but then I added this check anyway.
> 
> >
> > Or we can just not test the content of the file at all. But
> > regardless of the decision we do not need this patch.
> >
> > Felipe what would be the best solution ?
> 
> (Felipe -> Filipe :))

Ah sorry about that Filipe :)

> 
> I think explicitly fsyncing the file, after fsyncing the directory,
> and then check its md5sum/content is a good thing to test. Like this
> we know there's only one expected result for all filesystems. I'll
> send a patch for that soon.

Great, thanks!
-Lukas

> 
> thanks
> 
> >
> > Thanks!
> >
> >>
> >> -Eric
> >>
> >> >  *)
> >> >     # an empty file
> >> >     [ $hello_digest == "d41d8cd98f00b204e9800998ecf8427e" ] && digest_ok=yes
> >> >
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe fstests" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> > ------------------------------------------------------------------------------
> > Dive into the World of Parallel Programming The Go Parallel Website, sponsored
> > by Intel and developed in partnership with Slashdot Media, is your hub for all
> > things parallel software development, from weekly thought leadership blogs to
> > news, videos, case studies, tutorials and more. Take a look and join the
> > conversation now. http://goparallel.sourceforge.net/
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> 
> 
--8323328-1159346363-1425035029=:2188--
