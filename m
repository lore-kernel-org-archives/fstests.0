Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589EA17BD3
	for <fstests@vger.kernel.org>; Tue,  1 Jul 2025 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397831; cv=none; b=afruTz+2k0Ag5QmNdQEe4uii/inNCt4aEjgUnMqm53GEBybsvVeT/vg0PCPOn+3ljFbH5VK5A76q+osJGmbrPERn2M9qS7WrrHwFrxEC1zjIZCCD+C7QKJtcWlA3S2PCMXMAA1sCSauB9kejLwYJI8yXFPBLJ2s08dP7XqNfiXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397831; c=relaxed/simple;
	bh=cgV8UHYAIsryKvFKwfpqwfEu9jOAqc017amrJngBlmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uWZiMSm/sseU+MmJxhd5fOAiLnIXahXFENSh8rocfs4MUaD1Y8DsPLKjwPFZ5OQa3ANUNVxAdpqLiNWoCyM8u5sGE1iRWi+GnEg/KbVITfQnS4u/aKl+OU9Q9ExW6zXR2eoGu3zmMo3hPHxNwdnikQbZ5JsCoTVlZMm7nDqtaZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bpj8xdxb; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpj8xdxb"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-701046cfeefso35418616d6.2
        for <fstests@vger.kernel.org>; Tue, 01 Jul 2025 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751397829; x=1752002629; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZZF60Ij70yvHUf+fwhy1GpLKWGONaQB55c5aZoJC3E=;
        b=Bpj8xdxbiQtO4y9K/cxj/5ljNK9tULnMYOn0iOXlbUWk3l7KS0GpY24EY/ZfOgQU97
         rMH+jX/LOHkLBO6QS+LoYKw4xN7HTFOiCwI0k+n7O6B5AZHHhGp7HsI6tObHLTAmARu6
         IdaFwsqZjNuFh0kfstylE80C+FvH7SXMs1abjHnYFW3JwRpYs9cxIxM39hD8/iU+IuoU
         2CF949jDoElOixfdzxz0cMZuLtk4Q9C/kiwRRtjNl4UrThjwwbVFPNzsD6rewmkN/4EL
         YqZK2RwWihJljitGAtxzgm/fruiABsUdYhnV+PHC2Xqx2zIQZ8RvRGRYVh3q+vFD21Ea
         hsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751397829; x=1752002629;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZZF60Ij70yvHUf+fwhy1GpLKWGONaQB55c5aZoJC3E=;
        b=joICyB8fWbK2e9jKuxAp8xYvTLROx2vqb3pUZw3IWUDfbHu8rEsOPsBH9ArPNgscs/
         jKk7PVDp7td1C3GXRxxr1do5I16uvMvEc5F3rMBC97XjaeuDZ9+AU6std8n9XON1UZF4
         LSdOvZzs654Fea/lQcYw9/gifjMMWaW2cUb4r3xc/ZC3mmxTEWkO9VcVpKo/AvR58pWN
         GLIcYmND6qiHAvUOLJivqjrMuMHJzgujBEJHxGwOfHbKXZJwYZdh2isMbJc0I/DqJLvy
         GqnIlXWGBhvoEw2rkwiOz6ZlrVYHVAYbc4+blt6sLjwRHCx1fDpXbUft/6B5nSso8tb6
         GVqQ==
X-Gm-Message-State: AOJu0YwRfIZ9ek6QdTTLserLzOvTlq11kXhBu8P3AXB2zgkLJL1nNu9A
	8WPcB5JcsNT0k+RJt6L1aNiTM5JE4uhde2IbFYR1WZ/aeXNeqiF4FLDnxAYssQQN7MrnxAYGMQQ
	E8s3y7bebxV2ZHdccd3vFV5InCriuiBWQ/kwR
X-Gm-Gg: ASbGncvwEfIimGNvCWbWL1bdvRkFNG5Q0CbT8lLvJaxZTMdV3BWIFaYpxUD1R+cmzIZ
	2Pr1PAsxHWlI8Kh91VMoxknHBuWhg2e+sJNLxoyCwvXzphDxCDVopCaDJwQck2zFD4KzNKrpatp
	/YeINE3Hg4W3+5Wi5ef1R/CpC2hV0DxSAvWShMQdsAww==
X-Google-Smtp-Source: AGHT+IEsuf00ZOfQYcZjpoH0gzeT4xFZSwJdU8qY1K19unPTnvsSzolYrsY5vfTUhLTELDzHvqhOA0Bp3P7dhryaZWo=
X-Received: by 2002:a05:6214:468b:b0:6fa:fe27:a249 with SMTP id
 6a1803df08f44-700036ad734mr264361116d6.43.1751397828730; Tue, 01 Jul 2025
 12:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5msYMeEaaKKT1mEG7bCjFYExFCRUdL6ShimoK0g1AEdERQ@mail.gmail.com>
In-Reply-To: <CAH2r5msYMeEaaKKT1mEG7bCjFYExFCRUdL6ShimoK0g1AEdERQ@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 1 Jul 2025 14:23:36 -0500
X-Gm-Features: Ac12FXwXuCfq6PjJjDQGxS-FCTvTkJmT30Idc1PjcJoDT6UAzQtWhWqy0EyljFE
Message-ID: <CAH2r5mtrM0_+x2jzxoRoNq6c3e5rS_7s7QT-=S5fDA06XoFNvw@mail.gmail.com>
Subject: Re: Build errors with current xfstests
To: fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I haven't had a problem building it before on Ubuntu, but perhaps due
to upgrade to Ubuntu 24.04 this line in acinclude.m4 breaks (which is
supposed to set HAVE_FALLOCATE but won't if this line fails).  Any
thoughts?

#include <fcntl.h>
#include <linux/falloc.h> ]], [[ fallocate(0, 0, 0, 0); ]])],[
have_fallocate=3Dtrue; AC_MSG_RESULT(yes) ],[ have_fallocate=3Dfalse;
AC_MSG_RESULT(no) ])

On Tue, Jul 1, 2025 at 2:15=E2=80=AFPM Steve French <smfrench@gmail.com> wr=
ote:
>
> I am getting the following build error with current xfstests on
> Ubuntu.  Any thoughts?
>
> Building src
>     [CC]    iogen
> iogen.c: In function 'create_file':
> iogen.c:996:3: error: #error Dont know how to (pre)allocate space!
>   996 | # error Dont know how to (pre)allocate space!
>       |   ^~~~~
> iogen.c: In function 'main':
> iogen.c:280:9: warning: ignoring return value of 'write' declared with
> attribute 'warn_unused_result' [-Wunused-result]
>   280 |         write(outfd, (char *)&req, sizeof(req));
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> iogen.c: In function 'parse_cmdline':
> iogen.c:1535:17: warning: ignoring return value of 'getcwd' declared
> with attribute 'warn_unused_result' [-Wunused-result]
>  1535 |                 getcwd(fptr->f_path,
>       |                 ^~~~~~~~~~~~~~~~~~~~
>  1536 |                        sizeof(fptr->f_path)-1);
>       |                        ~~~~~~~~~~~~~~~~~~~~~~~
> gmake[2]: *** [Makefile:51: iogen] Error 1
> gmake[1]: *** [include/buildrules:31: ltp] Error 2
> make: *** [Makefile:51: default] Error 2
>
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve
