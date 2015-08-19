Received: from mx5-phx2.redhat.com ([209.132.183.37]:58804 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbbHSCYX convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 18 Aug 2015 22:24:23 -0400
Date: Tue, 18 Aug 2015 22:24:18 -0400 (EDT)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <204068374.10406068.1439951058653.JavaMail.zimbra@redhat.com>
In-Reply-To: <55D3B9D1.6030609@sandeen.net>
References: <1439918511-2859-1-git-send-email-zlang@redhat.com> <20150818222832.GF3902@dastard> <55D3B2A1.2020307@redhat.com> <20150818224351.GG3902@dastard> <55D3B9D1.6030609@sandeen.net>
Subject: Re: [PATCH] xfs/194: fix the exception when run on 4k sector drives
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eric Sandeen <sandeen@sandeen.net>, Dave Chinner <david@fromorbit.com>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Eric Sandeen" <sandeen@sandeen.net>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Dave Chinner" <david@fromorbit.com>, "Eri=
c Sandeen" <sandeen@redhat.com>
> =E6=8A=84=E9=80=81: "Zorro Lang" <zlang@redhat.com>, fstests@vger.kerne=
l.org
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=B8=89, 2015=
=E5=B9=B4 8 =E6=9C=88 19=E6=97=A5 =E4=B8=8A=E5=8D=88 7:03:45
> =E4=B8=BB=E9=A2=98: Re: [PATCH] xfs/194: fix the exception when run on =
4k sector drives
>=20
> On 8/18/15 5:43 PM, Dave Chinner wrote:
> > On Tue, Aug 18, 2015 at 05:33:05PM -0500, Eric Sandeen wrote:
> >> On 8/18/15 5:28 PM, Dave Chinner wrote:
> >>> On Wed, Aug 19, 2015 at 01:21:51AM +0800, Zorro Lang wrote:
> >>>> @@ -50,6 +50,16 @@ rm -f $seqres.full
> >>>>  # For this test we use block size =3D 1/8 page size
> >>>>  pgsize=3D`$here/src/feature -s`
> >>>>  blksize=3D`expr $pgsize / 8`
> >>>> +secsize=3D`_min_dio_alignment $SCRATCH_DEV`
> >>>> +
> >>>> +# The minimal blksize can't less than sector size, So if
> >>>> +# blksize < secsize, we should adjust blksize and pgsize number.
> >>>> +# Of course, if we adjust pgsize, pgsize won't equal to the
> >>>> +# real page size of system.
> >>>> +if [ $blksize -lt $secsize ];then
> >>>> +        blksize=3D$secsize
> >>>> +        pgsize=3D`expr $blksize \* 8`
> >>>> +fi
> >>>
> >>> No, this is wrong. the page size stays fixed at the machine page
> >>> size. We are testing *sub-page block sizes* here and the sector siz=
e
> >>> must be <=3D page size. Increasing the "page size" to larger than t=
he
> >>> machine page size does not make the kernel use larger page sizes.
> >>>
> >>> IOWs, if you've got sector size =3D page size (e.g. 4k sector devic=
e)
> >>> then no matter what you say $pgsize is, the kernel will see a block
> >>> size =3D page size test.

Yes, I know I can't change page size. So I said "for sure the consistency
of test result, I repair pgsize(already not real page size) number accord=
ing
to the new blksize." in git commit message.

Eric said in xfs/194 "Test mapping around/over holes for sub-page blocks"=
,
If the sector size =3D page size, I have no idea how to make sub-page blo=
cks.
So in this situation, I set pgsize=3D`expr $blksize \* 8` just for the te=
st
output suit for 194.out.

Or we don't care pgsize, just set blksize=3D`_min_dio_alignment $SCRATCH_=
DEV`,
and then replace all $pgsize to `expr $blksize \* 8`. If page size > blks=
ize,
that's good. If not, we can't do more things about that, so just make it =
run pass.

> >>>
> >>> This whole chunk of code can simply be replaced with:
> >>>
> >>> blksize=3D`_min_dio_alignment $SCRATCH_DEV`
> >>>
> >>> Because that's what we actually need to test...
> >>
> >> That won't work either, because we could easily get 512 from that.
> >=20
> > If 'blockdev --getss $dev' returns 512, then the device supports 512
> > byte IOs and so it is fine to do 512 byte IOs in the test.
> >=20
> >> and then this test:
> >>
> >> # Now try the same thing but write a sector in the middle of that ho=
le
> >> # If things go badly stale data will be exposed either side.
> >> # This is most interesting for block size > 512 (page size > 4096)
> >>
> >> # We *should* get:
> >> # |1100|HHHH|33HH|HHHH|2222|----|----|----|
> >>
> >> echo "=3D=3D Test 4 =3D=3D"
> >> xfs_io \
> >> -c "pwrite -S 0x11 -b $pgsize 0 $pgsize" \
> >> -c "mmap -r 0 $blksize" -c "mread 0 $blksize" -c "munmap" \
> >> -c "truncate `expr $blksize / 2`" \
> >> -c "truncate `expr $blksize + 1`" \
> >> -c "pwrite -S 0x22 -b $blksize `expr $pgsize / 2` $blksize" \
> >> -c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512" \
> >> -t -d -f $SCRATCH_MNT/testfile4 >> $seqres.full
> >>
> >> will be impossible.
> >>
> >> AFAICT everything works except for that explicit 512-byte IO.
> >=20
> > Right. That hard coded 512 needs to change to $blksize, because
> > blksize is now equal to the sector size. I thought this would be
> > obvious to the reader, so I didn't comment on it.
>=20
> if that last IO is $blksize, and blocksize =3D=3D sector size, then the
> test won't be testing what it's designed to test here, i.e. a
> sub-block direct IO write.

What do you think about loop device? If page size(4k) =3D sector size(4k)=
, how
about use loop device? I think it will be 512 sector size as default?

Thanks,
Zorro

>=20
> # We *should* get:
> # |1100|HHHH|33HH|HHHH|2222|----|----|----|
>              ^^
>              this
>=20
> -Eric
>=20
>=20
