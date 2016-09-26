Received: from mx2.suse.de ([195.135.220.15]:33304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030317AbcIZNNq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Sep 2016 09:13:46 -0400
Subject: Re: [PATCH] check: check SCRATCH_MNT before calling _scratch_mkfs
References: <81e70e43-b337-acca-1c29-69db4f3a3cfa@jeffm.io>
 <20160926044443.GA2532@dastard>
From: Jeff Mahoney <jeffm@suse.com>
Message-ID: <20fd4981-a27f-ebba-705f-f479e79b6143@suse.com>
Date: Mon, 26 Sep 2016 09:13:37 -0400
MIME-Version: 1.0
In-Reply-To: <20160926044443.GA2532@dastard>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="03Kd28GK0rxeg3b82po9vhEha0b7TDasx"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--03Kd28GK0rxeg3b82po9vhEha0b7TDasx
Content-Type: multipart/mixed; boundary="c35iKPKgqPnjgIs6Ka4LudMLifjFb4teW";
 protected-headers="v1"
From: Jeff Mahoney <jeffm@suse.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Message-ID: <20fd4981-a27f-ebba-705f-f479e79b6143@suse.com>
Subject: Re: [PATCH] check: check SCRATCH_MNT before calling _scratch_mkfs
References: <81e70e43-b337-acca-1c29-69db4f3a3cfa@jeffm.io>
 <20160926044443.GA2532@dastard>
In-Reply-To: <20160926044443.GA2532@dastard>

--c35iKPKgqPnjgIs6Ka4LudMLifjFb4teW
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 9/26/16 12:44 AM, Dave Chinner wrote:
> On Sun, Sep 25, 2016 at 09:44:13PM -0400, Jeff Mahoney wrote:
>> On NFS or Overlayfs, "mkfs" turns into rm -rf $SCRATCH_MNT/*
>>
>> There is no warning/error in check if SCRATCH_MNT is unset.
>>
>> Also add the checks to _scratch_cleanup_files.
>>
>> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>> ---
>>  check     | 12 ++++++++++++
>>  common/rc |  8 ++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/check b/check
>> index 69341d8..b22d2df 100755
>> --- a/check
>> +++ b/check
>> @@ -512,6 +512,18 @@ for section in $HOST_OPTIONS_SECTIONS; do
>>  	needwrap=3Dtrue
>> =20
>>  	if [ ! -z "$SCRATCH_DEV" ]; then
>> +	   if [ -z "$SCRATCH_MNT" ]
>> +	    then
>> +		echo "\$SCRATCH_MNT is unset"
>> +		status=3D1
>> +		exit
>> +	    fi
>> +	   if [ ! -d "$SCRATCH_MNT" ]
>> +	    then
>> +		echo "\$SCRATCH_MNT is not a dir"
>> +		status=3D1
>> +		exit
>> +	    fi
>=20
> That is supposed to be checked in get_next_config() at the start of
> the loop. It runs these checks on the scratch config:
>=20
> 	_check_device SCRATCH_DEV optional $SCRATCH_DEV
> 	if [ ! -z "$SCRATCH_MNT" -a ! -d "$SCRATCH_MNT" ]; then
> 		echo "common/config: Error: \$SCRATCH_MNT ($SCRATCH_MNT) is not a dir=
ectory"
> 		exit 1
> 	fi

But that only presents an error if SCRATCH_MNT isn't empty.  If it is,
we skip happily past.

> If SCRATCH_DEV/SCRATCH_MNT is not set - which is a valid config -

SCRATCH_DEV without SCRATCH_MNT isn't a valid config, though.  That
=2E/check assumes that SCRATCH_DEV being valid means SCRATCH_MNT is too i=
s
the source of the problem.  The test in get_next_config would prevent
the problem if we replaced the ! -z "$SCRATCH_MNT" with ! -z "$SCRATCH_DE=
V"

> the all that is supposed to happen is that tests which call
> _require_scratch() should not run. This, in turn should prevent

=2E.. but _require_scratch doesn't run in ./check.  The individual test
cases are safe because _require_scratch runs there and does check.
=2E/check just checks to see if $SCRATCH_DEV is set and then calls
_scratch_mkfs without checking $SCRATCH_MNT.  Since _scratch_mkfs
doesn't check either, boom.

> the mkfs->rm problem you mention. The above code in
> get_next_config() is what needs fixing, not the check code...

In ./check, sure.  Fixing get_next_config does work as well.  I think
I'd like to keep the checks in _scratch_cleanup_files though so we don't
accidentally trip over that elsewhere.

> How did you actually trip over this?  I'm guessing you have a config
> problem where you are defining SCRATCH_DEV but not SCRATCH_MNT?
> Or you didn't set SCRATCH_DEV_NOT_USED?

Yeah, it's definitely a config problem.  SCRATCH_DEV was defined but I'd
defined SCRATCH_DIR instead of SCRATCH_MNT. Unfortunately, it's one I
discovered after "rm -rf /*" made it through to my autofs mount and
started working there.

-Jeff

--=20
Jeff Mahoney
SUSE Labs


--c35iKPKgqPnjgIs6Ka4LudMLifjFb4teW--

--03Kd28GK0rxeg3b82po9vhEha0b7TDasx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJX6R8EAAoJEB57S2MheeWyE3kP/1ccnqGBLUW7pxE+DlZm7RHG
sVd4MwLPzWoRXmx9U5IbKBCfFbpAEvW60tLra76JcDvaNX8YwuDa4g/RqHl2waOa
6vrCrGAC878FrfM2FxsxG8gMAcwLQ2CuhwaCboOGAt355YOyN6ypEXxEdXuPAHyd
pUnII9y5QYP8rWwPFD/HUQJmpjni6k8O4paPC17zHoPQ9BEo8hFZNqiMvU2x217u
5u1Wfu1UlReP5Fvbpj9EYYs71SAT/t3q75c7mLhxHqFkOkzt4b4e2VvvzuQvG0h6
O57jT7IHCTW/zQomrozG5k4+YiAAL+08ModYJ0SnBj78rRamCMeEU3Uopp//OyMT
cF+8UmfnVicMWgtGzGPoq685PfuoBJ5BEUInWcxOjiUs5U3ZhVIymstmx7jU4xcH
PWTBZluYkxvubdPUW75p4LJ0XRhRHue/e0+q4LhQ4XSCyPTvc1j3/5ErJvRG7Kqx
hXxDx7DWFD9l/wo9V0lLDymykENP8Pn/i/QqWFQSIdGI/jOwHSvOIBRqiOxj/347
DPTtu2OU+XaWsAkRzS8JCgOmTb17vjfzDfEpr2wxtRZkZ9XA2Hk4mmQfD86ns+d/
Jx4oKq1Ny6a/ulPmzTNzXQ32oTilpBjp7Xcer7bFUheKRmA3/DqxJ5MWIx3WJWJs
y6wF19hc0iMeoqOdy/UO
=zI04
-----END PGP SIGNATURE-----

--03Kd28GK0rxeg3b82po9vhEha0b7TDasx--
