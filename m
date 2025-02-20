Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7E71E3DFE
	for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035549; cv=none; b=HBbduQtlxr49Mi32SsQyYS1q2Dw42IqC3wpYGmXCtVWpjQDIAW2AnV0vdqtYqZ0GmPnauCZ+498NsxeC1+pMqTxhZWw+TTXrTDd54gvrauHckUibdqMLwYu2mnOYYxW92DP8JhGVHFdMFEEX0ewJDhYanr1kFPrm2DdlhmkzFcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035549; c=relaxed/simple;
	bh=8YVuQAslbkfLEQDIAZYbUzvrelrSYQFXSmpjLTONP/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYt9AteqOLEWl5vR4A+Axqw6Qu7GWcn9b+aSMkyoMmQ9DW57Tc6ozQCU72TTMkynuarOjEnnbsu8rY6r3lRVdY6DpttWCLF8d+/HTrdrfTYo/QFH1eymvx0s27sItL1yMXSO9vf3xcYdYmqQ2jWWWsWxzdeSfJjlHVYyKotnVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7TdGZ93; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7TdGZ93"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740035546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EaFAX74t1gs6NyqNyPG2j338Nti9GueZGyOwS+9kaCc=;
	b=J7TdGZ93x0jkUJfJ5DFBaw4QA5HvPssSkski0FcnierutVCd7Ly1AK02Sz/63GMpGbQaqY
	nUbFLrebGCFInPPlxTIJ5tsR+/xw8HieN16bRtCvy1Z40GyU87ZVSs3wncchSPLE37gdjI
	EtiprxVL0oiExNWGtwiXwvs3jjqNVW0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-jpCC13_iOhymvTGhWlHUPA-1; Thu, 20 Feb 2025 02:12:24 -0500
X-MC-Unique: jpCC13_iOhymvTGhWlHUPA-1
X-Mimecast-MFC-AGG-ID: jpCC13_iOhymvTGhWlHUPA_1740035543
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22109f29c99so12494595ad.1
        for <fstests@vger.kernel.org>; Wed, 19 Feb 2025 23:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740035543; x=1740640343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaFAX74t1gs6NyqNyPG2j338Nti9GueZGyOwS+9kaCc=;
        b=rm5Tvq2KZTVxmGXmZ6toU3VZkBNwD4AkfsubQ9xNDGHvNpqkJxhDaBg/Mf+7T2EWaO
         z6OF0YrXshsmGwRPV4UOJnTpOsC+G7KtuGtrqMeaM0Q95Sz83dBkSqwc60DrhR+Hy67k
         b47mWJ8gabSLEPI2+l7hoSEf2R2q20/+Ni2kPVfVNjMObkoZYfeT8T/GTmg/pRIuJVNI
         fael6UHWvoo5ab7NzSJnHcrG3WrACWonOiz2zH5NIIg6mxj+enkd62o+bRb+RLAAvIPG
         ilFL+YZVDg3mRefQvxU7kI1iPSuGRxIeTGyi/1hQ0YF9e2roZfsGdP5oTlVZFhBKr57m
         82ag==
X-Gm-Message-State: AOJu0Yzhm6K7jhn9AsS8pUlG+E+Oebuy9Uln1ZN67AyLFeRYyhVa5cca
	j64Sg4favE2tbYqa1SMETC/XDtx5w5+TxxKmEGjEtthg4Y+vGsNzKS0ClcPtPe/EBwaPcRnip98
	nZ9kbsiVICpyf9NZjwEjV5P/6YF4ADWL+6auYXT1OtfiznGYji1eEmKk=
X-Gm-Gg: ASbGncsT4J+ptMVC+HnYaYHQgyGQfghUKLkgw7vipfJAd2uScn42x99xYbjRa2TqA37
	BnYKOm1XXfOuHyJGaBkilPhOtQqEVXY7mmkOmGlwgfOPdIlzWS1NjlDxAwohVdba+AOjcbL5iSD
	0N83r+3//5+ucCIXW7nh3TdSrRARDz/Jikj0EGVhLwja2T8P1Hnb1ChJYyTjmG3qTDjrg7MnLsG
	Q3xKio8FAxL1i0ubV3gMK6JfcPO9Z9P5kV5/4thgJWZO01M2FmJEk1sEEPB5mFxiwRW6LpccpYJ
	y8CQ5UISX6X7SFkmiQjyfA4s6PmaFFk7aJwBVL6rMSXncg==
X-Received: by 2002:a17:902:f68c:b0:220:cd9f:a186 with SMTP id d9443c01a7336-22103c62dc3mr348278145ad.0.1740035543031;
        Wed, 19 Feb 2025 23:12:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8x6T6Ejn/eYkKhTAgH+NnPxxDvQ1EKHtn5tiQTYhWX1aWREuV8jpXdDoSeOL+lOL4XIdAQg==
X-Received: by 2002:a17:902:f68c:b0:220:cd9f:a186 with SMTP id d9443c01a7336-22103c62dc3mr348277855ad.0.1740035542687;
        Wed, 19 Feb 2025 23:12:22 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349061sm115894975ad.5.2025.02.19.23.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:12:22 -0800 (PST)
Date: Thu, 20 Feb 2025 15:12:18 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH fstests v2] generic/126: run it inside its own
 subdirectory
Message-ID: <20250220071218.kwb3z7jcbc3oqjjg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

Hi Jeff,

Thanks for fixing nfs test issue again :)

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

I think these two steps are useless, due to you let _cleanup to do it. Others
looks good to me. If you agree, I'll help to change that when I merge this
patch :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

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

