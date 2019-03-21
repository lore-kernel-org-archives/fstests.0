Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:3835 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726616AbfCUV0o (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Mar 2019 17:26:44 -0400
Date: Fri, 22 Mar 2019 08:26:41 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] Add new tests/generic/536: intermittent I/O errors must
 not corrupt a filesystem
Message-ID: <20190321212641.GD26298@dastard>
References: <20190321103045.6441-1-edvin.torok@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190321103045.6441-1-edvin.torok@citrix.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Edwin =?iso-8859-1?B?VPZy9ms=?= <edvin.torok@citrix.com>
Cc: fstests@vger.kernel.org, Mark Syms <Mark.Syms@citrix.com>, Tim Smith <Tim.Smith@citrix.com>, Ross Lagerwall <Ross.Lagerwall@citrix.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 21, 2019 at 10:30:46AM +0000, Edwin T=F6r=F6k wrote:
> Based on tests/generic/347.
>=20
> In our lab we've found that if multiple iSCSI connection errors are
> detected (without completely loosing the iSCSI connection) then the GFS=
2
> filesystem becomes corrupt due to differences in filesystem and device =
blocksizes.
> Add a test that explicitly checks for this by simulating I/O errors
> deterministically with dm-thin.

Exactly what IO errors is dm-thinp generating here? If you run it
out of space, then it triggers ENOSPC, not EIO. That's very, very
different to iSCSI throwing random EIO errors..

.....
> +# now remount the filesystem without triggering IO errors,
> +# and check that the filesystem is not corrupt
> +_dmthin_cycle_mount
> +# ls --color makes ls stat each file, which finds the corruption

Not sure it always does - ISTR that in the past if the dtype
returned indicated the type of file, then it ls would omit the stat
just for the purposes of coloring....

And, realistically, the way we find /filesystem/ corruption is to
run fsck/repair, not iterate the directory structure. If we are
looking for missing files, then we dump the directory structure to
the golden output file or dump it before/after errors and compare
that they are the same.

> +ls --color=3Dalways $SCRATCH_MNT/ >/dev/null || _fail "Failed to list =
filesystem after remount"
> +ls --color=3Dalways $SCRATCH_MNT/ >/dev/null || _fail "Failed to list =
filesystem after remount"
> +ls --color=3Dalways $SCRATCH_MNT/ >/dev/null || _fail "Failed to list =
filesystem after remount"

If corruption is not found on the first pass, why would the next 2
passes find anything different?

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
