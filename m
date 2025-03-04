Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0944205AC7
	for <fstests@vger.kernel.org>; Tue,  4 Mar 2025 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097154; cv=none; b=J8K2tDw4iSeLPuo2n+DvKdZBlHBA6ktf5DiSnIC4nYce8YOjMsz7pfOOBi2f4TmW8krix/DwJf1SGz1X0UgSho6l49c4G06rGMXfGVOVRvsS21OBoKMuHDdVjfYBa4sVU3dDfrDPF5GmO6OFMG0yzC35qTmMrIjrrNDlmJQxAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097154; c=relaxed/simple;
	bh=L/1ZDDkLLramKldSiM6Aytxb2N9KHWWEZMzdI37ZqGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuAVzS/t16y1AIka9HYYe54FR3NM5xmBWSZ+g05jhOR2mKwnfKZoPTFNPFSoKuufDpAuhdFfYziJyDFKVmE9z4++C09O6xZyyWQDb/4nqJmCRHau/dZlUhash3AeaWP6VbTZ3PiMjm/gIHrx+d4DOpfYoJcQ/ancVOyaJtiLaHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/pgmdCf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/pgmdCf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741097151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oS0NhWRVFcuSnEEv5u4euduH5VyTvb9/EyIjr+5oa8k=;
	b=g/pgmdCfVD9WaXkr6gTXGDSUiaQFX7XEjM4cvhcJRZN03DUy8dmfRR3xTDMoVoZfW9jR8F
	asKo1fchMk4moVqHfgKY4l17mYwW6nSJjruxph46MIHvgvGzXO4jAL8iEmsuTMKj0Bes2a
	uQcxJLmESzKgXQ0dn1P+5PZxOO9HysI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-Hnut3EqFOqOJ1I8ALkQrlA-1; Tue, 04 Mar 2025 09:05:35 -0500
X-MC-Unique: Hnut3EqFOqOJ1I8ALkQrlA-1
X-Mimecast-MFC-AGG-ID: Hnut3EqFOqOJ1I8ALkQrlA_1741097134
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2234bf13b47so108540695ad.0
        for <fstests@vger.kernel.org>; Tue, 04 Mar 2025 06:05:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741097134; x=1741701934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS0NhWRVFcuSnEEv5u4euduH5VyTvb9/EyIjr+5oa8k=;
        b=ew6VRVyNRkn4184McdIl9GvjTpywXnYqYfAAqrMcojTJyMIoDwayCoWw0tk6UqLh7Q
         h38Ulxfbu/aKp1QqNh5EhDDn5/oVMRzlLt9WUOL0+///qB4rn6RN5FlmJv6ivzl3KiHu
         8dPk7BQnC/Wl2Xag5x9fInxeFPwCiCfiH8mwMF/yUqAsMnaZOCEX//BXprs4H2qvXk/O
         VE4PLFfoveGXRPp933m6V9QDKJ6nN/8JLRHMUeFT9aiA9a/lPiUAppeM/4EEwMT9QPlb
         VC9i+TUcwL3Z45LRgyzhovI4B1vhUL8IaUXFTQZKSFGMKVtx9YrgBFmT82t59N61sU1U
         A8wQ==
X-Gm-Message-State: AOJu0Yzbm6PvJXznosbAxU56VZYknbIHI+19Tfnky6DSyr/8c9AUCXQS
	JWYrREeczzkC+fSUfeITW6wF/aKqkWui6pM8yP3IjiYuACavrFhfsGYkJJHCBtAjPiwKJICxacC
	YMBVAO6X6xk7lraFKG9cv/Q/usQOFU+77Zlyvui6JFhY4MkELO3sikJHWWqruYnwnhA==
X-Gm-Gg: ASbGnctDYc1PfD8mUSgq7JTb9dfWX5iUA9C2CmORYfXDQDWT+HB7dZSQbYq7B+X3zJX
	h3ULdbyaxd9+GPsEOJEZpURJEgelj1pRedSQTw0AGitqxIP7lkhQ1U1LHPg2jUBQ9yxIN05+FrB
	KxfHk0Pm45fzxf59Sl6f+FX3zwSdmq8s4RT6IJ5lwpZEE56LUoBh1CJGrtSSyLyA8fHPGwXIMo3
	qwsG8pE0L+PiSRXD8kcJ0QdX2xDT2cbL2/sUE6BW85W1xAuGL/ec4A9OhLbiNFWYUCpFVhL1x3t
	rqb+2/uhjpMWg/SakXj5PD2iingVh7I14vt+USntSGZvzpM1FFeGo7TC
X-Received: by 2002:a17:903:17c8:b0:223:49cb:5eaa with SMTP id d9443c01a7336-22369213d6fmr270350065ad.35.1741097133856;
        Tue, 04 Mar 2025 06:05:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQSXw9FQoQPC/doM4pDmlqT98t0SLIpZKeoxdUpMNPmmt8jepadhU7bGrD2bDW0qpBrI1hlw==
