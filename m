Received: from mx4-phx2.redhat.com ([209.132.183.25]:44211 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbbHSDrE convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 18 Aug 2015 23:47:04 -0400
Date: Tue, 18 Aug 2015 23:46:59 -0400 (EDT)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <1801602262.10426533.1439956019811.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150819024216.GH3902@dastard>
References: <1439918511-2859-1-git-send-email-zlang@redhat.com> <20150818222832.GF3902@dastard> <55D3B2A1.2020307@redhat.com> <20150818224351.GG3902@dastard> <55D3B9D1.6030609@sandeen.net> <20150819024216.GH3902@dastard>
Subject: Re: [PATCH] xfs/194: fix the exception when run on 4k sector drives
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Dave Chinner <david@fromorbit.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, Eric Sandeen <sandeen@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Dave Chinner" <david@fromorbit.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Eric Sandeen" <sandeen@sandeen.net>
> =E6=8A=84=E9=80=81: "Eric Sandeen" <sandeen@redhat.com>, "Zorro Lang" <=
zlang@redhat.com>, fstests@vger.kernel.org
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=B8=89, 2015=
=E5=B9=B4 8 =E6=9C=88 19=E6=97=A5 =E4=B8=8A=E5=8D=88 10:42:16
> =E4=B8=BB=E9=A2=98: Re: [PATCH] xfs/194: fix the exception when run on =
4k sector drives
>=20
> On Tue, Aug 18, 2015 at 06:03:45PM -0500, Eric Sandeen wrote:
> > On 8/18/15 5:43 PM, Dave Chinner wrote:
> > > On Tue, Aug 18, 2015 at 05:33:05PM -0500, Eric Sandeen wrote:
> > >> On 8/18/15 5:28 PM, Dave Chinner wrote:
> > >>> On Wed, Aug 19, 2015 at 01:21:51AM +0800, Zorro Lang wrote:
> > >>>> @@ -50,6 +50,16 @@ rm -f $seqres.full
> > >>>>  # For this test we use block size =3D 1/8 page size
> > >>>>  pgsize=3D`$here/src/feature -s`
> > >>>>  blksize=3D`expr $pgsize / 8`
> > >>>> +secsize=3D`_min_dio_alignment $SCRATCH_DEV`
> > >>>> +
> > >>>> +# The minimal blksize can't less than sector size, So if
> > >>>> +# blksize < secsize, we should adjust blksize and pgsize number.
> > >>>> +# Of course, if we adjust pgsize, pgsize won't equal to the
> > >>>> +# real page size of system.
> > >>>> +if [ $blksize -lt $secsize ];then
> > >>>> +        blksize=3D$secsize
> > >>>> +        pgsize=3D`expr $blksize \* 8`
> > >>>> +fi
> > >>>
> > >>> No, this is wrong. the page size stays fixed at the machine page
> > >>> size. We are testing *sub-page block sizes* here and the sector s=
ize
> > >>> must be <=3D page size. Increasing the "page size" to larger than=
 the
> > >>> machine page size does not make the kernel use larger page sizes.
> > >>>
> > >>> IOWs, if you've got sector size =3D page size (e.g. 4k sector dev=
ice)
> > >>> then no matter what you say $pgsize is, the kernel will see a blo=
ck
> > >>> size =3D page size test.
> > >>>
> > >>> This whole chunk of code can simply be replaced with:
> > >>>
> > >>> blksize=3D`_min_dio_alignment $SCRATCH_DEV`
> > >>>
> > >>> Because that's what we actually need to test...
> > >>
> > >> That won't work either, because we could easily get 512 from that.
> > >=20
> > > If 'blockdev --getss $dev' returns 512, then the device supports 51=
2
> > > byte IOs and so it is fine to do 512 byte IOs in the test.
> > >=20
> > >> and then this test:
> > >>
> > >> # Now try the same thing but write a sector in the middle of that =
hole
> > >> # If things go badly stale data will be exposed either side.
> > >> # This is most interesting for block size > 512 (page size > 4096)
> > >>
> > >> # We *should* get:
> > >> # |1100|HHHH|33HH|HHHH|2222|----|----|----|
> > >>
> > >> echo "=3D=3D Test 4 =3D=3D"
> > >> xfs_io \
> > >> -c "pwrite -S 0x11 -b $pgsize 0 $pgsize" \
> > >> -c "mmap -r 0 $blksize" -c "mread 0 $blksize" -c "munmap" \
> > >> -c "truncate `expr $blksize / 2`" \
> > >> -c "truncate `expr $blksize + 1`" \
> > >> -c "pwrite -S 0x22 -b $blksize `expr $pgsize / 2` $blksize" \
> > >> -c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512" \
> > >> -t -d -f $SCRATCH_MNT/testfile4 >> $seqres.full
> > >>
> > >> will be impossible.
> > >>
> > >> AFAICT everything works except for that explicit 512-byte IO.
> > >=20
> > > Right. That hard coded 512 needs to change to $blksize, because
> > > blksize is now equal to the sector size. I thought this would be
> > > obvious to the reader, so I didn't comment on it.
> >=20
> > if that last IO is $blksize, and blocksize =3D=3D sector size, then t=
he
> > test won't be testing what it's designed to test here, i.e. a
> > sub-block direct IO write.
>=20
> That's not what the test is exercising:
>=20
> # Test mapping around/over holes for sub-page blocks
>=20
> it's testing *sub-page block behaviour*, not sub-block direct IO.
>=20
> >=20
> > # We *should* get:
> > # |1100|HHHH|33HH|HHHH|2222|----|----|----|
> >              ^^
> >              this
>=20
> That implies a sub-block sized direct IO, on a single page that has
> 8 blocks. On a 4k page size machine, that is impossible and so most
> of the time we are not doing what the comment implies.
>=20
> With a 4k page, 512 byte block size:
>=20
> | xfs_io \
> | -c "pwrite -S 0x11 -b $pgsize 0 $pgsize" \
>=20
> Write an entire page (4k)
>=20
> # |1111|1111|1111|1111|1111|1111|1111|1111|
>=20
> | -c "mmap -r 0 $blksize" -c "mread 0 $blksize" -c "munmap" \
>=20
> map the first block (0-511 bytes - one sector)
>=20
> | -c "truncate `expr $blksize / 2`" \
> | -c "truncate `expr $blksize + 1`" \
>=20
> sub-block truncate down, sub-block truncate up, make sure page cache
> is correctly zeroed.
>=20
> # |1100|HHHH|----|----|----|----|----|----|
>=20
> | -c "pwrite -S 0x22 -b $blksize `expr $pgsize / 2` $blksize" \
>=20
> DIO write of a single block half way through the original page, make
> sure page cache is flushed correctly before DIO.
>=20
> # |1100|HHHH|HHHH|HHHH|2222|----|----|----|
>=20
> FWIW, this write will fail on a 4k sector device on a 4k page size
> platform, because the IO is not sector aligned, and is why the
> original patch needed to multiply pgsize out to 8 * sector size....
>=20
> | -c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512" \
>=20
> do a -minimum sized write- to the *3rd* block in the page.
>=20
> # |1100|HHHH|3333|HHHH|2222|----|----|----|

Yes, that's true. if sector size and block size all 512b, we will get thi=
s.

In my test machine(64k page size, and 4k sector size), this case will
mkfs with blksize=3D8k, and we can get:

|1100|HHHH|33HH|HHHH|2222|----|----|----| (one |----| means 8k block size=
 at here:)

>=20
> And that matches the expected output. We do not get this output with
> a block size that is anything other than pgsize / 8, regardless of
> whether the last write is a sub-block DIO or not.
>=20
> IOWs, this test assumes that there are at least 8 blocks to page
> because to exercise the appropriate paths it needs a hole between
> each region that is written.  4k sector/4k page means the kernel
> cannot do sub-page block size operations, and the test does not
> exercise the code paths we're expecting it to. Hence it may simply
> be best to do this:
>=20
> if [ $sector_size > $page_size / 8 ]; then
> 	_not_run "sector size too large for platform page size"
> fi

If so, that'll be simple. I will send V2 patch for review;)

Thanks,
Zorro

>=20
> and replace the hard coded 512 with $sector_size.
>=20
> Cheers,
>=20
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
>=20
