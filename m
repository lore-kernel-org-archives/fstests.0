Received: from mx2.suse.de ([195.135.220.15]:52001 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933362AbcI0Osk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 27 Sep 2016 10:48:40 -0400
Subject: Re: [PATCH] check: check SCRATCH_MNT before calling _scratch_mkfs
References: <81e70e43-b337-acca-1c29-69db4f3a3cfa@jeffm.io>
 <20160926044443.GA2532@dastard>
 <20fd4981-a27f-ebba-705f-f479e79b6143@suse.com>
 <20160926221058.GB2532@dastard>
From: Jeff Mahoney <jeffm@suse.com>
Message-ID: <aa470df3-4768-0dc7-644c-2039376b4827@suse.com>
Date: Tue, 27 Sep 2016 10:48:34 -0400
MIME-Version: 1.0
In-Reply-To: <20160926221058.GB2532@dastard>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bvSJMQ9c4t8nFoeba8bFMwDX66KI39uJN"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bvSJMQ9c4t8nFoeba8bFMwDX66KI39uJN
Content-Type: multipart/mixed; boundary="Wj2GSki9tsl2lPSplTv7795knGW3rXs20";
 protected-headers="v1"
From: Jeff Mahoney <jeffm@suse.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Message-ID: <aa470df3-4768-0dc7-644c-2039376b4827@suse.com>
Subject: Re: [PATCH] check: check SCRATCH_MNT before calling _scratch_mkfs
References: <81e70e43-b337-acca-1c29-69db4f3a3cfa@jeffm.io>
 <20160926044443.GA2532@dastard>
 <20fd4981-a27f-ebba-705f-f479e79b6143@suse.com>
 <20160926221058.GB2532@dastard>
In-Reply-To: <20160926221058.GB2532@dastard>

--Wj2GSki9tsl2lPSplTv7795knGW3rXs20
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 9/26/16 6:10 PM, Dave Chinner wrote:
> On Mon, Sep 26, 2016 at 09:13:37AM -0400, Jeff Mahoney wrote:
>> On 9/26/16 12:44 AM, Dave Chinner wrote:
>>> On Sun, Sep 25, 2016 at 09:44:13PM -0400, Jeff Mahoney wrote:
>>>> On NFS or Overlayfs, "mkfs" turns into rm -rf $SCRATCH_MNT/*
>>>>
>>>> There is no warning/error in check if SCRATCH_MNT is unset.
>>>>
>>>> Also add the checks to _scratch_cleanup_files.
>>>>
>>>> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>>>> ---
>>>>  check     | 12 ++++++++++++
>>>>  common/rc |  8 ++++++++
>>>>  2 files changed, 20 insertions(+)
>>>>
>>>> diff --git a/check b/check
>>>> index 69341d8..b22d2df 100755
>>>> --- a/check
>>>> +++ b/check
>>>> @@ -512,6 +512,18 @@ for section in $HOST_OPTIONS_SECTIONS; do
>>>>  	needwrap=3Dtrue
>>>> =20
>>>>  	if [ ! -z "$SCRATCH_DEV" ]; then
>>>> +	   if [ -z "$SCRATCH_MNT" ]
>>>> +	    then
>>>> +		echo "\$SCRATCH_MNT is unset"
>>>> +		status=3D1
>>>> +		exit
>>>> +	    fi
>>>> +	   if [ ! -d "$SCRATCH_MNT" ]
>>>> +	    then
>>>> +		echo "\$SCRATCH_MNT is not a dir"
>>>> +		status=3D1
>>>> +		exit
>>>> +	    fi
>>>
>>> That is supposed to be checked in get_next_config() at the start of
>>> the loop. It runs these checks on the scratch config:
>>>
>>> 	_check_device SCRATCH_DEV optional $SCRATCH_DEV
>>> 	if [ ! -z "$SCRATCH_MNT" -a ! -d "$SCRATCH_MNT" ]; then
>>> 		echo "common/config: Error: \$SCRATCH_MNT ($SCRATCH_MNT) is not a d=
irectory"
>>> 		exit 1
>>> 	fi
>>
>> But that only presents an error if SCRATCH_MNT isn't empty.  If it is,=

>> we skip happily past.
>>
>>> If SCRATCH_DEV/SCRATCH_MNT is not set - which is a valid config -
>>
>> SCRATCH_DEV without SCRATCH_MNT isn't a valid config, though.  That
>> ./check assumes that SCRATCH_DEV being valid means SCRATCH_MNT is too =
is
>> the source of the problem.  The test in get_next_config would prevent
>> the problem if we replaced the ! -z "$SCRATCH_MNT" with ! -z "$SCRATCH=
_DEV"
>=20
> Because SCRATCH_DEV is optional, the check for SCRATCH_MNT in
> get_next_config() needs to take that into account. i.e. if
> SCRATCH_DEV is set, then SCRATCH_MNT must be set, too.

Yep.  I'll post an updated patch that does that.

>>> the all that is supposed to happen is that tests which call
>>> _require_scratch() should not run. This, in turn should prevent
>>
>> ... but _require_scratch doesn't run in ./check.  The individual test
>> cases are safe because _require_scratch runs there and does check.
>> ./check just checks to see if $SCRATCH_DEV is set and then calls
>> _scratch_mkfs without checking $SCRATCH_MNT.  Since _scratch_mkfs
>> doesn't check either, boom.
>=20
> Yes, I know. That's why it should be checked in get_next_config() -
> it is supposed to catch any config errors before they get used
> anywhere.
>=20
> It makes no sense to sprinkle random "is the config valid" checks
> throughout the code. We should validate the config once - and once
> only - before we run anything. Then we can assume (correctly) the
> config is valid everywhere else.

In general, I agree.  But when the end result for a missing value is rm
-rf /*, I don't think it's overkill.  A mkfs with a missing value isn't
going to accidentally mkfs everything.

-Jeff

--=20
Jeff Mahoney
SUSE Labs


--Wj2GSki9tsl2lPSplTv7795knGW3rXs20--

--bvSJMQ9c4t8nFoeba8bFMwDX66KI39uJN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJX6obCAAoJEB57S2MheeWy6ngP/07OzkOH4wyJAEXiXbA6eLR7
/KhvOgUOsKBhBEcNl9/cRn7BlSeVxEDgpwW3LQKv26rxJEYAACqgsLrSs3ESibXp
MwvKociyjEZpyTbnl4JD8FEwfCrMQmQIRgceFRVxunfHwP6bd+jd4QnYnw+JtYnb
OuudelfX6oVtn+dLkycVWMTW9jLS7/e2nM9LBBeYYyYoVPR+sJoS3aoKH7fJIaub
GnXvjyzNNeAzMF9iVzhDFHM8F3Dk72ngykhF7x+nQrjDTP9indiBy8CLXv2LS/hw
tt0NZGQpDr2nt2DlOTLxaswAYJjM2rkG/lCaFOV6IWBStMtA51o8n8nIccwkTL4v
pYJst7dAtNHWL2Z0xscf+rURPJ6hRY77GZhpWru2F+t2MwmJExBjQ7DJIzQR7eh/
bBav9l4W8w8mm1aaemADkj4BNiHrP45XC/6Rd3l+ZABH5riuQvNrCtDb7NcucV9s
X6mm7QXm39ze0kCjsxZoyn62xVU6yU+4uRMVJGpR6BTxZMDB18yPjv/LYiAG33PZ
ig8B/sX5Wxm//fqWYYNzu8/SK+TZ5Iqlgf91bPuJfbxdToM9HZmgxiGl/1xSC7E+
iNJjquQJaq+NzeqKUMmN8VluYzCqwoVjTq3jvc+KwsvBPQpripIwgtQ4MHM2+hg+
MHmAmKVlJWCxdZz0NpJC
=Q4tP
-----END PGP SIGNATURE-----

--bvSJMQ9c4t8nFoeba8bFMwDX66KI39uJN--
