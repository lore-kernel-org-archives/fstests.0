Received: from mx5-phx2.redhat.com ([209.132.183.37]:38015 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbcEWJKi convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 23 May 2016 05:10:38 -0400
Date: Mon, 23 May 2016 05:10:33 -0400 (EDT)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <2075874283.53427065.1463994633614.JavaMail.zimbra@redhat.com>
In-Reply-To: <20160523074654.GF5140@eguan.usersys.redhat.com>
References: <1463460110-15297-1-git-send-email-zlang@redhat.com> <20160523074654.GF5140@eguan.usersys.redhat.com>
Subject: Re: [PATCH v2] xfs/106: rewrite this case for run it as auto test
 again
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Eryu Guan" <eguan@redhat.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
> =E6=8A=84=E9=80=81: fstests@vger.kernel.org, sandeen@redhat.com
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=B8=80, 2016=
=E5=B9=B4 5 =E6=9C=88 23=E6=97=A5 =E4=B8=8B=E5=8D=88 3:46:54
> =E4=B8=BB=E9=A2=98: Re: [PATCH v2] xfs/106: rewrite this case for run i=
t as auto test again
>=20
> On Tue, May 17, 2016 at 12:41:50PM +0800, Zorro Lang wrote:
> > xfs/106 try to do some basic xfs_quota functionality test. I think
> > basic function test is important, especially there're only few
> > cases about xfs_quota now. But due to it's too old, there're 3
> > problems cause no one run it again:
> >    1. Some quota commands can't be used, but this case try to use it.
> >       e.g. "warn" command.
> >    2. Some quota commands can be used now, but this case doesn't test
> >       them, because they can't work previously. e.g. "disable, enable=
,
> >       off and remove" comands
> >    3. Some expected output in 106.out file become incorrect now.
> >=20
> > I rewrite this case for above 3 reasons. This case nearly test all
> > xfs_quota commands and options now, except:
> >    1. some "-v" options
> >    2. all "-a" options. I can't control the golden file if print all
> >       filesystem's quota info in it.
> >    3. default quota. I think it can be tested in another case.
> >    4. project command options. I will write another case to test it.
> >    5. report command -l option. It's a new option, will cause failure
> >       if someone test on a release with xfsprogs-3.1.
> >    6. quot command -c option. It maybe output different histogram in
> >       different system or machine.
> >    7. warn command. This feature is not currently implemented.
> >    8. print, df, free, help, quit and path commands.
> >=20
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
>=20
> I'm not so familiar with xfs quota, so I just ran the test and review i=
t
> from a more general perspective.
>=20
> The test works well on v5 xfs, but it fails when test on v4 xfs, e.g.
>=20
> [root@dhcp-66-86-11 xfstests]# diff -u tests/xfs/106.out
> /root/workspace/xfstests/results//xfs_512/xfs/106.out.bad
> --- tests/xfs/106.out   2016-05-23 15:07:41.439000000 +0800
> +++ /root/workspace/xfstests/results//xfs_512/xfs/106.out.bad   2016-05=
-23
> 15:15:16.558000000 +0800
> @@ -349,10 +349,12 @@
>  Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
>  ---------- --------------------------------------------------
>  --------------------------------------------------
>  fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> ...
>=20
> Maybe the test needs more filters?
>=20
> Also, it fails fsck on v4 xfs, but this is not xfs/106 specific, I saw
> many other quota related tests failed the same way with v4 xfs. (I
> reported this issue to xfs list along other issues back in Mar., see
> http://oss.sgi.com/archives/xfs/2016-03/msg00063.html).
>=20
> *** xfs_repair -n output ***
> Phase 1 - find and verify superblock...
> Phase 2 - using internal log
>         - zero log...
>         - scan filesystem freespace and inode maps...
>         - found root inode chunk
> Phase 3 - for each AG...
>         - scan (but don't clear) agi unlinked lists...
>         - process known inodes and perform inode discovery...
>         - agno =3D 0
>         - agno =3D 1
>         - agno =3D 2
>         - agno =3D 3
>         - process newly discovered inodes...
> Phase 4 - check for duplicate blocks...
>         - setting up duplicate extent list...
>         - check for inodes claiming duplicate blocks...
>         - agno =3D 0
>         - agno =3D 2
>         - agno =3D 1
>         - agno =3D 3
> No modify flag set, skipping phase 5
> Phase 6 - check inode connectivity...
>         - traversing filesystem ...
>         - traversal finished ...
>         - moving disconnected inodes to lost+found ...
> disconnected inode 36, would move to lost+found
> Phase 7 - verify link counts...
> No modify flag set, skipping filesystem flush and exiting.
> *** end xfs_repair output
>=20
>=20
> And some minor (coding style) comments inline.

Thanks, I can reproduce this bug. It's not a filter problem, I think
it looks like a bug. "report" and "quot" commands all print this line:

  > +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]

it doesn't likes xfsprogs bug(maybe kernel bug).

That redundant output use fsgqa's group id as the #ID, but we test
project quota at that part. On the other side:
1. we mount and set group quota for fsgqa, then umount.
2. we mount and set project quota for fsgqa, then report or quot project
quota will print:
  $project_ID_fsgqa .....
  $group_ID_of_fsgqa .....=20

The second line is redundant. So it's a problem of group quota & project
quota. If test project quota before group quota, no this bug.
Only if you set group quota at first, then set project quota, then the
bug can be reproduce.

I'm digging into it, try to sure if it's the same with
"[PATCH] xfs: add missing break in xfs_parseargs()" at first. Then do
more debug.
=20

>=20
> >=20
> > Hi,
> >=20
> > V2 changed below:
> [snip]
> > diff --git a/tests/xfs/106 b/tests/xfs/106
> > index 74658a6..f8593d0 100755
> > --- a/tests/xfs/106
> > +++ b/tests/xfs/106
> > @@ -31,208 +31,289 @@ echo "QA output created by $seq"
> >  here=3D`pwd`
> >  tmp=3D/tmp/$$
> >  status=3D1	# failure is the default!
> > -trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +    cd /
> > +    rm -f $tmp.*
>=20
> Seems you use 4 spaces for indention, please use tab instead (8 spaces
> width). Some old tests are using 4 spaces for indention, but we're in
> the progress to convert all these tests to use tab (very slowly), mainl=
y
> by the chance of updating old tests like this :)

Sorry, my emacs configed as 4 spaces if edit shell script. I'll change th=
at.

>=20
> > +}
> > =20
> >  # get standard environment, filters and checks
> >  . ./common/rc
> >  . ./common/filter
> >  . ./common/quota
> > =20
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> >  _supported_fs xfs
> > -_supported_os Linux #IRIX
> > +_supported_os Linux
> >  _require_scratch
> >  _require_xfs_quota
> > +_require_user
> > +_require_group
> > =20
> > -# real QA test starts here
> > -_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
> > -cat $tmp.mkfs >$seqres.full
> > -. $tmp.mkfs
> > +_scratch_mkfs_xfs >$seqres.full 2>&1
> > =20
> > -# setup a default run
> > -if [ -z "$MOUNT_OPTIONS" ]; then
> > -	export MOUNT_OPTIONS=3D"-o pquota,sync"
> > -else
> > -	export MOUNT_OPTIONS=3D"$MOUNT_OPTIONS -o sync"
> > -fi
> > +uqid=3D`id -u fsgqa`
> > +gqid=3D`id -g fsgqa`
> > +pqid=3D10
> > +cat >$tmp.projects <<EOF
> > +$pqid:$SCRATCH_MNT
> > +EOF
> > =20
> > -_qmount
> > -_require_prjquota $SCRATCH_DEV
> > +cat >$tmp.projid <<EOF
> > +root:0
> > +fsgqa:$pqid
> > +EOF
> > =20
> > -# initial populate
> > -target=3D$SCRATCH_MNT/target
> > -$FSSTRESS_PROG -z -s 57069 -m 8 -n 1000 -p 4 \
> > --f allocsp=3D1 \
> > --f chown=3D3 \
> > --f creat=3D4 \
> > --f dwrite=3D4 \
> > --f fallocate=3D1 \
> > --f fdatasync=3D1 \
> > --f fiemap=3D1 \
> > --f freesp=3D1 \
> > --f fsync=3D1 \
> > --f link=3D1 \
> > --f mkdir=3D2 \
> > --f mknod=3D2 \
> > --f punch=3D1 \
> > --f rename=3D2 \
> > --f resvsp=3D1 \
> > --f rmdir=3D1 \
> > --f setxattr=3D1 \
> > --f symlink=3D2 \
> > --f sync=3D1 \
> > --f truncate=3D2 \
> > --f unlink=3D1 \
> > --f unresvsp=3D1 \
> > --f write=3D4 \
> > --d $target
> > -
> > -$FSSTRESS_PROG -z -s 57069 -m 8 -n 1000 -p 4 \
> > --f chown=3D500 \
> > --f setxattr=3D500 \
> > --d $target
> > -
> > -# also use space, to be able to go over/under limits easily
> > -uid=3D255
> > -gid=3D254
> > -prid=3D253
> > -rm -f $SCRATCH_MNT/resv
> > -$XFS_IO_PROG -fc "resvsp 0 200m" -c "chproj $prid" $SCRATCH_MNT/resv
> > -chown $uid $SCRATCH_MNT/resv
> > -chgrp $gid $SCRATCH_MNT/resv
> > +create_files()
> > +{
> > +    local bs=3D$1
> > +    local inum=3D$2
> > =20
> > -_qmount
> > +    echo "Using type=3D$type id=3D$id" >> $seqres.full
> > +
> > +    for ((i=3D0; i<$((inum-1)); i++))
> > +    do
> > +	_file_as_id $SCRATCH_MNT/inode$i $id $type 1024 0
> > +    done
>=20
> Please use this for format
>=20
> 	for ...; do
> 		...
> 	done

Sure, I'll do that.


Thanks,
Zorro


>=20
> Thanks,
> Eryu
>
