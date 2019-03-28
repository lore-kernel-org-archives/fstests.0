Received: from mx2.suse.de ([195.135.220.15]:33916 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727684AbfC1Pke (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Mar 2019 11:40:34 -0400
Subject: Re: [PATCH] fstests: Don't delete seqres.full file in generic/077
References: <20190326150158.17700-1-nborisov@suse.com>
 <20190326154635.GC6537@magnolia>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <fa0d0273-e654-c23e-e1e8-8797bfa4e78e@suse.com>
Date: Thu, 28 Mar 2019 17:40:31 +0200
MIME-Version: 1.0
In-Reply-To: <20190326154635.GC6537@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: guaneryu@gmail.com
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 26.03.19 =D0=B3. 17:46 =D1=87., Darrick J. Wong wrote:
> On Tue, Mar 26, 2019 at 05:01:58PM +0200, Nikolay Borisov wrote:
>> When this test finishes there is no 079.full file with output from com=
mands.=20
>=20
> "077.full" ?

Eryu, would you fold this when merging or shall I resend?

>=20
>> Sometimes this information is useful for post mortem so stop deleting =
the=20
>> file upon test completion.=20
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>=20
> Looks ok to me otherwise,
>=20
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
>=20
>> ---
>>  tests/generic/077 | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/tests/generic/077 b/tests/generic/077
>> index 284e25253c9e..d11b49c6ff15 100755
>> --- a/tests/generic/077
>> +++ b/tests/generic/077
>> @@ -73,6 +73,5 @@ cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&=
1
>>  _check_scratch_fs
>> =20
>>  echo "*** all done"
>> -rm -f $seqres.full
>=20
> I had wondered about this myself... :)
>=20
> --D
>=20
>>  status=3D0
>>  exit
>> --=20
>> 2.7.4
>>
>=20
