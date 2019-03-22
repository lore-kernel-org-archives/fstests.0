Received: from smtp03.citrix.com ([162.221.156.55]:39224 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbfCVOmk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 22 Mar 2019 10:42:40 -0400
Subject: Re: [PATCH] Add new tests/generic/536: intermittent I/O errors must
 not corrupt a filesystem
References: <20190321103045.6441-1-edvin.torok@citrix.com>
 <20190321202348.GA1180@magnolia>
From: =?UTF-8?B?RWR3aW4gVMO2csO2aw==?= <edvin.torok@citrix.com>
Message-ID: <4d660c49-e8ba-2dfc-2300-9d9d648e213f@citrix.com>
Date: Fri, 22 Mar 2019 14:42:27 +0000
MIME-Version: 1.0
In-Reply-To: <20190321202348.GA1180@magnolia>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: "Darrick J. Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Mark Syms <Mark.Syms@citrix.com>, Tim Smith <Tim.Smith@citrix.com>, Ross Lagerwall <Ross.Lagerwall@citrix.com>
List-ID: <fstests@vger.kernel.org>

On 21/03/2019 20:23, Darrick J. Wong wrote:
> On Thu, Mar 21, 2019 at 10:30:46AM +0000, Edwin T=C3=B6r=C3=B6k wrote:
>> Based on tests/generic/347.
>>
>> In our lab we've found that if multiple iSCSI connection errors are
>> detected (without completely loosing the iSCSI connection) then the GF=
S2
>> filesystem becomes corrupt due to differences in filesystem and device=
 blocksizes.
>> Add a test that explicitly checks for this by simulating I/O errors
>> deterministically with dm-thin.
>=20
> How is this different from generic/475?  Is there something specific to
> thin pools here (vs. using dm-error to simulate the errors)?

When I tried generic/475 it hanged in unmount and never reached the data =
corruption part.
Thanks for the suggestion, dm-error would be better than dm-thin, see bel=
ow.

On 21/03/2019 21:26, Dave Chinner wrote:> On Thu, Mar 21, 2019 at 10:30:4=
6AM +0000, Edwin T=C3=B6r=C3=B6k wrote:
>> Based on tests/generic/347.
>>
>> In our lab we've found that if multiple iSCSI connection errors are
>> detected (without completely loosing the iSCSI connection) then the GF=
S2
>> filesystem becomes corrupt due to differences in filesystem and device=
 blocksizes.
>> Add a test that explicitly checks for this by simulating I/O errors
>> deterministically with dm-thin.
>=20
> Exactly what IO errors is dm-thinp generating here? If you run it
> out of space, then it triggers ENOSPC, not EIO. That's very, very
> different to iSCSI throwing random EIO errors..

I agree that dm-error would be a better starting place than dm-thin for t=
his test,
I'll try to modify it and see if I can get it to finish running without h=
anging, and reproduce the corruption issue.


On 21/03/2019 21:26, Dave Chinner wrote:> On Thu, Mar 21, 2019 at 10:30:4=
6AM +0000, Edwin T=C3=B6r=C3=B6k wrote:
>> +# now remount the filesystem without triggering IO errors,
>> +# and check that the filesystem is not corrupt
>> +_dmthin_cycle_mount
>> +# ls --color makes ls stat each file, which finds the corruption
>=20
> Not sure it always does - ISTR that in the past if the dtype
> returned indicated the type of file, then it ls would omit the stat
> just for the purposes of coloring....
>=20
> And, realistically, the way we find /filesystem/ corruption is to
> run fsck/repair, not iterate the directory structure.

I don't disagree, however GFS2's fsck is very noisy and complains about i=
nconsistencies
even on a filesystem where I can otherwise list and read each entry corre=
ctly.
I wanted to make a clear distinction between that and actual corruption o=
bserved, so that the 2 bugs
can be fixed independently.

Perhaps the test should first do an 'ls/stat', and if that is fine then u=
nmount and run the filesystem check as usual.

> If we are
> looking for missing files, then we dump the directory structure to
> the golden output file or dump it before/after errors and compare
> that they are the same.
>=20
>> +ls --color=3Dalways $SCRATCH_MNT/ >/dev/null || _fail "Failed to list=
 filesystem after remount"
>> +ls --color=3Dalways $SCRATCH_MNT/ >/dev/null || _fail "Failed to list=
 filesystem after remount"
>> +ls --color=3Dalways $SCRATCH_MNT/ >/dev/null || _fail "Failed to list=
 filesystem after remount"
>=20
> If corruption is not found on the first pass, why would the next 2
> passes find anything different?

Indeed, I'll drop them.

Thanks,
--Edwin