X-Received: by 2002:a17:903:17c8:b0:223:49cb:5eaa with SMTP id d9443c01a7336-22369213d6fmr270349725ad.35.1741097133485;
        Tue, 04 Mar 2025 06:05:33 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7363cd5c39bsm6305133b3a.174.2025.03.04.06.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:05:33 -0800 (PST)
Date: Tue, 4 Mar 2025 22:05:30 +0800
From: Zorro Lang <zlang@redhat.com>
To: Luis Henriques <luis@igalia.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] src: include libgen.h for function basename() if not
 using GNU libc
Message-ID: <20250304140530.o46rs3tad6eqqprh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250304122119.21412-1-luis@igalia.com>
 <20250304122119.21412-2-luis@igalia.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304122119.21412-2-luis@igalia.com>

On Tue, Mar 04, 2025 at 12:21:18PM +0000, Luis Henriques wrote:
> Compiling fstests on a system without the GNU libc fails because the
> basename() is defined in libgen.h by POSIX and not in string.h.
> 
> Fix that by including the libgen.h header if __USE_GNU isn't defined.
> 
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  src/aio-dio-regress/aio-dio-append-write-read-race.c | 3 +++
>  src/splice-test.c                                    | 3 +++
>  src/t_ext4_dax_inline_corruption.c                   | 3 +++
>  src/t_ext4_dax_journal_corruption.c                  | 3 +++
>  src/t_mmap_collision.c                               | 3 +++
>  src/t_mmap_dio.c                                     | 3 +++
>  6 files changed, 18 insertions(+)
> 
> diff --git a/src/aio-dio-regress/aio-dio-append-write-read-race.c b/src/aio-dio-regress/aio-dio-append-write-read-race.c
> index d9f8982f007c..1a0c8e99c61f 100644
> --- a/src/aio-dio-regress/aio-dio-append-write-read-race.c
> +++ b/src/aio-dio-regress/aio-dio-append-write-read-race.c
> @@ -19,6 +19,9 @@
>  #include <sys/stat.h>
>  #include <fcntl.h>
>  #include <errno.h>
> +#ifndef __USE_GNU
> +#include <libgen.h>
> +#endif

Do you use clang and musl to build fstests? I'm even not sure if fstests
can be built with them :) I don't have experience on this part, but I
don't mind letting fstests to be supported by other libc. The patch looks
safe for current users.

If anyone has this experience, please feel free to review. I'll think
about merging this patch if no objection from others.

Thanks,
Zorro

>  
>  #include <libaio.h>
>  #include <pthread.h>
> diff --git a/src/splice-test.c b/src/splice-test.c
> index eb8636738064..e6753a15dc47 100644
> --- a/src/splice-test.c
> +++ b/src/splice-test.c
> @@ -18,6 +18,9 @@
>  #include <string.h>
>  #include <errno.h>
>  #include <malloc.h>
> +#ifndef __USE_GNU
> +#include <libgen.h>
> +#endif
>  
>  unsigned int sector_size;
>  unsigned int buffer_size;
> diff --git a/src/t_ext4_dax_inline_corruption.c b/src/t_ext4_dax_inline_corruption.c
> index e1a39a6c1e46..a6cb768512fc 100644
> --- a/src/t_ext4_dax_inline_corruption.c
> +++ b/src/t_ext4_dax_inline_corruption.c
> @@ -10,6 +10,9 @@
>  #include <sys/types.h>
>  #include <time.h>
>  #include <unistd.h>
> +#ifndef __USE_GNU
> +#include <libgen.h>
> +#endif
>  
>  #define PAGE(a) ((a)*0x1000)
>  #define STRLEN 256
> diff --git a/src/t_ext4_dax_journal_corruption.c b/src/t_ext4_dax_journal_corruption.c
> index ba7a96e43559..4e5762d77058 100644
> --- a/src/t_ext4_dax_journal_corruption.c
> +++ b/src/t_ext4_dax_journal_corruption.c
> @@ -10,6 +10,9 @@
>  #include <sys/types.h>
>  #include <time.h>
>  #include <unistd.h>
> +#ifndef __USE_GNU
> +#include <libgen.h>
> +#endif
>  
>  #define PAGE(a) ((a)*0x1000)
>  #define STRLEN 256
> diff --git a/src/t_mmap_collision.c b/src/t_mmap_collision.c
> index c872f4e26940..638424d2e619 100644
> --- a/src/t_mmap_collision.c
> +++ b/src/t_mmap_collision.c
> @@ -24,6 +24,9 @@
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <unistd.h>
> +#ifndef __USE_GNU
> +#include <libgen.h>
> +#endif
>  
>  void *dax_data;
>  int nodax_fd;
> diff --git a/src/t_mmap_dio.c b/src/t_mmap_dio.c
> index 6c8ca1a39181..342e2c6deb4b 100644
> --- a/src/t_mmap_dio.c
> +++ b/src/t_mmap_dio.c
> @@ -14,6 +14,9 @@
>  #include <libaio.h>
>  #include <errno.h>
>  #include <sys/time.h>
> +#ifndef __USE_GNU
> +#include <libgen.h>
> +#endif
>  
>  void usage(char *prog)
>  {
> 

