Received: from mx2.suse.de ([195.135.220.15]:55076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727682AbfETI1C (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 20 May 2019 04:27:02 -0400
Subject: Re: [PATCH] src/attr_replace_test: limit size of extended attribute
 value
References: <20190517120653.22180-1-lhenriques@suse.com>
 <a7ca5248-89ce-6695-7809-9c2c483a5142@suse.com> <87o93xo7o1.fsf@suse.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <fa6146ed-e9c3-20da-0baa-36b9ceafbf8f@suse.com>
Date: Mon, 20 May 2019 11:27:00 +0300
MIME-Version: 1.0
In-Reply-To: <87o93xo7o1.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Luis Henriques <lhenriques@suse.com>
Cc: fstests@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>



On 20.05.19 =D0=B3. 11:24 =D1=87., Luis Henriques wrote:
> Nikolay Borisov <nborisov@suse.com> writes:
>=20
>> On 17.05.19 =D0=B3. 15:06 =D1=87., Luis Henriques wrote:
>>> The maximum size for extended attribute values is 65536 (XATTR_SIZE_M=
AX).
>>> Since there are filesystems that can set blksize to really big values
>>> (CephFS for example has a default of 4M), it's easy to have this test
>>> failing with fsetxattr returning -E2BIG.
>>>
>>> Cc: Darrick J. Wong <darrick.wong@oracle.com>
>>> Signed-off-by: Luis Henriques <lhenriques@suse.com>
>>> ---
>>>  src/attr_replace_test.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
>>> index 0720bfdc18ab..1ca9bf11ba58 100644
>>> --- a/src/attr_replace_test.c
>>> +++ b/src/attr_replace_test.c
>>> @@ -9,6 +9,7 @@
>>>  #include <sys/types.h>
>>>  #include <sys/xattr.h>
>>>  #include <sys/stat.h>
>>> +#include <linux/limits.h>
>>> =20
>>>  #define die() do { perror(""); \
>>>  fprintf(stderr, "error at line %d\n", __LINE__); \
>>> @@ -44,6 +45,8 @@ int main(int argc, char *argv[])
>>>  	size =3D sbuf.st_blksize * 3 / 4;
>>>  	if (!size)
>>>  		fail("Invalid st_blksize(%ld)\n", sbuf.st_blksize);
>>> +	if (size > XATTR_SIZE_MAX)
>>> +		size =3D XATTR_SIZE_MAX;
>>
>> nit: size =3D max(size, XATTRS_SIZE_MAX);
>=20
> Thanks, Nikolay.  But I can't find the definition of such macro or
> function.  I believe it's only available in kernel, right?  Also, you
> probably meant min() ;-)

Yeah, re min, but it seems there is a MIN/MAX macros provided in
<sys/param.h>. Anyway, as mentioned initially this is a minor point :) .

>=20
> Cheers,
>=20
