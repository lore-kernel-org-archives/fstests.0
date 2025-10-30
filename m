Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C323546FB
	for <fstests@vger.kernel.org>; Thu, 30 Oct 2025 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818767; cv=none; b=mzYloUXglLgkeGxoWNnKkY8/DJ2fmcuCLx/pCOly8hj8d8LsCKmZvkdS41brhSOAiLGdxQt6EnCBZDjqJbVh1WlACYbvDxaz7cozn9zS5Cm6gRBXZ0XCGjkjLUeeP9Co73BkMJQS9Q+NZ9YbaUBzRyDKvoPKIbhXnIy0d32Dbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818767; c=relaxed/simple;
	bh=ck8LSBHKPeutEEduvO4hk2YZpUlglnNVZAj0p3d+tZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNqQ8WWVyIONfNw6OnxPSLlRrqEdcOBS4MsK8E/ASczY0wI6Y78IWQFX2NYXbmRTgRnd6iQaXwz7qnVD/APa6uha7UrQzaUzvU71krA6uN5P1y2WJtVKHf8QrozC0FBH+nM9eQOvGCOGxHy4GWZOx/oQz+oeq1YTsb92kXEfpb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbVoCkV5; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbVoCkV5"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso1436332a12.0
        for <fstests@vger.kernel.org>; Thu, 30 Oct 2025 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761818763; x=1762423563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpRra+YYaNP2bxzICIK5uG5yzLGIWfb13z8p6QQVNS8=;
        b=KbVoCkV5XQDK6FQ5lr83bsRgtJIt+5Vc70zwmnwMH7yJUtE98px28O+LOgbwCl8AJN
         dsY2GPkE6gPDifn9bH6kNb5ckFO3pPd9Fe8smgdgvSA+mTKFKOfFA7uZf4QJFE3VauHu
         7uxRB6M727v511czL2O4jAnZ9qn4m2VElL/RAeQiPy9t5/bVFE7DOGD6QpwW4wgKO/rE
         8YeV9+9Un/rfK9dnGpBKhIX4BoDpiINpJMPAxTewj0k2KgDGZsrfcvU7qLjtd23Fstve
         bkh1iqmiqSDfCZszJYYBp1nv8eKXHJ/M3Fx0TwcL+x4PKzD2Tw7xBzvc9UcnrZCkmm6e
         zHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761818763; x=1762423563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpRra+YYaNP2bxzICIK5uG5yzLGIWfb13z8p6QQVNS8=;
        b=tZJ2r+FoI00WvkR7/0W9zV3s10e2H0Oc1w9Ozb43b+yCUceS0qiNEp2/F2KZyBgrIj
         PrqryNFIT+KkKqd5YBo3jW6S7vUik5jkVgVtVOtmF98Zm/Km88/2YyuIfJbZ1p9CFJf0
         IH4tV8QnisnNKknUAwv6RIVai+w3Zu/pVVTj9w4KKkNsxiLNCwLUUXsCJHgaQwyQiR26
         nOyUXZEPX5xrHwd5OyWAnf0ItQI2eZ+Pk2lWhy10c87bdFtrgKdTlFawXeRA7HBx/Ts6
         LCa3GBZwszhayec4UtfYCC/rPGZdfgvNgMQUr3zToVkkndMr9Moowq/qPcqN7xkLDZsA
         n0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/oHTTijPD+DWMERmlXj2CzLTWdV6ZQOoHkAqMPk2/EH9+4fZu708stPc+D8pOfemtOw3uGQnM@vger.kernel.org
X-Gm-Message-State: AOJu0YzYmkQS0FyX+t8XjFdcmOHjvZj2lr7yQpZgQvDX3A9UpG2wzzb1
	Qt4/gdqpY86HrKalq1eqSmgkb6bR/Bhqx2SQUN5uUDWrEUs2cYrpX9CEEesZez5GBQmyFlT3a9b
	yAqq+tyi2wMDWtaq+lGdfwImu/uadt2lDAXH2DnSkoA==
