Received: from mout.gmx.net ([212.227.15.19]:47747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbeCFMHZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 6 Mar 2018 07:07:25 -0500
Subject: Re: [PATCH 3/3] fstests: btrfs: Add test case to check v1 space cache
 corruption
References: <20180306081555.3242-1-wqu@suse.com>
 <20180306081555.3242-3-wqu@suse.com>
 <CAL3q7H5_1WiGZKEzFGBQRsA9prJ-uMUn2+TKBWHyKOGha4nLDQ@mail.gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ad265a98-f5e1-3eb8-1002-1868bbc07f94@gmx.com>
Date: Tue, 6 Mar 2018 20:07:08 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5_1WiGZKEzFGBQRsA9prJ-uMUn2+TKBWHyKOGha4nLDQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AGcD8bWVq0fOchEy4mp9yELGaULHO3s8x"
Sender: fstests-owner@vger.kernel.org
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, fstests@vger.kernel.org, dsterba@suse.cz, amir73il@gmail.com
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AGcD8bWVq0fOchEy4mp9yELGaULHO3s8x
Content-Type: multipart/mixed; boundary="yV6uJEP2LqMMohoBe2hhfET2Ayo0vusWj";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, fstests@vger.kernel.org,
 dsterba@suse.cz, amir73il@gmail.com
Message-ID: <ad265a98-f5e1-3eb8-1002-1868bbc07f94@gmx.com>
Subject: Re: [PATCH 3/3] fstests: btrfs: Add test case to check v1 space cache
 corruption
References: <20180306081555.3242-1-wqu@suse.com>
 <20180306081555.3242-3-wqu@suse.com>
 <CAL3q7H5_1WiGZKEzFGBQRsA9prJ-uMUn2+TKBWHyKOGha4nLDQ@mail.gmail.com>
In-Reply-To: <CAL3q7H5_1WiGZKEzFGBQRsA9prJ-uMUn2+TKBWHyKOGha4nLDQ@mail.gmail.com>

--yV6uJEP2LqMMohoBe2hhfET2Ayo0vusWj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2018=E5=B9=B403=E6=9C=8806=E6=97=A5 18:12, Filipe Manana wrote:
> On Tue, Mar 6, 2018 at 8:15 AM, Qu Wenruo <wqu@suse.com> wrote:
>> There are some btrfs corruption report in mail list for a while,
>=20
> There have been for years (well, since ever) many reports of different
> types of corruptions.
> Which kind of corruption are you referring to?
>=20
>> although such corruption is pretty rare and almost impossible to
>> reproduce, with dm-log-writes we found it's highly related to v1 space=

>> cache.
>>
>> Unlike journal based filesystems, btrfs completely rely on metadata Co=
W
>> to protect itself from power loss.
>> Which needs extent allocator to avoid allocate extents on existing
>> extent range.
>> Btrfs also uses free space cache to speed up such allocation.
>>
>> However there is a problem, v1 space cache is not protected by data Co=
W,
>> and can be corrupted during power loss.
>> So btrfs do extra check on free space cache, verifying its own in-file=
 csum,
>> generation and free space recorded in cache and extent tree.
>>
>> The problem is, under heavy concurrency, v1 space cache can be corrupt=
ed
>> even under normal operations without power loss.
>=20
> How?
>=20
>> And we believe corrupted space cache can break btrfs metadata CoW and
>> leads to the rare corruption in next power loss.
>=20
> Which kind of corruption?
>=20
>>
>> The most obvious symptom will be difference in free space:
>>
>> This will be caught by kernel, but such check is quite weak, and if
>> the net free space change is 0 in one transaction, the corrupted
>> cache can be loaded by kernel.
>=20
> How can that happen? The only case I'm aware of, explained below,
> always leads to a difference (space cache has less free space then
> what we actually have if we check the extent tree).
>=20
>>
>> In this case, btrfs check would report things like :
>> ------
>> block group 298844160 has wrong amount of free space
>> failed to load free space cache for block group 298844160
>> ------
>=20
> This is normal, but not very common, due to tiny races that exists
> between committing a transaction (writing the free space caches) and
> running dellaloc for example (since reserving an extent while running
> dealloc doesn't joing/start a transaction).

Well, at least I didn't find any place to release space unprotected by
trans handler, so free space of cache can only be less or equal to real
free space.

So in that case, corrupted cache will never pass the free space check so
it will never be loaded.

Another dead end unfortunately.

Thanks,
Qu
>=20
>>
>> But considering the test case are using notreelog, btrfs won't do
>> sub-transaction commit which doesn't increase generation, each
>> transaction should be consistent, and nothing should be reported at al=
l.
>>
>> Further more, we can even found corrupted file extents like:
>> ------
>> root 5 inode 261 errors 100, file extent discount
>> Found file extent holes:
>>         start: 962560, len: 32768
>> ERROR: errors found in fs roots
>=20
> Why do you think that's a corruption? Does it cause data loss or any
> user visible issue?
>=20
> Having file extent holes not inserted happens when mixing buffered and
> direct IO writes to a file (and fsstress does that), for example:
>=20
> create file
> buffered write at offset 0, length 64K
> direct IO write at offset at offset 64K, length 4K
> transaction commit
> power loss
> after this we got a missing 64K hole extent at offset 0 (at
> btrfs_file_write_iter we only add hole extents if the start offset is
> greater then the current i_size)
>=20
> But this does not cause any problem for the user or the fs itself, and
> it's supposed to be like that in the NO_HOLES mode which one day
> (probably) will be the default mode.
>=20
>> ------
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  common/dmlogwrites  |  72 +++++++++++++++++++++++++++
>>  tests/btrfs/159     | 141 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  tests/btrfs/159.out |   2 +
>>  tests/btrfs/group   |   1 +
>>  4 files changed, 216 insertions(+)
>>  create mode 100755 tests/btrfs/159
>>  create mode 100644 tests/btrfs/159.out
>>
>> diff --git a/common/dmlogwrites b/common/dmlogwrites
>> index 467b872e..54e7e242 100644
>> --- a/common/dmlogwrites
>> +++ b/common/dmlogwrites
>> @@ -126,3 +126,75 @@ _log_writes_cleanup()
>>         $UDEV_SETTLE_PROG >/dev/null 2>&1
>>         _log_writes_remove
>>  }
>> +
>> +# Convert log writes mark to entry number
>> +# Result entry number is output to stdout, could be empty if not foun=
d
>> +_log_writes_mark_to_entry_number()
>> +{
>> +       local _mark=3D$1
>> +       local ret
>> +
>> +       [ -z "$_mark" ] && _fail \
>> +               "mark must be given for _log_writes_mark_to_entry_numb=
er"
>> +
>> +       ret=3D$($here/src/log-writes/replay-log --find --log $LOGWRITE=
S_DEV \
>> +               --end-mark $_mark 2> /dev/null)
>> +       [ -z "$ret" ] && return
>> +       ret=3D$(echo "$ret" | cut -f1 -d\@)
>> +       echo "mark $_mark has entry number $ret" >> $seqres.full
>> +       echo "$ret"
>> +}
>> +
>> +# Find next fua write entry number
>> +# Result entry number is output to stdout, could be empty if not foun=
d
>> +_log_writes_find_next_fua()
>> +{
>> +       local _start_entry=3D$1
>> +       local ret
>> +
>> +       if [ -z "$_start_entry" ]; then
>> +               ret=3D$($here/src/log-writes/replay-log --find --log $=
LOGWRITES_DEV \
>> +                       --next-fua 2> /dev/null)
>> +       else
>> +               ret=3D$($here/src/log-writes/replay-log --find --log $=
LOGWRITES_DEV \
>> +                       --next-fua --start-entry $_start_entry 2> /dev=
/null)
>> +       fi
>> +       [ -z "$ret" ] && return
>> +
>> +       ret=3D$(echo "$ret" | cut -f1 -d\@)
>> +       echo "next fua is entry number $ret" >> $seqres.full
>> +       echo "$ret"
>> +}
>> +
>> +# Replay log range to specified entry
>> +# $1:  End entry. The last entry will *NOT* be replayed
>> +# $2:  Start entry. If not specified, start from the first entry.
>> +_log_writes_replay_log_entry_range()
>> +{
>> +       local _end=3D$1
>> +       local _start=3D$2
>> +
>> +       [ -z "$_end" ] && _fail \
>> +       "end entry must be specified for _log_writes_replay_log_entry_=
range"
>> +
>> +       if [[ "$_start" && "$_start" -gt "$_end" ]]; then
>> +               _fail \
>> +               "wrong parameter order for _log_writes_replay_log_entr=
y_range:start=3D$_start end=3D$_end"
>> +       fi
>> +
>> +       # Original replay-log won't replay the last entry. So increase=
 entry
>> +       # number here to ensure the end entry to be replayed
>> +       if [ -z "$_start" ]; then
>> +               echo "=3D=3D=3D replay to $_end =3D=3D=3D" >> $seqres.=
full
>> +               $here/src/log-writes/replay-log --log $LOGWRITES_DEV \=

>> +                       --replay $SCRATCH_DEV --limit $_end -v \
>> +                       >> $seqres.full 2>&1
>> +       else
>> +               echo "=3D=3D=3D replay from $_start to $_end =3D=3D=3D=
" >> $seqres.full
>> +               $here/src/log-writes/replay-log --log $LOGWRITES_DEV \=

>> +                       --replay $SCRATCH_DEV --start-entry $_start \
>> +                       --limit $(($_end - $_start)) -v \
>> +                       >> $seqres.full 2>&1
>> +       fi
>> +       [ $? -ne 0 ] && _fail "replay failed"
>> +}
>> diff --git a/tests/btrfs/159 b/tests/btrfs/159
>> new file mode 100755
>> index 00000000..5113d526
>> --- /dev/null
>> +++ b/tests/btrfs/159
>> @@ -0,0 +1,141 @@
>> +#! /bin/bash
>> +# FS QA Test 159
>> +#
>> +# Test case for btrfs v1 space cache corruption
>> +#
>> +# Btrfs has some unexpected corruption after power loss, during the
>> +# investigation, the problem leads to v1 space cache corruption, whic=
h
>> +# could be loaded by kernel without detection.
>> +#
>> +# Kernel has 3 detection for corrupted space cache, checksum, generat=
ion
>> +# and free space, however the last one is a weak one. If in the one t=
ransaction
>> +# no net space change it can be loaded by kernel and break up metadat=
a CoW,
>> +# leading serious corruption.
>> +#
>> +#--------------------------------------------------------------------=
---
>> +# Copyright (c) SUSE.  All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation=
,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#--------------------------------------------------------------------=
---
>> +#
>> +
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=3D`pwd`
>> +tmp=3D/tmp/$$
>> +status=3D1       # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       rm -f $tmp.*
>> +       _log_writes_cleanup
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/dmlogwrites
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# Small workload is enough to trigger the problem
>> +workload=3D$(( 512 * $LOAD_FACTOR ))
>> +nr_threads=3D$(($($here/src/feature -o) * $LOAD_FACTOR))
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +_require_log_writes
>> +_require_scratch
>> +
>> +_log_writes_init
>> +_log_writes_mkfs >> $seqres.full 2>&1
>> +
>> +# Here we don't want to create space cache yet
>> +_log_writes_mount -o nospace_cache
>> +
>> +# The SINGLE profile data chunk created by mkfs is too small (8M) so =
btrfs
>> +# won't create space cache for it.
>> +# We need a data chunk large enough so btrfs create space cache for i=
t and
>> +# store the cache in itself.
>> +_run_btrfs_util_prog balance start --full-balance "$SCRATCH_MNT"
>> +
>> +_log_writes_unmount
>> +_log_writes_mark mkfs
>> +
>> +# Disable tree log, so btrfs will always do full transaction commit
>> +# It's OK to use tree log, but it will cause extra super block update=
 which
>> +# doesn't increase generation.
>> +_log_writes_mount -o space_cache=3Dv1,notreelog
>> +run_check $FSSTRESS_PROG -w -n $workload -p $nr_threads -d $SCRATCH_M=
NT \
>> +       $FSSTRESS_AVOID > /dev/null 2>&1
>> +_log_writes_unmount
>> +
>> +_log_writes_remove
>> +# Here we manually iterate through the log entries, as we need extra =
check
>> +# on the output of btrfs check. And we could have detailed replay log=
 in
>> +# $seqres.full
>> +prev=3D$(_log_writes_mark_to_entry_number mkfs)
>> +if [ -z "$prev" ]; then
>> +       _fail "failed to locate log writes mark 'mkfs'"
>> +fi
>> +
>> +# Here we only checks the result *AFTER* FUA writes, and no tree log,=
 so
>> +# everything should be valid.
>> +cur=3D$(_log_writes_find_next_fua $prev)
>> +[ -z "$cur" ] && _fail "failed to locate next fua write"
>> +
>> +# log-replay will not replay the last item, so manually increase it b=
y one
>> +cur=3D$(($cur + 1))
>> +
>> +_log_writes_replay_log_entry_range $prev >> $seqres.full 2>&1
>> +while [ ! -z "$cur" ]; do
>> +       _log_writes_replay_log_entry_range $cur $prev
>> +       # Catch the btrfs check output into temp file, as we need to
>> +       # grep the output to find the cache corruption
>> +       $BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV &> $tmp.=
fsck
>> +
>> +       # Cache passed generation,csum and free space check but corrup=
ted
>> +       # will be reported as error
>> +       if [ $? -ne 0 ]; then
>> +               cat $tmp.fsck >> $seqres.full
>> +               _fail "btrfs check found corruption"
>> +       fi
>> +
>> +       # Mount option has ruled out any possible factors affect space=
 cache
>> +       # And we are at the FUA writes, no generation related problem =
should
>> +       # happen anyway
>> +       if grep -q -e 'failed to load free space cache' $tmp.fsck; the=
n
>> +               cat $tmp.fsck >> $seqres.full
>> +               _fail "btrfs check found invalid space cache"
>> +       fi
>> +
>> +       prev=3D$cur
>> +       cur=3D$(_log_writes_find_next_fua $prev)
>> +       [ -z $cur ] && break
>> +
>> +       # Same as above
>> +       cur=3D$(($cur + 1))
>> +done
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/159.out b/tests/btrfs/159.out
>> new file mode 100644
>> index 00000000..e569e60c
>> --- /dev/null
>> +++ b/tests/btrfs/159.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 159
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index 8007e07e..bc83db94 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -161,3 +161,4 @@
>>  156 auto quick trim
>>  157 auto quick raid
>>  158 auto quick raid scrub
>> +159 auto
>> --
>> 2.15.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20


--yV6uJEP2LqMMohoBe2hhfET2Ayo0vusWj--

--AGcD8bWVq0fOchEy4mp9yELGaULHO3s8x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAlqehGwXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhZdwgAiyRrfOAj60awOUI43gVFIRwk
NRSQpvnqMrJFUXNPeL35Gj2vYQq05FLpCmzRnzBNLcQojoKPNVFyCu0RM3kszQ8n
KxK0ffdeg8eqVq4dzHteHuQVp7ZekBGHU0WFwDzBYqY3GaqO2zrGkGdRG9JvE/GV
CtVXjHxNHXAECfXMhYeetO/mlHN86jbKwxePEn7A231+xxBFvfhbIkm6ynmZe/oy
M6PdCM3jjx16FntNV7AHbox2r4zTK6MRy3/IjiF6NNaA9U5TsA9BD6h0L30gddHC
puTz3jXLc3gIwJK2f1DwVq9B+Ad8FbCD+LOEchwBAl2AW3N1vCpqIvh382J9Zw==
=p17a
-----END PGP SIGNATURE-----

--AGcD8bWVq0fOchEy4mp9yELGaULHO3s8x--
