Received: from mout.gmx.net ([212.227.15.18]:46915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750842AbeCPFR3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 16 Mar 2018 01:17:29 -0400
Subject: Re: [PATCH RFC 3/3] fstests: generic: Check the fs after each FUA
 writes
References: <20180314090230.25055-1-wqu@suse.com>
 <20180314090230.25055-3-wqu@suse.com>
 <20180316040119.GN30836@localhost.localdomain>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <90382d48-0f21-d758-3896-467d8616d74b@gmx.com>
Date: Fri, 16 Mar 2018 13:17:07 +0800
MIME-Version: 1.0
In-Reply-To: <20180316040119.GN30836@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ReMyqjiEvHvmLTi5Hz5lQlmfxuGrnvC4t"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, amir73il@gmail.com
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ReMyqjiEvHvmLTi5Hz5lQlmfxuGrnvC4t
Content-Type: multipart/mixed; boundary="pRfQZZEWVRpGWpZs005rFKtyQMeeVuxXI";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Eryu Guan <guaneryu@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, amir73il@gmail.com
Message-ID: <90382d48-0f21-d758-3896-467d8616d74b@gmx.com>
Subject: Re: [PATCH RFC 3/3] fstests: generic: Check the fs after each FUA
 writes
References: <20180314090230.25055-1-wqu@suse.com>
 <20180314090230.25055-3-wqu@suse.com>
 <20180316040119.GN30836@localhost.localdomain>
In-Reply-To: <20180316040119.GN30836@localhost.localdomain>

--pRfQZZEWVRpGWpZs005rFKtyQMeeVuxXI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2018=E5=B9=B403=E6=9C=8816=E6=97=A5 12:01, Eryu Guan wrote:
> On Wed, Mar 14, 2018 at 05:02:30PM +0800, Qu Wenruo wrote:
>> Basic test case which triggers fsstress with dm-log-writes, and then
>> check the fs after each FUA writes.
>> With needed infrastructure and special handlers for journal based fs.
>=20
> It's not clear to me why the existing infrastructure is not sufficient
> for the test. It'd be great if you could provide more information and/o=
r
> background in commit log.

The main problem of current infrastructure is we don't have the
following things:

1) Way to take full advantage of dm-log-writes
   The main thing is, we don't have test cases to check each FUA (this
   patch) and flush (later patch after clearing all the RFC comments).

   We have some dm-flakey test cases to emulate power loss, but they are
   mostly for fsync.
   Here we are not only testing fsync, but also every superblock update.
   Which should be a super set of dm-flakey tests.

2) Workaround for journal replay
   In fact, if we only test btrfs, we don't even need such complicated
   work, just 'replay-log --fsck "btrfs check" --check fua' will be
   enough. As btrfs check doesn't report dirty journal (log tree) as
   problem.
   But for journal based fses, their fsck all report dirty journal as
   error, which needs current snapshot works to replay them before
   running fsck.

I would add them in next version if there is no extra comment on this.

>=20
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> In my test, xfs and btrfs survives while ext4 would report error durin=
g fsck.
>>
>> My current biggest concern is, we abuse $TEST_DEV and mkfs on it all b=
y
>> ourselves. Not sure if it's allowed.
>=20
> As Amir already replied, that's not allowed, any destructive operations=

> should be done on $SCRATCH_DEV.

Yep, I'm looking for similar case who uses $SCRATCH_DEV as LVM pv do get
extra device.

Or can we reuse the scratch_dev_pool even for ext4/xfs?

>=20
>> ---
>>  common/dmlogwrites    | 119 +++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  tests/generic/481     | 124 +++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  tests/generic/481.out |   2 +
>>  tests/generic/group   |   1 +
>>  4 files changed, 246 insertions(+)
>>  create mode 100755 tests/generic/481
>>  create mode 100644 tests/generic/481.out
>>
>> diff --git a/common/dmlogwrites b/common/dmlogwrites
>> index 467b872e..258f5887 100644
>> --- a/common/dmlogwrites
>> +++ b/common/dmlogwrites
>> @@ -126,3 +126,122 @@ _log_writes_cleanup()
>>  	$UDEV_SETTLE_PROG >/dev/null 2>&1
>>  	_log_writes_remove
>>  }
>> +
>> +# Convert log writes mark to entry number
>> +# Result entry number is output to stdout, could be empty if not foun=
d
>> +_log_writes_mark_to_entry_number()
>> +{
>> +	local _mark=3D$1
>=20
> No need to name a local variable with leading underscore.
>=20
>> +	local ret
>> +
>> +	[ -z "$_mark" ] && _fatal \
>> +		"mark must be given for _log_writes_mark_to_entry_number"
>=20
> Please use _fail instead of _fatal (and all the other places in this
> patch). I think _fatal is only used at the initializing phase of the
> test harness (e.g. check required tools, env etc.) and abort the test
> run in early stage. _fail is used to indicate a failure in test phase,
> it also logs the error messages in $seqres.full.

Glad to know the difference.

>=20
>> +
>> +	ret=3D$($here/src/log-writes/replay-log --find --log $LOGWRITES_DEV =
\
>> +		--end-mark $_mark 2> /dev/null)
>=20
> Is this output long or short? If it's a short one, e.g. a number or a
> simple string, I think it's OK to save it in a variable. But if it's
> long/complex enough and/or has multiple lines, I think we'd better to
> save it with a tmp file, e.g. $tmp.<suffix>.

Very very short, just one line like '1024@2048'.

>=20
>> +	[ -z "$ret" ] && return
>> +	ret=3D$(echo "$ret" | cut -f1 -d\@)
>=20
> Because I want to avoid echoing such a variable to a pipe (even it's
> quoted), it used to cause subtle problems if not quoted properly.
>=20
> Also, it'd be better to give a sample output of the replay-log command
> in comment if it's short enough, so people could have an idea what it
> looks like and know what you're looking for in the subsequent steps
> (cut -f1 -d\@, in this example), and it's easier to review.
>=20
> Above comments apply to other helper functions too.
>=20
> Thanks for all the work!

Thanks for your review too,
Qu

>=20
> Eryu
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--pRfQZZEWVRpGWpZs005rFKtyQMeeVuxXI--

--ReMyqjiEvHvmLTi5Hz5lQlmfxuGrnvC4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAlqrU1MXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qiRsggAkVs2E1MLqHGsiyt07LJzEhxZ
tJv3Be7Q7tLBQLS4e5a79RHIVx6fPB8G+cVZreM4QqKvs75r52TEwKIpjPowrxcV
SmxLGi3ZNxyez8RdNFzTSCCzOiIArD5Tr5FY+tKMnUwKwCOJgvXH/Iz98DfXOyhv
cBkZOckz/xcGEVWSlCXgdn1tBRzIp1HR25f3RmVfDFYuOkEcOcuT8xDldUEEhNPu
/Su1GgnxlVUI9LbvJRmTVTJcwfsDHtCvou53LfvvBokgp6WCJwp6XExKiItuwK5i
ZaThDuiNhWD9lG5Nabt00Tok2hSGVqFsOL1Awtt33YCZvOHbqhLhEKzBVkt2vw==
=eOST
-----END PGP SIGNATURE-----

--ReMyqjiEvHvmLTi5Hz5lQlmfxuGrnvC4t--
