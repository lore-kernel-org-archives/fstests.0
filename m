Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F81C5F25
	for <fstests@vger.kernel.org>; Sun,  9 Mar 2025 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741525053; cv=none; b=BDjlaxU8Ka12drNCRE+BtAH1maGmZ+5NePGjfqr+KY7Lcd2zB00kXecV7rwknX9t862svvVkKlg2+zh4Oa85iwzsWt7kreNdFtb3HdVmC1abtBJPmeKM3VqdZSLny94dNsJ5oZcjEwzL1aUTucKN/a13ecf26np+/5Ih47wXVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741525053; c=relaxed/simple;
	bh=oCsV/XjIVqQvrYxOplOH3qoJDdF72LxMglvS2ufe2co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnfnPaiXzK2RooanXseGeiuquSSw72ObIzROzrO86Daq3Xg8iiGKDoysr/YdpXgGY0COLgAExCK+Gp0MwDJprl+gBPTx62o0Cgkfwl04VOCKy464tKTSjmvYwptSAXyGCchk4n2uqaMMWFmzBhWHGJNuP8J66B3VJD2vAgc67ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJVqBHLM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJVqBHLM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741525050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQwbizbtJMyLx198lIAKcrZcZyuVXls+cQnsrqU1IX0=;
	b=SJVqBHLM5TYsKotbZCLN605N1VgtTA0KgTb40Kw2m8aLtpws/j8+j0fYnx0POsd08YXZxs
	OTvoq0Q5mF/pa1Tz3ReH/cQ31azVKQhIzF6L3I9w3QGlP1AFHTAR16ux3T3jmUUiMjiiMg
	ZSLWJaWpw5Tdjkpf/L9+NCY/7f3bSWI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-jjG9GtY6PqKC4S17rgWpeg-1; Sun, 09 Mar 2025 08:57:29 -0400
X-MC-Unique: jjG9GtY6PqKC4S17rgWpeg-1
X-Mimecast-MFC-AGG-ID: jjG9GtY6PqKC4S17rgWpeg_1741525048
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so4478523a91.2
        for <fstests@vger.kernel.org>; Sun, 09 Mar 2025 05:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741525047; x=1742129847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQwbizbtJMyLx198lIAKcrZcZyuVXls+cQnsrqU1IX0=;
        b=WvKp2mpB8SORM/IDPsB+O3HH36l2Bn46QZNYHNLVrBNjA3AiJYhqLaXz383j9NVYD2
         UFvM53fRTZ7JoMC3th587/rVdZeOk9SXSdeana27wEMcW9CY4zm9kXbrFqkGh7PQUK8x
         sLAi3FyHGodMgElIQ2M65Zw5lPT4OQgjC/cw4udYXpY/1p4BczFED07rhudpiKJifDNf
         mnNmU7A6LfFXslxYGBKZiaNQmSWfEetsY2RiHjRcRlKW/6a+Nt2ZsaBiyOl12BHw4AC0
         F1LobgrtO1mjWiQi03/iKCHBgePgwWwClgtSGnE8VbtBxY09cl8CKebyG3PfpPoWUG9N
         P9UQ==
X-Gm-Message-State: AOJu0YzKpJKTKCDH3CJn3apmy4EoK9p12Og2KC6tBTSYyCIWpC0ldyu8
	6Kdcm0W+uT7FP0wo8ukzH5Pn+deEKrxcRJSCd6WudYy0tIV2jz+9m2yOllx0OixW+qjsomK7bsw
	Tkt/fD9o/rgJc0mNRj8cfrSXfsQ7J2eGNUwhsqICA6ouN1+UTGSQ9mTsi/BYujgSPTQ==
X-Gm-Gg: ASbGncvZ7RqnmlwhxzorFz6xyvOvq4lZgYvFegtbayefm9NHJewR9LAVZghss1QyIFo
	Vgqb7qmU5js4oPiW6tluuYm0FjZpKxbNwuJ4IavVYTvcb1sO/N5c42xcHe/cY30bn3gwD/wsevf
	S8rF+m2WR0YKdogD25fceN8fzxOkq4hRB7CFK5Dk2IJ2LjIzMylaDQ0JFZqsivysEdno94uOKud
	Ou7gmQkunexL019fh6pGxArl39G2Rhzt7455gaK8pA6Idb/JoUFb7eZmTDWvHkJq5XwuP9VnvbX
	cmS3PFiWb+75LatHS6a2mOcDkU3F+A+0MrIYjsymdwgeN0+vevvynsp+
