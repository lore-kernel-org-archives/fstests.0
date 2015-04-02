Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48249 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753585AbbDBNrR (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 2 Apr 2015 09:47:17 -0400
Date: Thu, 2 Apr 2015 15:47:14 +0200 (CEST)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: RE: [PATCH] Fix caller's argument for _require_command()
In-Reply-To: <018301d06b5b$43d78c60$cb86a520$@cn.fujitsu.com>
Message-ID: <alpine.LFD.2.00.1504021545520.3307@localhost.localdomain>
References: <9a1c40cb9eceb72543647cb4209269bc4aba86f0.1427706679.git.zhaolei@cn.fujitsu.com> <alpine.LFD.2.00.1503301522190.8076@localhost.localdomain> <018301d06b5b$43d78c60$cb86a520$@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-557811732-1427982436=:3307"
Sender: fstests-owner@vger.kernel.org
To: Zhao Lei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-557811732-1427982436=:3307
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 31 Mar 2015, Zhao Lei wrote:

> Date: Tue, 31 Mar 2015 10:34:51 +0800
> From: Zhao Lei <zhaolei@cn.fujitsu.com>
> To: 'Lukáš Czerner' <lczerner@redhat.com>
> Cc: fstests@vger.kernel.org
> Subject: RE: [PATCH] Fix caller's argument for _require_command()
> 
> Hi, Czerner
> 
> Thanks for review.
> 
> > -----Original Message-----
> > From: Lukáš Czerner [mailto:lczerner@redhat.com]
> > Sent: Monday, March 30, 2015 9:25 PM
> > To: Zhaolei
> > Cc: fstests@vger.kernel.org
> > Subject: Re: [PATCH] Fix caller's argument for _require_command()
> > 
> > On Mon, 30 Mar 2015, Zhaolei wrote:
> > 
> > > Date: Mon, 30 Mar 2015 17:11:27 +0800
> > > From: Zhaolei <zhaolei@cn.fujitsu.com>
> > > To: fstests@vger.kernel.org
> > > Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
> > > Subject: [PATCH] Fix caller's argument for _require_command()
> > >
> > > From: Zhao Lei <zhaolei@cn.fujitsu.com>
> > >
> > > _require_command() only accept 2 arguments but some caller misused
> > > this function, and caused "not_run" after we limit calling way.
> > >
> > > This patch fixed above caller.
> > >
> > > Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
> > > ---
> > >  common/defrag | 13 +++++++++----
> > >  tests/xfs/094 |  2 +-
> > >  tests/xfs/103 |  2 +-
> > >  tests/xfs/195 |  2 +-
> > >  4 files changed, 12 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/common/defrag b/common/defrag index f923dc0..b44ef98
> > > 100644
> > > --- a/common/defrag
> > > +++ b/common/defrag
> > > @@ -22,22 +22,27 @@
> > >
> > >  _require_defrag()
> > >  {
> > > +    local defrag_cmd
> > > +
> > >      case "$FSTYP" in
> > >      xfs)
> > > -        DEFRAG_PROG="$XFS_FSR_PROG"
> > > +        defrag_cmd="$XFS_FSR_PROG"
> > > +        DEFRAG_PROG="$defrag_cmd"
> > >  	;;
> > >      ext4|ext4dev)
> > > -        DEFRAG_PROG="$E4DEFRAG_PROG"
> > > +        defrag_cmd="$E4DEFRAG_PROG"
> > > +        DEFRAG_PROG="$defrag_cmd"
> > >  	;;
> > >      btrfs)
> > > -	DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
> > > +        defrag_cmd="$BTRFS_UTIL_PROG"
> > > +        DEFRAG_PROG="defrag_cmd filesystem defragment"
> > >  	;;
> > >      *)
> > >          _notrun "defragmentation not supported for fstype \"$FSTYP\""
> > >  	;;
> > >      esac
> > >
> > > -    _require_command "$DEFRAG_PROG" defragment
> > > +    _require_command "$defrag_cmd" defragment
> > 
> > Hi,
> > 
> > what's the point of this change ?
> > 
> 
> "$DEFRAG_PROG" include program and argument,
> and can not passed test of:
> [[ -x "$DEFRAG_PROG" ]]
> in _require_command().
> 
> > >      _require_xfs_io_command "fiemap"
> > >  }
> > >
> > > diff --git a/tests/xfs/094 b/tests/xfs/094 index cee42d6..5c6e98d
> > > 100755
> > > --- a/tests/xfs/094
> > > +++ b/tests/xfs/094
> > > @@ -46,7 +46,7 @@ _supported_fs xfs
> > >  _supported_os IRIX Linux
> > >  _require_realtime
> > >  _require_scratch
> > > -_require_command "$XFS_IO_PROG" xfs_io
> > > +[ -n "$XFS_IO_PROG" ] || _notrun "xfs_io executable not found"
> > 
> > Why ? Do not we get the same result from
> > 
> > _require_command "$XFS_IO_PROG" xfs_io
> > 
> > anyway if the $XFS_IO_PROG isn't set ?
> > 
> In some case, "$XFS_IO_PROG" include both program and argument,
> and cause wrong result in _require_command().

It should not include any arguments. It's probably -F argument you
have in mind, but that's deprecated and is not needed anymore. So if
we have some places where we add those it needs to be fixed there.

Thanks!
-Lukas

> 
> Thanks
> Zhaolei
> 
> > -Lukas
> > 
> > >
> > >  _filter_realtime_flag()
> > >  {
> > > diff --git a/tests/xfs/103 b/tests/xfs/103 index cbe884f..d80dbf2
> > > 100755
> > > --- a/tests/xfs/103
> > > +++ b/tests/xfs/103
> > > @@ -66,7 +66,7 @@ _filter_noymlinks_flag()  # real QA test starts here
> > > _supported_os Linux IRIX  _supported_fs xfs -_require_command
> > > "$XFS_IO_PROG" xfs_io
> > > +[ -n "$XFS_IO_PROG" ] || _notrun "xfs_io executable not found"
> > >  _require_scratch
> > >
> > >  _create_scratch
> > > diff --git a/tests/xfs/195 b/tests/xfs/195 index 21fcb00..075022d
> > > 100755
> > > --- a/tests/xfs/195
> > > +++ b/tests/xfs/195
> > > @@ -65,7 +65,7 @@ _supported_os Linux
> > >
> > >  _require_test
> > >  _require_user
> > > -_require_command "$XFSDUMP_PROG" xfsdump
> > > +[ "$XFSDUMP_PROG" = "" ] && _notrun "xfsdump not found"
> > >
> > >  echo "Preparing subtree"
> > >  mkdir $TEST_DIR/d
> > >
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--8323328-557811732-1427982436=:3307--
