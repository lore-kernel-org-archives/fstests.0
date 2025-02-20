Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436B425760
	for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036627; cv=none; b=U1CMBFaAKp3WvgXjsaFf1vKPHq3rVxEexTFuLqzKwcrvG5Skx1NnKr2rSQJUAyTEVkwjpVo1ay72JwejvL1qQrRbFyTg+NX/qSzT6g9FImZaNqQDqVtVcL+IHKmmNN9aFiKN+Uje8NJ2m65XzLv1k1yVPzrEAiWUKA/hZ2+9+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036627; c=relaxed/simple;
	bh=aLYDui4jDwS/MeOl4pCS2/owfNIo1yjpz0A1dV/WP0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCeZ3NBPf84/zp1y5QOxeS785axGjuVWoA0OhwAjsLfWJcnFuM9CcDoIGAEDoq2HYYHhLP7PuBlqYpEvbMqASXytoVBs4dblvKS+xOyVn3D4ECITtBzzM2L05CGq0+AZsN5o/WVRUGF1kHJcgPYezn05/Gkw2ajXWsG94fmm2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1rjNm5G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1rjNm5G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740036624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s6XyGskctITcbnDGCjXebvPdmdPXbnyzM14FjjHVB8g=;
	b=A1rjNm5GDtb6OTQbOVDb1fH9zHYQO4Z6/K4Sl/zswzqbOH9UnlZBSrSyUJ1cZMY/YKdb7+
	Yp516oPC0AOVNEZhr+kmvMiUKL844yYIW4wlGb8glR/gTxeOWemWnPn43gliZiYi9hsKG2
	APpVaGYgr0UqtGWlAt+yzwAsbPsp7Yo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-uIop8fFBMHe025sn43Ddyw-1; Thu, 20 Feb 2025 02:30:17 -0500
X-MC-Unique: uIop8fFBMHe025sn43Ddyw-1
X-Mimecast-MFC-AGG-ID: uIop8fFBMHe025sn43Ddyw_1740036616
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22101351b1dso13332035ad.3
        for <fstests@vger.kernel.org>; Wed, 19 Feb 2025 23:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036616; x=1740641416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6XyGskctITcbnDGCjXebvPdmdPXbnyzM14FjjHVB8g=;
        b=oWeZic6iX7yv7VMrArN72YY0leHh2AgG4MDJv8tlW5hOx2FBsoL6clO3q0iJpN52MM
         3oKmZeLMy/fyGrwWj8YcGIxAiD3X3Kxhn4DabrlFRhO9EN9yAZUubtAlU8n9lPYk4DkK
         2Q3VqxO0hPjuwNcXMlzkxFhRpTRlY8xLvfMA7/UhLebwBrzcaPHykG7+roGxyDE4ixyS
         cRiplFo8QiA+ROEPOK0lJMMBMhh8H0DKyRLq1ojjYqZhs0ldUYWb7DS+RdCsGswdNkcV
         bQ5GwkAWE8nHhddvwS4g5rcDnVfsuHU5io61EgAxQEsELxU3I9HEm/GH+S+tJvFnvzh0
         K5dg==
X-Gm-Message-State: AOJu0Yxl3DBapKCHLSQBmZnthfAZ+br5ZEh4qci1ngPvIV34plplVd8x
	ZCaTIOuCaJbkl5hgUCxG81lmOq/PmzRO1JSzQRHeMkdfvN77Oc/sFobfeoqmYDjeteVND4lB40R
	cC08KD7Pasgk7jLAqlmPvsnElPVh/oaMJpI7ZrDbOhap4efW+Vr9mN1c=
X-Gm-Gg: ASbGncv+QsHMjx0PxALfKASYqIu/8WDSUKfiBdUQYdjrOIutmtcnJTqxEHLzxqLW/I2
	oZN5NyBKxL44+kh9u2zkeWUKihJ+XaldUjVh4+ZzK/Rt6V6ezMP5lVCG7Nd4NApEAIQSr02WtZq
	HKTlvms+52cl+tgS07rs/xSyH6aeQZBt3EntauZhqHxSHLy+xza3F0V70OFFjLEvBC1a3g+KDhR
	7BM2TBhpXlnjlWqm7FXTKd40Vz+y5cleLGPDkmeVTSpFz0/to0264jPxAsWnw5CDTIyo5lGqa83
	j/Kpb1BaLMCUDGNsczRPMUFWils1reU3ljvZLbZwG3mu7g==
