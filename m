Received: from mx1.redhat.com ([209.132.183.28]:34904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932242AbdCUNY3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 21 Mar 2017 09:24:29 -0400
Date: Tue, 21 Mar 2017 09:24:27 -0400
From: Niels de Vos <ndevos@redhat.com>
Subject: Re: [Gluster-devel] [PATCH v2] fstests: add GlusterFS support
Message-ID: <20170321132427.GC14145@ndevos-x240.usersys.redhat.com>
References: <1489642099-9019-1-git-send-email-zlang@redhat.com>
 <20170321034517.GB14145@ndevos-x240.usersys.redhat.com>
 <20170321040405.GP21915@dhcp12-143.nay.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170321040405.GP21915@dhcp12-143.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, gluster-devel@gluster.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 21, 2017 at 12:04:05PM +0800, Zorro Lang wrote:
> On Mon, Mar 20, 2017 at 11:45:17PM -0400, Niels de Vos wrote:
> > On Thu, Mar 16, 2017 at 01:28:19PM +0800, Zorro Lang wrote:
> > > Add basic GlusterFS support. Neither new GlusterFS specific tests
> > > nor related patches are included. Only support FSTYP=3Dglusterfs or
> > > check -glusterfs XXX.
> > >=20
> > > To test on glusterfs, two gluster volumes and two mountpoint
> > > directories are needed.
> > >=20
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > >=20
> > > Hi glusterfs developers,
> > >=20
> > > Recently some people cares about testing kernel FUSE by running
> > > xfstests. We can't test FUSE independently, we must depend upon
> > > someone real FS base on FUSE, e.g. GlusterFS.
> > >=20
> > > This patch only want to run xfstests on glusterfs, but I haven't
> > > made sure if there's no case bugs for glusterfs. I think that's
> > > another problem which I will fix in later patches.
> > >=20
> > > At first I prepare two gluster volumes and two directories, then
> > > set into xfstests/local.config.
> > >=20
> > > [root@ibm-x3650m4-10 xfstests-dev]# cat local.config
> > > TEST_DIR=3D/mnt/gluster/test
> > > TEST_DEV=3Dibm-xxxx-xx.redhat.com:testvol
> > > SCRATCH_MNT=3D/mnt/gluster/scratch
> > > SCRATCH_DEV=3Dibm-xxxx-xx.redhat.com:scratchvol
> > >=20
> > > (feel free to set MOUNT_OPTIONS, or GLUSTERFS_MOUNT_OPTIONS)
> > >=20
> > > Then I ran some generic cases, e.g. g/001 and g/117, one test on
> > > TEST_DEV, and the other run on SCRATCH_DEV:
> > >=20
> > > [root@ibm-x3650m4-10 xfstests-dev]# ./check -glusterfs generic/001
> > > FSTYP         -- glusterfs
> > > PLATFORM      -- Linux/x86_64 ibm-x3650m4-10 3.10.0-581.el7.x86_64
> > > MKFS_OPTIONS  -- ibm-x3650m4-10.rhts.eng.pek2.redhat.com:scratchvol
> > > MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:nfs_t:s0 ibm-x3650m4-=
10.rhts.eng.pek2.redhat.com:scratchvol /mnt/gluster/scratch
> > >=20
> > > generic/001 9s ... 8s
> > > Ran: generic/001
> > > Passed all 1 tests
> > >=20
> > > [root@ibm-x3650m4-10 xfstests-dev]# ./check -glusterfs generic/117
> > > FSTYP         -- glusterfs
> > > PLATFORM      -- Linux/x86_64 ibm-x3650m4-10 3.10.0-581.el7.x86_64
> > > MKFS_OPTIONS  -- ibm-x3650m4-10.rhts.eng.pek2.redhat.com:scratchvol
> > > MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:nfs_t:s0 ibm-x3650m4-=
10.rhts.eng.pek2.redhat.com:scratchvol /mnt/gluster/scratch
> > >=20
> > > generic/117 24s ... 24s
> > > Ran: generic/117
> > > Passed all 1 tests
> > >=20
> > > The results look good. But there're some cases fails on glusterfs,
> > > I think that's case problem or glusterfs problems. I'll look into
> > > them in the future.
> > >=20
> > > I only know how to use "mount -t glusterfs XXXX:vol /mnt", if you
> > > have any other requirements or suggestions, please tell me.
> > > Welcome send more patches to fstests@ mail list:)
> > >=20
> > > Thanks,
> > > Zorro
> > >=20
> > >  README.config-sections |  7 +++++++
> > >  check                  |  2 ++
> > >  common/config          |  6 ++++++
> > >  common/rc              | 34 ++++++++++++++++++++++++++++++++--
> > >  4 files changed, 47 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/README.config-sections b/README.config-sections
> > > index df7c929..9133997 100644
> > > --- a/README.config-sections
> > > +++ b/README.config-sections
> > > @@ -121,3 +121,10 @@ TEST_DIR=3D/mnt/test
> > >  TEST_DEV=3D192.168.14.1:6789:/
> > >  TEST_FS_MOUNT_OPTS=3D"-o name=3Dadmin,secret=3DAQDuEBtYKEYRINGSECRET=
riSC8YJGDZsQHcr7g=3D=3D"
> > >  FSTYP=3D"ceph"
> > > +
> > > +[glusterfs]
> > > +FSTYP=3Dglusterfs
> > > +TEST_DIR=3D/mnt/gluster/test
> > > +TEST_DEV=3D192.168.1.1:testvol
> > > +SCRATCH_DIR=3D/mnt/gluster/scratch
> > > +SCRATCH_DEV=3D192.168.1.1:scratchvol
> >=20
> > We mostly use the format of 192.168.1.1:/testvol, matching the way NFS
>=20
> Hi Niels,
>=20
> I limit the DEVICE name format should match "\w:\w", when mount -t gluste=
rfs.
> That means there's not "/" beside the ":". Do you think I should change
> this regular expression?

