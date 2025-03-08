Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C0F13CA9C
	for <fstests@vger.kernel.org>; Sat,  8 Mar 2025 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741476098; cv=none; b=DKKhpPaSS00Rc/JsaXcEaxiX31kp9U9yqvlhU9mmyMHQSuJK+WzZFo4R6JSUV7Z2gYdP6ss0TBGSmzd5b7izI6u0daMEPH5b4HcPik/6A72ThaWJZYIaIu6rTznQU1VnbpyLep+FuBmjY5ClVFFq962o8Fjl34C9FTaIJa1KA4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741476098; c=relaxed/simple;
	bh=nsUUp8KlciM7/6HP/ngCcyZkDNImY3a6iVxKtWBz8nU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ocy1mcM0fxXongQumFOBGQ7n4viGPD/cEYzji0/++67URfAjimOawLcx12gB/xwmNxV20M1iGQbObpzLSMEu9h9qRR7yu2aj84uXCwp9m7EdJljMPAZt/ev9He8kElgAV7jk8IGziAmrcjt3d1Iy/qV/lNai5YfKziQ04I3aM9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=p/nLTJcD; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="p/nLTJcD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eyPX+H/lf1U77L8vdssSS4ONqFgePY63WET+slVpalc=; b=p/nLTJcDBEMC+b11916PyHc5fm
	ZDMD4ECU2kPkJuFplD6b1PujOQMEINFwL22Q4csMhSDxF37lfzoNUC6uJatuOCvhpFtd8gZmW0SJy
	BWIYU2ulNCRirKLvJScAWPLT219p8D9A5ZPyN2BGMxMcC/kqkxN1Y/+vcblCssrN9AQwNec4/g1J5
	9RyGHDqZiyosSIpP0eFhFAZZRlAfWgXnq3grpunBdblyMojOBWgax8yEK9P3JlpqF3H8fqhVgHkNM
	uiPyI0i+JKj/RIWy3cW2/uD+7LX7i/VwrWIr4YJPadhm665KpIVke2fUegqCiHBd5ROylRuAZTdx8
	h+TEEWoQ==;
Received: from bl21-65-244.dsl.telepac.pt ([2.82.65.244] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tr3Tr-005xd0-Sq; Sun, 09 Mar 2025 00:21:25 +0100
From: Luis Henriques <luis@igalia.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] src: include libgen.h for function basename() if
 not using GNU libc
In-Reply-To: <875xkox3y9.fsf@igalia.com> (Luis Henriques's message of "Tue, 04
	Mar 2025 14:31:26 +0000")
References: <20250304122119.21412-1-luis@igalia.com>
	<20250304122119.21412-2-luis@igalia.com>
	<20250304140530.o46rs3tad6eqqprh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
	<875xkox3y9.fsf@igalia.com>
Date: Sat, 08 Mar 2025 23:21:19 +0000
Message-ID: <87zfhvglcg.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zorro,

On Tue, Mar 04 2025, Luis Henriques wrote:

> On Tue, Mar 04 2025, Zorro Lang wrote:
>
>> On Tue, Mar 04, 2025 at 12:21:18PM +0000, Luis Henriques wrote:
>>> Compiling fstests on a system without the GNU libc fails because the
>>> basename() is defined in libgen.h by POSIX and not in string.h.
>>>=20
>>> Fix that by including the libgen.h header if __USE_GNU isn't defined.
>>>=20
>>> Signed-off-by: Luis Henriques <luis@igalia.com>
>>> ---
>>>  src/aio-dio-regress/aio-dio-append-write-read-race.c | 3 +++
>>>  src/splice-test.c                                    | 3 +++
>>>  src/t_ext4_dax_inline_corruption.c                   | 3 +++
>>>  src/t_ext4_dax_journal_corruption.c                  | 3 +++
>>>  src/t_mmap_collision.c                               | 3 +++
>>>  src/t_mmap_dio.c                                     | 3 +++
>>>  6 files changed, 18 insertions(+)
>>>=20
>>> diff --git a/src/aio-dio-regress/aio-dio-append-write-read-race.c b/src=
/aio-dio-regress/aio-dio-append-write-read-race.c
>>> index d9f8982f007c..1a0c8e99c61f 100644
>>> --- a/src/aio-dio-regress/aio-dio-append-write-read-race.c
>>> +++ b/src/aio-dio-regress/aio-dio-append-write-read-race.c
>>> @@ -19,6 +19,9 @@
>>>  #include <sys/stat.h>
>>>  #include <fcntl.h>
>>>  #include <errno.h>
>>> +#ifndef __USE_GNU
>>> +#include <libgen.h>
>>> +#endif
>>
>> Do you use clang and musl to build fstests? I'm even not sure if fstests
>> can be built with them :)=20
>
> Yes, I'm able to compile and run fstests using gcc (not clang) and musl.
> Though there's a hack I still need to use to compile, which is to define
> CFLAGS=3D"-D_LARGEFILE64_SOURCE".  Since that doesn't require changing
> anything, I haven't yet investigated how that could be fixed.
>
>> I don't have experience on this part, but I don't mind letting fstests
>> to be supported by other libc. The patch looks safe for current users.
>>
>> If anyone has this experience, please feel free to review. I'll think
>> about merging this patch if no objection from others.
>
> The only links I can provide you with some extra info are [1] (section
> about basename) and the basename(3) man page.  Looking at it again makes
> me think that including libgen.h unconditionally should also be OK,
> forcing the POSIX implementation to be used instead.  But using this
> #ifndef seems to be used in other projects.
>

