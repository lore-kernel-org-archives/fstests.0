Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1447D2AE9A
	for <fstests@vger.kernel.org>; Sat, 10 May 2025 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746882739; cv=none; b=GNIUJ4G+3/S1LMJtPosc9hLkiHnbcWArnKnZztFgzAZJ/R/BnhozgwzhRbonSHUA201sk7iiVqiZyJB3xMuZOc0aQrV60K5Ix65TrJmiierZqwCL0WrmJNWdrii/nMbokA3y74EmM7FNwcKuNSucwvTW9v2XOqAK4cz3PFp+U5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746882739; c=relaxed/simple;
	bh=40jU38qtfFiLyBvwdGzMP50hgce81eeOxYhhXMfy8mI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=B8UEVNwAHDQz71RxEhOslwTM94SR6LOtUWGzqyz1VIWwKCtyjGhGRbZkhJZprheOEuY1R+oCtLMXqBSvJZ3z/C+bX5i689EnKKcwi9VScq7Q22X/0aPpKZw+dW9uLg6HkMQVLamRdAyXSWizx6gjV08u4BYCcWuHxb8TQWx2iW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LieyUvgr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LieyUvgr"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22e331215dbso31584605ad.1
        for <fstests@vger.kernel.org>; Sat, 10 May 2025 06:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746882737; x=1747487537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nI6KLFQXavU9wTWnB5tUpckc7P4tu9hLqnUNaOuRs8=;
        b=LieyUvgr/pQMGsscZi5ClItH/rySgmHLFzJHLhq06NpryoB2M6UZGeoQQzoNhsqpy4
         aBw2aCDFJGVJ29lcj5MzfueFmdlQ0JdVf+mJswi+7KNSqplWJni/9ZbXLtrkEr8h1r03
         rAU/4kLmsJGLU0gHxOvEDD8NOqokDeG/kIkQ8k4dPQ70Z0FG4OlqwSUtFsAqwMkD8LKB
         lp1VSyZce8N6z4ckFGs/MorSqFn64P5UTEmlMtdLWs6jqWxGs/b7t5oifJO2fTDY6zy4
         v243vVHD9Q88/zaZpSJwMFQ5rNo/E0tYRIbQJdCaZzkZbmLLgq/yErZg75ReJUE6PaDR
         EJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746882737; x=1747487537;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+nI6KLFQXavU9wTWnB5tUpckc7P4tu9hLqnUNaOuRs8=;
        b=DOqWjw/GOviJtzA3r3SFgSqbwYYlgJaUMDyp+w9pwq6WRYCt4T6LaY18pSgPB8qhwo
         /2xM5Q4MdNVQ8aKz/z8cwowk/5FBgBMeajUoxN+Pym1jj0nwfNWYke0gTBWOaOejGiS7
         /mOTLJFP1Xxc+7D85EHl0ydquq5M6saPKSI9coC59cOOJ8K7a4Oph5PWLAcCUFWLTwq1
         rxaw328jjaiOHJhWeCychBN/GGxG70XULfWfaHUWgVH1f2MST227YGVTwjVRXgB9BXlg
         fNbzP54J8aEx7gCfeJbf967a/vFcoGOIVnJMZ1RjUmJD7/cTpiKenqABE9nT1lIl9o8/
         XMMw==
X-Forwarded-Encrypted: i=1; AJvYcCUvHUPem68EDixyG10wjYjy5YvktR6XOMvsPhLkTiz7hmN3RRcg+ZSw15l5ClYx7t/qlBoqJ7Cn@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/diBZvD9F+3g4Qx/Nyah8VOppvng1fLT5CuobjqCMmpSC4Gv
	07e5Ux+3TO19d3Ek77MFxXCR/DAYavZS22JO2mDl9HgACMVHbfudnJgUNg==
X-Gm-Gg: ASbGnctw7WnEcDSzI2Z3bzwGUw87TGSFYP8CJyc2ech2xR5uZcErDV/53MM2m2IbSDk
	B/Dobj1ahc6am9NzU94VfdYXkq12I4eijux8FUT1sqXuFmIXMuCAReOhSRIoAol+XQk/nY0wB1V
	lIHM9CHKy2qFNa1SUSKt0Os030gaZ2fzqTAP0EpUIg3Xpfwhc96SzbqUtSBzZ7ulxlHFRCIUsjY
	4oEBR6uglTtDphpkJewvuh70zlztkKDNRTlHqgTR87M0gBjFrb7mB48vkBbMBWOiM+ZYunImI1n
	XxuZrZ5It4VPvGqNbfsxRGsjbswzBk/VWMyMgZ7B3LVxO1McJvQZSTK41W9hcB4AKTDuGYVNz9l
	BVH0kI8ITPjhuf5fE+wiKZNO/zMKr
X-Google-Smtp-Source: AGHT+IErDjkYmck+dUIOER9Mg5iGQGrPYT3YSkhHjffNBXKo+gL/cuLLUSaN+u2aT1ovtSocSNkyIw==
X-Received: by 2002:a17:903:32d1:b0:21f:1348:10e6 with SMTP id d9443c01a7336-22fc9344a67mr110218355ad.13.1746882737133;
        Sat, 10 May 2025 06:12:17 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7741e48sm32903065ad.87.2025.05.10.06.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 06:12:16 -0700 (PDT)
Message-ID: <a5e67d248a68e7bf01f367653f981840d369750a.camel@gmail.com>
Subject: Re: [PATCH 18/28] check-parallel: create a "results-latest" symlink
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Sat, 10 May 2025 18:42:13 +0530
In-Reply-To: <20250417031208.1852171-19-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-19-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> check-parallel ensures that it doesn't overwrite results by creating
> date-stamped results directories. This, however, makes it harder to
> easy find the results for the test that is currently running or has
> just completed.
> 
> To solve this problem, maintain a symlink to the latest results
> directory so that it can always be found by the same name.
> 
> Also, if this symlink exists and is valid, use it as the source for
> runtime ordering data for the next run instead of trying to find it
> via ls and sort based ordering.
This looks good and useful. However, if we can have the above information in the README and in the
comment section of the script it will be really helpful for someone who is new. 
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
--NR
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check-parallel | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/check-parallel b/check-parallel
> index 374ac8e96..1b67709a2 100755
> --- a/check-parallel
> +++ b/check-parallel
> @@ -149,7 +149,9 @@ if [[ $runners -le 0 || $runners -gt 1024 ]]; then
>  	usage
>  fi
>  
> -if [ -d "$basedir/runner-0/" ]; then
> +if [ -L $basedir/runner-0/latest-result ]; then
> +	prev_results="latest-result"
> +elif [ -d "$basedir/runner-0/" ]; then
>  	prev_results=`ls -tr $basedir/runner-0/ | grep results | tail -1`
>  fi
>  
> @@ -325,6 +327,9 @@ runner_go()
>  	mkdir -p $TEST_DIR
>  	mkdir -p $SCRATCH_MNT
>  	mkdir -p $RESULT_BASE
> +	rm -f $me/latest-result
> +	ln -s $_results $me/latest-result
> +
>  	rm -f $RESULT_BASE/check.*
>  
>  	# Only supports default mkfs parameters right now