X-Gm-Gg: ASbGncuwhoU8euE/Oa+x9eNieh9mLfEL4zbsSQIpgeu8qT+l+upW9UHMCwTLPQLsVw5
	KzDUBZ9ALwnfuJx3yjIAZwBFttyRSAjJ+cS520VkAvg1Dr1OphcmBkFewS7hp9BezsgfFtMkjuG
	Wpfs27FWM1BKAW9qHJuTR096vLWnotTztg/GVfpOgyhCCxGWijhCrypzCwfWA40SwYnGd48n853
	oqu6SIaiOueTYyOBt+CB86hUlS/lMGYnoPtxD60Te9AfNauID0le68wr0W7Kub0GlueHU+2hqpI
	yyIneQ3bkkCAkD1Gi+w=
X-Google-Smtp-Source: AGHT+IEayt9kMjjupQxpl5WLpsB234iE8hKztdLOW4j/gh/ByTR/f9GKoYV6XqFI1badI7TIU5oxgv5EjeZJQhrKVsc=
X-Received: by 2002:a05:6402:5106:b0:63c:18e:1dee with SMTP id
 4fb4d7f45d1cf-64044252109mr5197576a12.24.1761818763254; Thu, 30 Oct 2025
 03:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs> <176169820480.1433624.3763033606730126640.stgit@frogsfrogsfrogs>
In-Reply-To: <176169820480.1433624.3763033606730126640.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Oct 2025 11:05:52 +0100
X-Gm-Features: AWmQ_bml8OwCVaqNQBU5P31b-DWNxcYedjaNrUhbws2VGFTKx58LLfTNxkNO3Ds
Message-ID: <CAOQ4uxgoZ_wrExQLsO2CfF8AFQ+n2T1WBHenwuteMUdnoO+Piw@mail.gmail.com>
Subject: Re: [PATCH 27/33] generic/050: skip test because fuse2fs doesn't have
 stable output
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:30=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> fuse2fs doesn't have a stable output, so skip this test for now.
>
> --- a/tests/generic/050.out      2025-07-15 14:45:14.951719283 -0700
> +++ b/tests/generic/050.out.bad        2025-07-16 14:06:28.283170486 -070=
0
> @@ -1,7 +1,7 @@
>  QA output created by 050
> +FUSE2FS (sdd): Warning: Mounting unchecked fs, running e2fsck is recomme=
nded.

oopsy here

>  setting device read-only
>  mounting read-only block device:
> -mount: device write-protected, mounting read-only
>  touching file on read-only filesystem (should fail)
>  touch: cannot touch 'SCRATCH_MNT/foo': Read-only file system
>  unmounting read-only filesystem
> @@ -12,10 +12,10 @@
>  unmounting shutdown filesystem:
>  setting device read-only
>  mounting filesystem that needs recovery on a read-only device:
> -mount: device write-protected, mounting read-only
>  unmounting read-only filesystem
>  mounting filesystem with -o norecovery on a read-only device:
> -mount: device write-protected, mounting read-only
> +FUSE2FS (sdd): read-only device, trying to mount norecovery
> +FUSE2FS (sdd): Warning: Mounting unchecked fs, running e2fsck is recomme=
nded

and here

>  unmounting read-only filesystem
>  setting device read-write
>  mounting filesystem that needs recovery with -o ro:
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/050 |    4 ++++
>  1 file changed, 4 insertions(+)
>
>
> diff --git a/tests/generic/050 b/tests/generic/050
> index 3bc371756fd221..13fbdbbfeed2b6 100755
> --- a/tests/generic/050
> +++ b/tests/generic/050
> @@ -47,6 +47,10 @@ elif [ "$FSTYP" =3D "btrfs" ]; then
>         # it can be treated as "nojournal".
>         features=3D"nojournal"
>  fi
> +if [[ "$FSTYP" =3D~ fuse.ext[234] ]]; then
> +       # fuse2fs doesn't have stable output, skip this test...
> +       _notrun "fuse doesn't have stable output"
> +fi

Is this statement correct in general for fuse or specifically for fuse2fs?

If general, than I would rather foresee fuse.xfs and make it:

if [[ ! "$FSTYP" =3D~ fuse.* ]];

Thanks,
Amir.