Yes, it would be good to have an optional "/" after the ":". It is not
required, but would probably help when someone runs the tests with the
"hostname:/volume" device format.

> I think you only use "192.168.1.1:/testvol", when you do mount -t nfs,
> right?

Yes, I am pretty sure NFS expects the "/" after the ":". This counts for
any NFS servers that use Gluster on the backend as well.

Thanks,
Niels


> Thanks,
> Zorro
>=20
> > mounts an export. That is not required though, and the notation used
> > here is valid as well.
> >=20
> > Looks good to me - once the SCRATCH_DIR/MNT error has been corrected.
> >=20
> > Reviewed-by: Niels de Vos <ndevos@redhat.com>
> >=20
> >=20
> > > diff --git a/check b/check
> > > index c2c22e2..2fcf385 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -65,6 +65,7 @@ usage()
> > >=20=20
> > >  check options
> > >      -nfs                test NFS
> > > +    -glusterfs                test GlusterFS
> > >      -cifs               test CIFS
> > >      -overlay		test overlay
> > >      -tmpfs              test TMPFS
> > > @@ -260,6 +261,7 @@ while [ $# -gt 0 ]; do
> > >  	-\? | -h | --help) usage ;;
> > >=20=20
> > >  	-nfs)		FSTYP=3Dnfs ;;
> > > +	-glusterfs)	FSTYP=3Dglusterfs ;;
> > >  	-cifs)		FSTYP=3Dcifs ;;
> > >  	-overlay)	FSTYP=3Doverlay; export OVERLAY=3Dtrue ;;
> > >  	-tmpfs)		FSTYP=3Dtmpfs ;;
> > > diff --git a/common/config b/common/config
> > > index 0c7335a..1ee16f7 100644
> > > --- a/common/config
> > > +++ b/common/config
> > > @@ -301,6 +301,9 @@ _mount_opts()
> > >  	ceph)
> > >  		export MOUNT_OPTIONS=3D$CEPHFS_MOUNT_OPTIONS
> > >  		;;
> > > +	glusterfs)
> > > +		export MOUNT_OPTIONS=3D$GLUSTERFS_MOUNT_OPTIONS
> > > +		;;
> > >  	overlay)
> > >  		export MOUNT_OPTIONS=3D$OVERLAY_MOUNT_OPTIONS
> > >  		;;
> > > @@ -341,6 +344,9 @@ _test_mount_opts()
> > >  	ceph)
> > >  		export TEST_FS_MOUNT_OPTS=3D$CEPHFS_MOUNT_OPTIONS
> > >  		;;
> > > +	glusterfs)
> > > +		export TEST_FS_MOUNT_OPTS=3D$GLUSTERFS_MOUNT_OPTIONS
> > > +		;;
> > >  	*)
> > >  		;;
> > >  	esac
> > > diff --git a/common/rc b/common/rc
> > > index d53f679..7185c3f 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -167,6 +167,8 @@ case "$FSTYP" in
> > >  	 ;;
> > >      ceph)
> > >  	 ;;
> > > +    glusterfs)
> > > +	 ;;
> > >      overlay)
> > >  	 ;;
> > >      reiser4)
> > > @@ -706,6 +708,9 @@ _test_mkfs()
> > >      ceph)
> > >  	# do nothing for ceph
> > >  	;;
> > > +    glusterfs)
> > > +	# do nothing for glusterfs
> > > +	;;
> > >      overlay)
> > >  	# do nothing for overlay
> > >  	;;
> > > @@ -788,7 +793,7 @@ _scratch_mkfs()
> > >  	local mkfs_status
> > >=20=20
> > >  	case $FSTYP in
> > > -	nfs*|cifs|ceph|overlay)
> > > +	nfs*|cifs|ceph|overlay|glusterfs)
> > >  		# unable to re-create this fstyp, just remove all files in
> > >  		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
> > >  		# created in previous runs
> > > @@ -1307,7 +1312,8 @@ _fs_type()
> > >      # Fix the filesystem type up here so that the callers don't
> > >      # have to bother with this quirk.
> > >      #
> > > -    _df_device $1 | $AWK_PROG '{ print $2 }' | sed -e 's/nfs4/nfs/'
> > > +    _df_device $1 | $AWK_PROG '{ print $2 }' | \
> > > +        sed -e 's/nfs4/nfs/' -e 's/fuse.glusterfs/glusterfs/'
> > >  }
> > >=20=20
> > >  # return the FS mount options of a mounted device
> > > @@ -1489,6 +1495,15 @@ _check_mounted_on()
> > >  _require_scratch_nocheck()
> > >  {
> > >      case "$FSTYP" in
> > > +	glusterfs)
> > > +		echo $SCRATCH_DEV | grep -q "\w:\w" > /dev/null 2>&1
> > > +		if [ -z "$SCRATCH_DEV" -o "$?" !=3D "0" ]; then
> > > +			_notrun "this test requires a valid \$SCRATCH_DEV"
> > > +		fi
> > > +		if [ ! -d "$SCRATCH_MNT" ]; then
> > > +			_notrun "this test requires a valid \$SCRATCH_MNT"
> > > +		fi
> > > +		;;
> > >  	nfs*|ceph)
> > >  		echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
> > >  		if [ -z "$SCRATCH_DEV" -o "$?" !=3D "0" ]; then
> > > @@ -1568,6 +1583,15 @@ _require_scratch()
> > >  _require_test()
> > >  {
> > >      case "$FSTYP" in
> > > +	glusterfs)
> > > +		echo $TEST_DEV | grep -q "\w:\w" > /dev/null 2>&1
> > > +		if [ -z "$TEST_DEV" -o "$?" !=3D "0" ]; then
> > > +			_notrun "this test requires a valid \$TEST_DEV"
> > > +		fi
> > > +		if [ ! -d "$TEST_DIR" ]; then
> > > +			_notrun "this test requires a valid \$TEST_DIR"
> > > +		fi
> > > +		;;
> > >  	nfs*|ceph)
> > >  		echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
> > >  		if [ -z "$TEST_DEV" -o "$?" !=3D "0" ]; then
> > > @@ -2421,6 +2445,9 @@ _check_test_fs()
> > >      ceph)
> > >  	# no way to check consistency for CephFS
> > >  	;;
> > > +    glusterfs)
> > > +	# no way to check consistency for GlusterFS
> > > +	;;
> > >      overlay)
> > >  	# no way to check consistency for overlay
> > >  	;;
> > > @@ -2468,6 +2495,9 @@ _check_scratch_fs()
> > >      ceph)
> > >  	# no way to check consistency for CephFS
> > >  	;;
> > > +    glusterfs)
> > > +	# no way to check consistency for GlusterFS
> > > +	;;
> > >      overlay)
> > >  	# no way to check consistency for overlay
> > >  	;;
> > > --=20
> > > 2.7.4
> > >=20
> > > _______________________________________________
> > > Gluster-devel mailing list
> > > Gluster-devel@gluster.org
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.gluster.o=
rg_mailman_listinfo_gluster-2Ddevel&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR8PQcx=
BKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=3DceN=
cMcbLaVLtR5VeCP8DTuanEcTPtqzWZ886OHRAX4M&s=3D1F7y0_BFe93il-mXp-FPiczZ70nxJB=
835Us7I9R3iq4&e=3D=20
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DceNcMcbLaVLtR5VeCP8DTuanEcTPtqzWZ886OHRAX4M&s=3DySLMN4-fVRFTCQyzaWwO6Ykw=
vHnh_pJeCdX7r9fDLk0&e=3D=20
