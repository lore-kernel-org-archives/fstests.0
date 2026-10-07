Received: from mx0.herbolt.com (mx0.herbolt.com [5.59.97.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5743E5594;
	Wed,  7 Oct 2026 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.59.97.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394231; cv=none; b=WDnh4WJWURpbha3JW+fN7i+Vl53U+ZKV/IUvFB5bZRlq5cjX2f3Y/3+Ajn8mS4OkK8HqFJV6O9dInUPbFBC35OGgQ3Uxfgk5SXVJC7CxaeIJRUcUQKbwJ6XEAnu430GUi9WGk10u48RG90lfoaCu807utKbQFo3VX8yUBIphTGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394231; c=relaxed/simple;
	bh=fwlDIlTXOae9JDjEefhdo5FnEXikvPnPHf/8YMhFz88=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lujs/iQUOFW8KMbLixfDJ2ekmjHXs0tINNVzhIYpenTAgT4cV0yPEVAlSci55ZkLVCrR/pgJOzO88yIg25d8fJ+8o4V9iQKfQ17BWuZTe4x2+wnKJ3z9OEMKkZl3TaUKuQLS4b/vIZ7iZlPWuLmzjLiseI+N59aAcV2ksFSLq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com; spf=pass smtp.mailfrom=herbolt.com; arc=none smtp.client-ip=5.59.97.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbolt.com
Received: from mx0.herbolt.com (localhost [127.0.0.1])
	by mx0.herbolt.com (Postfix) with ESMTP id 4354C180F2D2;
	Wed, 07 Oct 2026 19:30:12 +0200 (CEST)
Received: from mail.herbolt.com ([172.16.31.10])
	by mx0.herbolt.com with ESMTPSA
	id RH8wBqSBxmo99QIAKEJqOA
	(envelope-from <lukas@herbolt.com>); Wed, 07 Oct 2026 19:30:12 +0200
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Oct 2026 19:30:12 +0200
From: Lukas Herbolt <lukas@herbolt.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] src/locktest.c: fix build failure of struct delegation
In-Reply-To: <aqaxjGZ6rSR1mZCf@zlang-mailbox>
References: <20260813150846.280498-1-zlang@kernel.org>
 <aqaxjGZ6rSR1mZCf@zlang-mailbox>
Message-ID: <dabaefbef09950a167e315b05c6c2fe7@herbolt.com>
X-Sender: lukas@herbolt.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2026-09-13 16:29, Zorro Lang wrote:
> On Thu, Aug 13, 2026 at 11:08:46PM +0800, Zorro Lang wrote:
>> Since glibc commit f2e3dacbff88 ("Add new constants from Linux 6.12,
>> 6.18 and 6.19 to bits/fcntl-linux.h"), the F_GETDELEG and F_SETDELEG
>> constants from Linux 6.19 have been added directly into <fcntl.h>.
>> However, the corresponding full definition for 'struct delegation'
>> was not included in glibc's userspace wrapper. That causes below
>> build error:
>> 
>>  locktest.c:1065:16: error: variable 'deleg' has initializer but 
>> incomplete type
>>   1065 |         struct delegation deleg = { .d_type = F_UNLCK };
>>  ...
>> 
>> Fix this by isolating the definition of 'struct delegation' from the
>> command macros via autoconf capability probing:
>> 
>> 1. Add an AC_CHECK_TYPES check for 'struct delegation' in 
>> configure.ac.
>> 2. In locktest.c, unbind 'struct delegation' from the '#ifndef 
>> F_GETDELEG'
>>    guard and wrap it with '#ifndef HAVE_STRUCT_DELEGATION' instead.
>> 
>> Signed-off-by: Zorro Lang <zlang@kernel.org>
>> ---
>> 
>> Hi,
>> 
>> fstests currently fails to build against the latest glibc, with the 
>> root
>> cause detailed in the commit log above.
>> 
>> The glibc now defines F_GETDELEG and F_SETDELEG, but leaves out the 
>> actual
>> 'struct delegation' definition. The complete struct is available in 
>> <linux/fcntl.h>,
>> but we cannot simply include both <fcntl.h> and <linux/fcntl.h> due to 
>> nasty
>> namespace redefinition conflicts.
>> 
>> I am not entirely sure if glibc will bring in 'struct delegation', so 
>> for now,
>> I chose to decouple and handle the structure definition independently 
>> via
>> autoconf.
>> 
>> Any thoughts or better suggestions on how we should handle this 
>> transition?
> 
> Friendly ping...
> 
> Am I the only one seeing this? Without this patch, xfstests won't 
> compile on
> the latest Fedora：
>   glibc-devel-2.44.9000-1.fc46.x86_64
>   gcc-16.2.1-2.fc46.x86_64
> 
> I keep running into the build error below [1].
> 
> Thanks,
> Zorro
> 
> [1]
> locktest.c: In function 'initialize':
> locktest.c:1018:17: warning: variable 'offset' set but not used 
> [-Wunused-but-set-variable=]
>  1018 |     int         offset = 0;
>       |                 ^~~~~~
> locktest.c: In function 'release_lease':
> locktest.c:1065:16: error: variable 'deleg' has initializer but 
> incomplete type
>  1065 |         struct delegation deleg = { .d_type = F_UNLCK };
>       |                ^~~~~~~~~~
> locktest.c:1065:38: error: 'struct delegation' has no member named 
> 'd_type'
>  1065 |         struct delegation deleg = { .d_type = F_UNLCK };
>       |                                      ^~~~~~
> locktest.c:1065:47: warning: excess elements in struct initializer
>  1065 |         struct delegation deleg = { .d_type = F_UNLCK };
>       |                                               ^~~~~~~
> locktest.c:1065:47: note: (near initialization for 'deleg')
> locktest.c:1065:27: error: storage size of 'deleg' isn't known
>  1065 |         struct delegation deleg = { .d_type = F_UNLCK };
>       |                           ^~~~~
> locktest.c:1065:27: warning: unused variable 'deleg' 
> [-Wunused-variable]
> locktest.c: In function 'do_deleg':
> locktest.c:1365:12: error: variable 'deleg' has initializer but 
> incomplete type
>  1365 |     struct delegation deleg = { .d_type = arg };
>       |            ^~~~~~~~~~
> locktest.c:1365:34: error: 'struct delegation' has no member named 
> 'd_type'
>  1365 |     struct delegation deleg = { .d_type = arg };
>       |                                  ^~~~~~
> locktest.c:1365:43: warning: excess elements in struct initializer
>  1365 |     struct delegation deleg = { .d_type = arg };
>       |                                           ^~~
> locktest.c:1365:43: note: (near initialization for 'deleg')
> locktest.c:1365:23: error: storage size of 'deleg' isn't known
>  1365 |     struct delegation deleg = { .d_type = arg };
>       |                       ^~~~~
> locktest.c:1365:23: warning: unused variable 'deleg' 
> [-Wunused-variable]
> locktest.c: In function 'main':
> locktest.c:1615:16: error: variable 'deleg' has initializer but 
> incomplete type
>  1615 |         struct delegation deleg = { .d_type = F_UNLCK };
>       |                ^~~~~~~~~~
> locktest.c:1615:38: error: 'struct delegation' has no member named 
> 'd_type'
>  1615 |         struct delegation deleg = { .d_type = F_UNLCK };
>       |                                      ^~~~~~
> locktest.c:1615:47: warning: excess elements in struct initializer
>  1615 |         struct delegation deleg = { .d_type = F_UNLCK };
>       |                                               ^~~~~~~
> locktest.c:1615:47: note: (near initialization for 'deleg')
> locktest.c:1615:27: error: storage size of 'deleg' isn't known
>  1615 |         struct delegation deleg = { .d_type = F_UNLCK };
>       |                           ^~~~~
> locktest.c:1615:27: warning: unused variable 'deleg' 
> [-Wunused-variable]
>     [CC]    chprojid_fail
>     [CC]    detached_mounts_propagation
> gmake[2]: *** [Makefile:139: locktest] Error 1
> gmake[2]: *** Waiting for unfinished jobs....
> gmake[1]: *** [include/buildrules:30: src] Error 2
> make: *** [Makefile:65: default] Error 2
> 
>> 
>> Thanks,
>> Zorro
>> 
>>  configure.ac   | 4 ++++
>>  src/locktest.c | 2 ++
>>  2 files changed, 6 insertions(+)
>> 
>> diff --git a/configure.ac b/configure.ac
>> index feb24ddd..6d7ff3ba 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -111,6 +111,10 @@ AC_CHECK_TYPES([struct 
>> btrfs_ioctl_received_subvol_args], [], [], [[
>>  #include <stddef.h>
>>  #include <linux/btrfs.h>
>>  ]])
>> +AC_CHECK_TYPES([struct delegation], [], [], [[
>> +#include <stddef.h>
>> +#include <fcntl.h>
>> +]])
>>  AC_CHECK_HEADERS([linux/btrfs.h linux/btrfs_tree.h])
>>  AC_CHECK_MEMBERS([struct btrfs_ioctl_vol_args_v2.subvolid], [], [], 
>> [[
>>  #include <stddef.h>
>> diff --git a/src/locktest.c b/src/locktest.c
>> index 54ee1f07..d0264c94 100644
>> --- a/src/locktest.c
>> +++ b/src/locktest.c
>> @@ -80,7 +80,9 @@ extern int h_errno;
>>  #ifndef F_GETDELEG
>>  #define F_GETDELEG	(1024 + 15)
>>  #define F_SETDELEG	(1024 + 16)
>> +#endif
>> 
>> +#ifndef HAVE_STRUCT_DELEGATION
>>  struct delegation {
>>  	uint32_t d_flags;
>>  	uint16_t d_type;
>> --
>> 2.55.0
>> 
>> 

Hit the same on fedora-rawhide looks good to me.
Reviewed-by: "Lukas Herbolt" <lukas@herbolt.com>

-- 
-lhe