X-Received: by 2002:a05:6a20:3942:b0:1ee:69aa:b665 with SMTP id adf61e73a8af0-1eed4ff478amr12001746637.29.1740036613636;
        Wed, 19 Feb 2025 23:30:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwjeZ8j7F5Zx4w9dLp2k46x/JkoJ3bDuefjBbiGzdOMiO1Jq3MLP9R59VvQDBE+oX2uePH5Q==
X-Received: by 2002:a05:6a20:3942:b0:1ee:69aa:b665 with SMTP id adf61e73a8af0-1eed4ff478amr12001714637.29.1740036613254;
        Wed, 19 Feb 2025 23:30:13 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-add540f75f7sm9410671a12.46.2025.02.19.23.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:30:12 -0800 (PST)
Date: Thu, 20 Feb 2025 15:30:09 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH fstests v2] generic/126: run it inside its own
 subdirectory
Message-ID: <20250220073009.peqelmiuusydgkxq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250219-generic126-v2-1-e7537f6c9607@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-generic126-v2-1-e7537f6c9607@kernel.org>

On Wed, Feb 19, 2025 at 12:57:55PM -0500, Jeff Layton wrote:
> I had been seeing some failures in generic/126 when running on NFS under
> kdevops.
> 
> The problem turned out to be that kdevops makes the root of the NFS
> export mode 01777 by default (i.e. with the sticky bit set). This causes
> some of these permission tests to fail because the open() is called with
> the O_CREAT bit set.
> 
> Make the outcome of this test not depend on the permissions on
> $TEST_DIR. Create a new directory to do these tests in, and clean it up
> when done.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v2:
> - add commands to _cleanup() to clean up test directory (Thanks Darrick!)
> - Link to v1: https://lore.kernel.org/r/20250219-generic126-v1-1-018e4e60c811@kernel.org
> ---
>  tests/generic/126 | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/126 b/tests/generic/126
> index 142d2bb97db706bafd2152856ef0993c5c273441..1f17492ed2a395ed3798c71243f3098558a157dc 100755
> --- a/tests/generic/126
> +++ b/tests/generic/126
> @@ -13,6 +13,7 @@ _begin_fstest perms auto quick
>  _cleanup()
>  {
>      cd /
> +    test -n "$testdir" && rm -rf "$testdir"
>  }
>  
>  # Import common functions.
> @@ -23,7 +24,13 @@ _require_chown
>  
>  QA_FS_PERMS=$here/src/fs_perms
>  
> -cd $TEST_DIR
> +testdir="$TEST_DIR/generic-126.$$"
> +
> +mkdir $testdir
> +chown 0:0 $testdir
> +chmod 0755 $testdir

Sorry, more review points :)

We have a _require_chmod helper, due to not all filesystems supports it.
If the chmod is need, you need to add _require_chmod.

And as Dave suggested, can you explain why these steps are necessary?
If this test fails without these steps, please add some comments for that.

Thanks,
Zorro

> +cd $testdir
> +
>  cp $here/src/testx ./testx.file
>  
>  # file_perm owner_uid owner_gid tester_uid tester_gid perm_to_test expected_result pass=1
> @@ -46,7 +53,8 @@ $QA_FS_PERMS 200 99 99 200 99 w 1
>  $QA_FS_PERMS 040 99 99 99 500 r 1
>  $QA_FS_PERMS 400 99 99 200 99 r 1
>  
> -rm -f ./testx.file
> +cd /
> +rm -rf $testdir
>  
>  status=0
>  exit
> 
> ---
> base-commit: 8467552f09e1672a02712653b532a84bd46ea10e
> change-id: 20250219-generic126-f81b3022c4b7
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
> 