X-Received: by 2002:a05:6a21:6d97:b0:1f3:269c:6706 with SMTP id adf61e73a8af0-1f544ad7016mr17509738637.8.1741525047550;
        Sun, 09 Mar 2025 05:57:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXPXClwm25dN7yVRc3Dh6Ldqf4q294h434apVSxqK6oY9gmPen6cLHv1h1Yw4Mq4JwLqWQ7w==
X-Received: by 2002:a05:6a21:6d97:b0:1f3:269c:6706 with SMTP id adf61e73a8af0-1f544ad7016mr17509718637.8.1741525047213;
        Sun, 09 Mar 2025 05:57:27 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af50c336f76sm3779358a12.57.2025.03.09.05.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 05:57:26 -0700 (PDT)
Date: Sun, 9 Mar 2025 20:57:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Luis Henriques <luis@igalia.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] src: include libgen.h for function basename() if not
 using GNU libc
Message-ID: <20250309125722.oh365fx6hyvmzw6i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250304122119.21412-1-luis@igalia.com>
 <20250304122119.21412-2-luis@igalia.com>
 <20250304140530.o46rs3tad6eqqprh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <875xkox3y9.fsf@igalia.com>
 <87zfhvglcg.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zfhvglcg.fsf@igalia.com>

On Sat, Mar 08, 2025 at 11:21:19PM +0000, Luis Henriques wrote:
> Hi Zorro,
> 
> On Tue, Mar 04 2025, Luis Henriques wrote:
> 
> > On Tue, Mar 04 2025, Zorro Lang wrote:
> >
> >> On Tue, Mar 04, 2025 at 12:21:18PM +0000, Luis Henriques wrote:
> >>> Compiling fstests on a system without the GNU libc fails because the
> >>> basename() is defined in libgen.h by POSIX and not in string.h.
> >>> 
> >>> Fix that by including the libgen.h header if __USE_GNU isn't defined.
> >>> 
> >>> Signed-off-by: Luis Henriques <luis@igalia.com>
> >>> ---
> >>>  src/aio-dio-regress/aio-dio-append-write-read-race.c | 3 +++
> >>>  src/splice-test.c                                    | 3 +++
> >>>  src/t_ext4_dax_inline_corruption.c                   | 3 +++
> >>>  src/t_ext4_dax_journal_corruption.c                  | 3 +++
> >>>  src/t_mmap_collision.c                               | 3 +++
> >>>  src/t_mmap_dio.c                                     | 3 +++
> >>>  6 files changed, 18 insertions(+)
> >>> 
> >>> diff --git a/src/aio-dio-regress/aio-dio-append-write-read-race.c b/src/aio-dio-regress/aio-dio-append-write-read-race.c
> >>> index d9f8982f007c..1a0c8e99c61f 100644
> >>> --- a/src/aio-dio-regress/aio-dio-append-write-read-race.c
> >>> +++ b/src/aio-dio-regress/aio-dio-append-write-read-race.c
> >>> @@ -19,6 +19,9 @@
> >>>  #include <sys/stat.h>
> >>>  #include <fcntl.h>
> >>>  #include <errno.h>
> >>> +#ifndef __USE_GNU
> >>> +#include <libgen.h>
> >>> +#endif
> >>
> >> Do you use clang and musl to build fstests? I'm even not sure if fstests
> >> can be built with them :) 
> >
> > Yes, I'm able to compile and run fstests using gcc (not clang) and musl.
> > Though there's a hack I still need to use to compile, which is to define
> > CFLAGS="-D_LARGEFILE64_SOURCE".  Since that doesn't require changing
> > anything, I haven't yet investigated how that could be fixed.
> >
> >> I don't have experience on this part, but I don't mind letting fstests
> >> to be supported by other libc. The patch looks safe for current users.
> >>
> >> If anyone has this experience, please feel free to review. I'll think
> >> about merging this patch if no objection from others.
> >
> > The only links I can provide you with some extra info are [1] (section
> > about basename) and the basename(3) man page.  Looking at it again makes
> > me think that including libgen.h unconditionally should also be OK,
> > forcing the POSIX implementation to be used instead.  But using this
> > #ifndef seems to be used in other projects.
> >
> 
> Please hold on this patch as I think some of the changes are broken.  The
> POSIX basename() is a bit different from the GNU version, and needs to be
> handled with a bit more care.  I'll resend this later in a few days.

