Received: from mx2.suse.de ([195.135.220.15]:44498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726611AbfC1VhW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Mar 2019 17:37:22 -0400
Subject: Re: [PATCH 5/7] fsstress: allow afsync on directories too
From: Nikolay Borisov <nborisov@suse.com>
References: <20190328185458.29033-1-fdmanana@kernel.org>
 <97f7c0b6-2b44-803c-b0c7-8f627a42b89d@suse.com>
Message-ID: <27d50606-45bd-331e-1ab0-511990639f12@suse.com>
Date: Thu, 28 Mar 2019 23:37:19 +0200
MIME-Version: 1.0
In-Reply-To: <97f7c0b6-2b44-803c-b0c7-8f627a42b89d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>



On 28.03.19 =D0=B3. 23:36 =D1=87., Nikolay Borisov wrote:
>=20
>=20
> On 28.03.19 =D0=B3. 20:54 =D1=87., fdmanana@kernel.org wrote:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> Currently the afsync function can only be performed against regular fi=
les.
>> Allow it to operate on directories too, to increase test coverage and =
allow
>> for chances of finding bugs in the filesystem implementation of fsync
>> against directories.
>>
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> ---
>>  ltp/fsstress.c | 24 ++++++++++++++++--------
>>  1 file changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
>> index ffe78ef7..0fb9e399 100644
>> --- a/ltp/fsstress.c
>> +++ b/ltp/fsstress.c
>> @@ -1767,15 +1767,21 @@ afsync_f(int opno, long r)
>>  	struct iocb	iocb;
>>  	struct iocb	*iocbs[] =3D { &iocb };
>>  	struct io_event	event;
>> +	DIR             *dir =3D NULL;
>> =20
>>  	init_pathname(&f);
>> -	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
>> +	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, NULL, &v)) {
>=20
> s/FT_DIRm/FT_DIR/

Bummer, FT_DIRm is defined to FT_DIR.... disregard this...

>=20
>>  		if (v)
>>  			printf("%d/%d: afsync - no filename\n", procid, opno);
>>  		free_pathname(&f);
>>  		return;
>>  	}
>>  	fd =3D open_path(&f, O_WRONLY | O_DIRECT);
>> +	if (fd < 0 && errno =3D=3D EISDIR) {
>> +		dir =3D opendir_path(&f);
>> +		if (dir)
>> +			fd =3D dirfd(dir);
>> +	}
>>  	e =3D fd < 0 ? errno : 0;
>>  	check_cwd();
>>  	if (fd < 0) {
>> @@ -1783,6 +1789,8 @@ afsync_f(int opno, long r)
>>  			printf("%d/%d: afsync - open %s failed %d\n",
>>  			       procid, opno, f.path, e);
>>  		free_pathname(&f);
>> +		if (dir)
>> +			closedir(dir);
>>  		return;
>>  	}
>> =20
>> @@ -1791,24 +1799,24 @@ afsync_f(int opno, long r)
>>  		if (v)
>>  			printf("%d/%d: afsync - io_submit %s %d\n",
>>  			       procid, opno, f.path, e);
>> -		free_pathname(&f);
>> -		close(fd);
>> -		return;
>> +		goto out;
>>  	}
>>  	if ((e =3D io_getevents(io_ctx, 1, 1, &event, NULL)) !=3D 1) {
>>  		if (v)
>>  			printf("%d/%d: afsync - io_getevents failed %d\n",
>>  			       procid, opno, e);
>> -		free_pathname(&f);
>> -		close(fd);
>> -		return;
>> +		goto out;
>>  	}
>> =20
>>  	e =3D event.res2;
>>  	if (v)
>>  		printf("%d/%d: afsync %s %d\n", procid, opno, f.path, e);
>> +out:
>>  	free_pathname(&f);
>> -	close(fd);
>> +	if (dir)
>> +		closedir(dir);
>> +	else
>> +		close(fd);
>>  #endif
>>  }
>> =20
>>
>=20