Please hold on this patch as I think some of the changes are broken.  The
POSIX basename() is a bit different from the GNU version, and needs to be
handled with a bit more care.  I'll resend this later in a few days.

(But feel free to pick the second patch, as I believe it's still a valid
fix.)

Cheers,
--=20
Lu=C3=ADs

> And thanks, Zorro, for your review!
>
> [1] https://www.gnu.org/software/libc/manual/html_node/Finding-Tokens-in-=
a-String.html
>
> Cheers,
> --=20
> Lu=C3=ADs
>
>>
>> Thanks,
>> Zorro
>>
>>>=20=20
>>>  #include <libaio.h>
>>>  #include <pthread.h>
>>> diff --git a/src/splice-test.c b/src/splice-test.c
>>> index eb8636738064..e6753a15dc47 100644
>>> --- a/src/splice-test.c
>>> +++ b/src/splice-test.c
>>> @@ -18,6 +18,9 @@
>>>  #include <string.h>
>>>  #include <errno.h>
>>>  #include <malloc.h>
>>> +#ifndef __USE_GNU
>>> +#include <libgen.h>
>>> +#endif
>>>=20=20
>>>  unsigned int sector_size;
>>>  unsigned int buffer_size;
>>> diff --git a/src/t_ext4_dax_inline_corruption.c b/src/t_ext4_dax_inline=
_corruption.c
>>> index e1a39a6c1e46..a6cb768512fc 100644
>>> --- a/src/t_ext4_dax_inline_corruption.c
>>> +++ b/src/t_ext4_dax_inline_corruption.c
>>> @@ -10,6 +10,9 @@
>>>  #include <sys/types.h>
>>>  #include <time.h>
>>>  #include <unistd.h>
>>> +#ifndef __USE_GNU
>>> +#include <libgen.h>
>>> +#endif
>>>=20=20
>>>  #define PAGE(a) ((a)*0x1000)
>>>  #define STRLEN 256
>>> diff --git a/src/t_ext4_dax_journal_corruption.c b/src/t_ext4_dax_journ=
al_corruption.c
>>> index ba7a96e43559..4e5762d77058 100644
>>> --- a/src/t_ext4_dax_journal_corruption.c
>>> +++ b/src/t_ext4_dax_journal_corruption.c
>>> @@ -10,6 +10,9 @@
>>>  #include <sys/types.h>
>>>  #include <time.h>
>>>  #include <unistd.h>
>>> +#ifndef __USE_GNU
>>> +#include <libgen.h>
>>> +#endif
>>>=20=20
>>>  #define PAGE(a) ((a)*0x1000)
>>>  #define STRLEN 256
>>> diff --git a/src/t_mmap_collision.c b/src/t_mmap_collision.c
>>> index c872f4e26940..638424d2e619 100644
>>> --- a/src/t_mmap_collision.c
>>> +++ b/src/t_mmap_collision.c
>>> @@ -24,6 +24,9 @@
>>>  #include <sys/stat.h>
>>>  #include <sys/types.h>
>>>  #include <unistd.h>
>>> +#ifndef __USE_GNU
>>> +#include <libgen.h>
>>> +#endif
>>>=20=20
>>>  void *dax_data;
>>>  int nodax_fd;
>>> diff --git a/src/t_mmap_dio.c b/src/t_mmap_dio.c
>>> index 6c8ca1a39181..342e2c6deb4b 100644
>>> --- a/src/t_mmap_dio.c
>>> +++ b/src/t_mmap_dio.c
>>> @@ -14,6 +14,9 @@
>>>  #include <libaio.h>
>>>  #include <errno.h>
>>>  #include <sys/time.h>
>>> +#ifndef __USE_GNU
>>> +#include <libgen.h>
>>> +#endif
>>>=20=20
>>>  void usage(char *prog)
>>>  {
>>>=20
>>
>