Thanks Luis, breaking the building with musl is not a big issue, but please
never break the current glibc build :)

> 
> (But feel free to pick the second patch, as I believe it's still a valid
> fix.)

Today I'll make a fstests release, your second patch will be in the next release
(after today). You can find it in patches-in-queue branch soon. Feel free to
resend the whole patchset or resend this single one.

Thanks,
Zorro

> 
> Cheers,
> -- 
> Luís
> 
> > And thanks, Zorro, for your review!
> >
> > [1] https://www.gnu.org/software/libc/manual/html_node/Finding-Tokens-in-a-String.html
> >
> > Cheers,
> > -- 
> > Luís
> >
> >>
> >> Thanks,
> >> Zorro
> >>
> >>>  
> >>>  #include <libaio.h>
> >>>  #include <pthread.h>
> >>> diff --git a/src/splice-test.c b/src/splice-test.c
> >>> index eb8636738064..e6753a15dc47 100644
> >>> --- a/src/splice-test.c
> >>> +++ b/src/splice-test.c
> >>> @@ -18,6 +18,9 @@
> >>>  #include <string.h>
> >>>  #include <errno.h>
> >>>  #include <malloc.h>
> >>> +#ifndef __USE_GNU
> >>> +#include <libgen.h>
> >>> +#endif
> >>>  
> >>>  unsigned int sector_size;
> >>>  unsigned int buffer_size;
> >>> diff --git a/src/t_ext4_dax_inline_corruption.c b/src/t_ext4_dax_inline_corruption.c
> >>> index e1a39a6c1e46..a6cb768512fc 100644
> >>> --- a/src/t_ext4_dax_inline_corruption.c
> >>> +++ b/src/t_ext4_dax_inline_corruption.c
> >>> @@ -10,6 +10,9 @@
> >>>  #include <sys/types.h>
> >>>  #include <time.h>
> >>>  #include <unistd.h>
> >>> +#ifndef __USE_GNU
> >>> +#include <libgen.h>
> >>> +#endif
> >>>  
> >>>  #define PAGE(a) ((a)*0x1000)
> >>>  #define STRLEN 256
> >>> diff --git a/src/t_ext4_dax_journal_corruption.c b/src/t_ext4_dax_journal_corruption.c
> >>> index ba7a96e43559..4e5762d77058 100644
> >>> --- a/src/t_ext4_dax_journal_corruption.c
> >>> +++ b/src/t_ext4_dax_journal_corruption.c
> >>> @@ -10,6 +10,9 @@
> >>>  #include <sys/types.h>
> >>>  #include <time.h>
> >>>  #include <unistd.h>
> >>> +#ifndef __USE_GNU
> >>> +#include <libgen.h>
> >>> +#endif
> >>>  
> >>>  #define PAGE(a) ((a)*0x1000)
> >>>  #define STRLEN 256
> >>> diff --git a/src/t_mmap_collision.c b/src/t_mmap_collision.c
> >>> index c872f4e26940..638424d2e619 100644
> >>> --- a/src/t_mmap_collision.c
> >>> +++ b/src/t_mmap_collision.c
> >>> @@ -24,6 +24,9 @@
> >>>  #include <sys/stat.h>
> >>>  #include <sys/types.h>
> >>>  #include <unistd.h>
> >>> +#ifndef __USE_GNU
> >>> +#include <libgen.h>
> >>> +#endif
> >>>  
> >>>  void *dax_data;
> >>>  int nodax_fd;
> >>> diff --git a/src/t_mmap_dio.c b/src/t_mmap_dio.c
> >>> index 6c8ca1a39181..342e2c6deb4b 100644
> >>> --- a/src/t_mmap_dio.c
> >>> +++ b/src/t_mmap_dio.c
> >>> @@ -14,6 +14,9 @@
> >>>  #include <libaio.h>
> >>>  #include <errno.h>
> >>>  #include <sys/time.h>
> >>> +#ifndef __USE_GNU
> >>> +#include <libgen.h>
> >>> +#endif
> >>>  
> >>>  void usage(char *prog)
> >>>  {
> >>> 
> >>
> >
> 

