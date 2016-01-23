Received: from mail-io0-f196.google.com ([209.85.223.196]:35365 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbcAWWAG (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sat, 23 Jan 2016 17:00:06 -0500
Received: by mail-io0-f196.google.com with SMTP id 77so9924729ioc.2
        for <fstests@vger.kernel.org>; Sat, 23 Jan 2016 14:00:05 -0800 (PST)
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <20160123205211.GB26408@birch.djwong.org>
References: <20160123003648.2666.37062.stgit@birch.djwong.org>
	<20160123003654.2666.17112.stgit@birch.djwong.org>
	<CAL3q7H7YwWgN0siD57CHd1od-drVxWuH_HDfmrVPB02O9XBNFw@mail.gmail.com>
	<20160123205211.GB26408@birch.djwong.org>
Date: Sat, 23 Jan 2016 22:00:05 +0000
Message-ID: <CAL3q7H4S3P++010R+wNtFcJDtmNuiik5C72nxJFRdc4RAtHp_A@mail.gmail.com>
Subject: Re: [PATCH 2/5] reflink: fix off-by-one errors when iterating file
 blocks in a loop
From: Filipe Manana <fdmanana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, "xfs@oss.sgi.com" <xfs@oss.sgi.com>
List-ID: <fstests@vger.kernel.org>

On Sat, Jan 23, 2016 at 8:52 PM, Darrick J. Wong
<darrick.wong@oracle.com> wrote:
> On Sat, Jan 23, 2016 at 11:32:27AM +0000, Filipe Manana wrote:
>> On Sat, Jan 23, 2016 at 12:36 AM, Darrick J. Wong
>> <darrick.wong@oracle.com> wrote:
>> > When we're iterating file blocks in a loop (via seq), we have to
>> > end at $nr-1, not $nr.
>> >
>> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
>> > ---
>> >  tests/generic/183 |    2 +-
>> >  tests/generic/185 |    2 +-
>> >  tests/generic/186 |    2 +-
>> >  tests/generic/187 |    2 +-
>> >  tests/generic/194 |    2 +-
>> >  tests/generic/195 |    2 +-
>> >  tests/xfs/129     |    6 +++---
>> >  tests/xfs/140     |    2 +-
>> >  8 files changed, 10 insertions(+), 10 deletions(-)
>> >
>> >
>> > diff --git a/tests/generic/183 b/tests/generic/183
>> > index 5c65e9a..2cf9ce4 100755
>> > --- a/tests/generic/183
>> > +++ b/tests/generic/183
>> > @@ -69,7 +69,7 @@ seq 0 2 $((NR-1)) | while read f; do
>> >         _reflink_range "$TESTDIR/file1" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
>> >         _pwrite_byte 0x61 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
>> >  done
>> > -seq 1 2 $NR | while read f; do
>> > +seq 1 2 $((NR-1)) | while read f; do
>>
>> Just curious (and no bike shedding intended), why not make the loop in
>> a much more simple and common way such as:
>>
>> for ((i = 1; i < $NR; i += 2)); do
>> ...
>> done
>
> Not that it matters here, but that's a bashism, isn't it?

Yep, but all tests and scripts (./check, common/rc, etc) start with a
shebang referring to bash.

>
>> or  for i in `seq 1 2 $((NR - 1))`; do .... done
>
> <shrug> No particular reason. :)
>
> I suppose if NR is large then "seq | while read" avoids spraying a large number
> of arguments into the command interpreter, though that clearly isn't the case
> here.

Right.
Thanks.

>
> --D
>
>>
>>
>>
>> >         _reflink_range "$TESTDIR/file2" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
>> >         _pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
>> >  done
>> > diff --git a/tests/generic/185 b/tests/generic/185
>> > index 384c9aa..55c54ac 100755
>> > --- a/tests/generic/185
>> > +++ b/tests/generic/185
>> > @@ -69,7 +69,7 @@ seq 0 2 $((NR-1)) | while read f; do
>> >         _reflink_range "$TESTDIR/file1" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
>> >         _pwrite_byte 0x61 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
>> >  done
>> > -seq 1 2 $NR | while read f; do
>> > +seq 1 2 $((NR-1)) | while read f; do
>> >         _reflink_range "$TESTDIR/file2" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
>> >         _pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
>> >  done
>> > diff --git a/tests/generic/186 b/tests/generic/186
>> > index d84166d..f1c0e6b 100755
>> > --- a/tests/generic/186
>> > +++ b/tests/generic/186
>> > @@ -112,7 +112,7 @@ seq 0 2 $((NR-1)) | while read f; do
>> >         _reflink_range "$TESTDIR/file1" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
>> >         _pwrite_byte 0x61 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
>> >  done
>> > -seq 1 2 $NR | while read f; do
>> > +seq 1 2 $((NR-1)) | while read f; do
>> >         _reflink_range "$TESTDIR/file2" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
>> >         _pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
>> >  done
>> > diff --git a/tests/generic/187 b/tests/generic/187
>> > index c85a0a9..ce35ec0 100755
>> > --- a/tests/generic/187
>> > +++ b/tests/generic/187
>> > @@ -112,7 +112,7 @@ seq 0 2 $((NR-1)) | while read f; do
>> >         _reflink_range "$TESTDIR/file1" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
>> >         _pwrite_byte 0x61 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
>> >  done
>> > -seq 1 2 $NR | while read f; do
>> > +seq 1 2 $((NR-1)) | while read f; do
>> >         _reflink_range "$TESTDIR/file2" $((BLKSZ * f)) "$TESTDIR/file3" $((BLKSZ * f)) $BLKSZ >> "$seqres.full"
>> >         _pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
>> >  done
>> > diff --git a/tests/generic/194 b/tests/generic/194
>> > index a441aee..b88297e 100755
>> > --- a/tests/generic/194
>> > +++ b/tests/generic/194
>> > @@ -79,7 +79,7 @@ md5sum "$TESTDIR/file3" | _filter_scratch
>> >  md5sum "$TESTDIR/file3.chk" | _filter_scratch
>> >
>> >  echo "directio CoW across the transition"
>> > -seq 1 2 $NR | while read f; do
>> > +seq 1 2 $((NR-1)) | while read f; do
>> >         _pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3" >> "$seqres.full"
>> >         _pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
>> >  done
>> > diff --git a/tests/generic/195 b/tests/generic/195
>> > index 83e7b23..464a4d4 100755
>> > --- a/tests/generic/195
>> > +++ b/tests/generic/195
>> > @@ -79,7 +79,7 @@ md5sum "$TESTDIR/file3" | _filter_scratch
>> >  md5sum "$TESTDIR/file3.chk" | _filter_scratch
>> >
>> >  echo "CoW across the transition"
>> > -seq 1 2 $NR | while read f; do
>> > +seq 1 2 $((NR-1)) | while read f; do
>> >         _pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3" >> "$seqres.full"
>> >         _pwrite_byte 0x62 $((BLKSZ * f)) $BLKSZ "$TESTDIR/file3.chk" >> "$seqres.full"
>> >  done
>> > diff --git a/tests/xfs/129 b/tests/xfs/129
>> > index c8c47a2..3b7c59c 100755
>> > --- a/tests/xfs/129
>> > +++ b/tests/xfs/129
>> > @@ -65,9 +65,9 @@ NR_BLKS=$((4 * BLKSZ / 12))
>> >  _pwrite_byte 0x61 0 $((BLKSZ * NR_BLKS)) "$TESTDIR/file1" >> "$seqres.full"
>> >
>> >  echo "Reflink every other block"
>> > -seq 1 $((NR_BLKS / 2)) | while read nr; do
>> > -       _reflink_range  "$TESTDIR/file1" $((nr * 2 * BLKSZ)) \
>> > -                       "$TESTDIR/file2" $((nr * 2 * BLKSZ)) $BLKSZ >> "$seqres.full"
>> > +seq 1 2 $((NR_BLKS - 1)) | while read nr; do
>> > +       _reflink_range  "$TESTDIR/file1" $((nr * BLKSZ)) \
>> > +                       "$TESTDIR/file2" $((nr * BLKSZ)) $BLKSZ >> "$seqres.full"
>> >  done
>> >
>> >  echo "Create metadump file"
>> > diff --git a/tests/xfs/140 b/tests/xfs/140
>> > index e20cd3f..45be9f4 100644
>> > --- a/tests/xfs/140
>> > +++ b/tests/xfs/140
>> > @@ -70,7 +70,7 @@ cmp -s "$TESTDIR/file1" "$TESTDIR/file2" || echo "file1 and file2 do not match"
>> >  cmp -s "$TESTDIR/file2" "$TESTDIR/file2.chk" || echo "file2 and file2.chk do not match"
>> >
>> >  echo "CoW every other block"
>> > -seq 1 2 $NR | while read f; do
>> > +seq 1 2 $((NR - 1)) | while read f; do
>> >         _pwrite_byte 0x62 $((f * BLKSZ)) $BLKSZ "$TESTDIR/file2" >> "$seqres.full"
>> >         _pwrite_byte 0x62 $((f * BLKSZ)) $BLKSZ "$TESTDIR/file2.chk" >> "$seqres.full"
>> >  done
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe fstests" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Filipe David Manana,
>>
>> "Reasonable men adapt themselves to the world.
>>  Unreasonable men adapt the world to themselves.
>>  That's why all progress depends on unreasonable men."



-- 
Filipe David Manana,

"Reasonable men adapt themselves to the world.
 Unreasonable men adapt the world to themselves.
 That's why all progress depends on unreasonable men."
