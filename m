Received: from mx1.redhat.com ([209.132.183.28]:48160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755520AbdCUHsj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 21 Mar 2017 03:48:39 -0400
Date: Tue, 21 Mar 2017 15:48:37 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 0/3] Btrfs in-band de-duplication test cases
Message-ID: <20170321074837.GU14226@eguan.usersys.redhat.com>
References: <20170316015028.20020-1-quwenruo@cn.fujitsu.com>
 <20170321072340.GT14226@eguan.usersys.redhat.com>
 <7756e826-f3ab-edf9-8581-63031c24b3f2@cn.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7756e826-f3ab-edf9-8581-63031c24b3f2@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 21, 2017 at 03:36:54PM +0800, Qu Wenruo wrote:
>=20
>=20
> At 03/21/2017 03:23 PM, Eryu Guan wrote:
> > On Thu, Mar 16, 2017 at 09:50:24AM +0800, Qu Wenruo wrote:
> > > Btrfs in-band de-duplication test cases for in-memory backend, which =
covers
> > > the bugs exposed during the development.
> >=20
> > Sorry, I'm having trouble enabling inband dedupe in tests, I always get
> > ioctl failure, $seqres.full shows:
> >=20
> > btrfs-progs v4.10-5-g23d4fd5
> > See https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__btrfs.wiki.ke=
rnel.org&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR8PQcxBKCX5YTpkKY057SbK10&r=3D-yM=
rTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=3DfSE-SZFHxYOtme73LUGhdAkjjKVeu5=
9aewsxj3KYT8Q&s=3DwL4wtAJyaJ3YtkcV6849DAoedG_3c8E0ngquYDlE9ns&e=3D  for mor=
e information.
> >=20
> > Label:              (null)
> > UUID:               3d2cedd0-64ae-4667-ba09-9c12e28ecadd
> > Node size:          16384
> > Sector size:        4096
> > Filesystem size:    15.00GiB
> > Block group profiles:
> >   Data:             single            8.00MiB
> >   Metadata:         DUP               1.00GiB
> >   System:           DUP               8.00MiB
> > SSD detected:       no
> > Incompat features:  extref, skinny-metadata
> > Number of devices:  1
> > Devices:
> >    ID        SIZE  PATH
> >     1    15.00GiB  /dev/mapper/systemvg-testlv2
> >=20
> > # /usr/local/bin/btrfs dedupe enable -f -s inmemory -b 64K /scratch
> > ERROR: failed to (enable) inband deduplication: Inappropriate ioctl for=
 device
> > ERROR: unsupported dedupe limit combination: nr: 0, mem: 0
>=20
> What I forgot to mention is that, the inband dedupe feature is an
> experimental feature, so CONFIG_BTRFS_DEBUG is needed to use this feature.

OK, I'll rebuild with BTRFS_DEBUG and try again, thanks for the info!
But IMHO, giving out experimental message in dmesg seems sufficient,
like what XFS reflink feature does.

>=20
> Sorry for the inconvenience.
>=20
> I'll add also add the CONFIG_BTRFS_DEBUG check for /sys/fs/btrfs/feature/,
> so it won't export inband dedupe to users.

I'd suggest that adding a new require rule to check if inband dedupe is
supported by current kernel, by enabling inband dedupe and see the
result, so that we don't need to update the CONFIG_BTRFS_DEBUG check
when this feature is moved out of BTRFS_DEBUG.

Thanks,
Eryu
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DfSE-SZFHxYOtme73LUGhdAkjjKVeu59aewsxj3KYT8Q&s=3DEWR8R6A6ZhG1pWEZAhSGUJ2o=
piKV_e5FsB5X3ZMVxLE&e=3D=20
