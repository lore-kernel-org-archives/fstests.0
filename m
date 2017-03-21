Received: from mx1.redhat.com ([209.132.183.28]:57052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751792AbdCUHXm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 21 Mar 2017 03:23:42 -0400
Date: Tue, 21 Mar 2017 15:23:40 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 0/3] Btrfs in-band de-duplication test cases
Message-ID: <20170321072340.GT14226@eguan.usersys.redhat.com>
References: <20170316015028.20020-1-quwenruo@cn.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170316015028.20020-1-quwenruo@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 16, 2017 at 09:50:24AM +0800, Qu Wenruo wrote:
> Btrfs in-band de-duplication test cases for in-memory backend, which cove=
rs
> the bugs exposed during the development.

Sorry, I'm having trouble enabling inband dedupe in tests, I always get
ioctl failure, $seqres.full shows:

btrfs-progs v4.10-5-g23d4fd5
See https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__btrfs.wiki.kernel=
.org&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4=
jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=3DQW8j5ytjvhSULN9SgVewhinVZVh9U-etu9=
FpCxFlsCc&s=3DN3fHeukNWyZ1Av8wPL6uQRaIzk0Y6Z90W-7loCAj4J8&e=3D  for more in=
formation.

Label:              (null)
UUID:               3d2cedd0-64ae-4667-ba09-9c12e28ecadd
Node size:          16384
Sector size:        4096
Filesystem size:    15.00GiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         DUP               1.00GiB
  System:           DUP               8.00MiB
SSD detected:       no
Incompat features:  extref, skinny-metadata
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1    15.00GiB  /dev/mapper/systemvg-testlv2

# /usr/local/bin/btrfs dedupe enable -f -s inmemory -b 64K /scratch
ERROR: failed to (enable) inband deduplication: Inappropriate ioctl for dev=
ice
ERROR: unsupported dedupe limit combination: nr: 0, mem: 0
failed: '/usr/local/bin/btrfs dedupe enable -f -s inmemory -b 64K /scratch'

I have no special MKFS_OPTIONS or MOUNT_OPTIONS specified, all defaults.
kernel is built from your test tree. Did I miss anything?

Thanks,
Eryu
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DQW8j5ytjvhSULN9SgVewhinVZVh9U-etu9FpCxFlsCc&s=3DeaJ-tn7MdocpEA2Dssf3q1ti=
BAMCKm3MbKiI4S_bkL0&e=3D=20
