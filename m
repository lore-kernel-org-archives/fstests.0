Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E22555B
	for <fstests@vger.kernel.org>; Wed,  7 Feb 2024 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297609; cv=none; b=GAKJIckNHyceHdq6nxF+3CYXllGIRDmBUgRUdxTTogoRsASwkTNMUIrCWKXGoamx/6S4JOo92M2jcT7H8locRCI9Xds29/zfiBYV/mZaWtVplMC95SwJ0U4IvBbq/oLxss+HLTCxg+ChmzsPrRqDG0IM303U+VkY9sXtmrGSUNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297609; c=relaxed/simple;
	bh=m0GMkleFqcv/6Jb3HOEwKKjsHUspeMZgm+Xsc+PBesM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsK9kFjQ1dBAyNc9qhAAd9Ust8HBMRoXExhc4Ap/3PvhUrTtgLSbcqZzBHsT5OBeW5cLyiaJoTkryRhBRB15qYBGJRnP20HeqXMOmmstvB2kOcSDFby5gQS5PBlZp29B7nGiT0Te4U5evMDT0Avwkd/SaX4wLVbiakts+oaetkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crB593sC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crB593sC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707297606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lxyblsWmvOyl0stztwzdsVJd5ZkmOYwSVPzfxOiD2ng=;
	b=crB593sC5CCLN0fi9x/3B7dmTVQH+bmUV2SXkll01OKclqmiqmBSvfa/b86MnAiN3gn3Eg
	OdEmjmvciTCd7wdv/7cPaW9cpBLDU62jZ/q3QfTGVK/Wm1RYhql18lKnjTdF4TjbaOwKnr
	FVnxJM7Znl3cNGI3TS4RJTIwBimmQfg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-Gj39Yuv-PmuNqLu5FdxChg-1; Wed, 07 Feb 2024 04:20:04 -0500
X-MC-Unique: Gj39Yuv-PmuNqLu5FdxChg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5ca5b61c841so247686a12.3
        for <fstests@vger.kernel.org>; Wed, 07 Feb 2024 01:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297603; x=1707902403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxyblsWmvOyl0stztwzdsVJd5ZkmOYwSVPzfxOiD2ng=;
        b=MTFJ0/aM/Gidak1Zw5VBV78677tO7G4ZLTWZbm6M8iIyjc7RN+EZ3cwL0/j9zEIYAY
         6l9fw4dB3GQ4MzoEPkFClW2By4Wrr1tlwN8NlzQN0174kvNCB5QbhtkNPzfjOi1qJJL0
         UCM9woRrq6MA6baeTDMwSsR4FhTtBKpTDhr0MzalVJWPzGfubZN9hatu0hk2G54a6BiP
         8rSIxS4KhishRzTebUYriqQdR7RyVgiG87QRMVPe4/PguTbk8UrqKKIpAHD1Ih8Z6UPX
         1dqFt0h+CWcbz5f8ZaFf7Qjpd1QhHzJDHpo2gP7BSidzmjirNlrAuGxjap2OHhJlVq8e
         ulqA==
X-Gm-Message-State: AOJu0Yzu8dMiSFkVdlZImq0TINuwZXW8/23ZPWxCxre3i9zrsZBbuCn6
	nBr3E7EfLSESo3KymgoCD3vSFVoH5e+ypJYXPpKn0MRAA92GxnKoFqct+KwVCZTDKCmpAdCUVKR
	jEG0WzUelfWfmeK8BI8taOr7i1fzSoHR3FHtHdh/DLho01N8dDy2dTuu5/w62iB65Bw==
X-Received: by 2002:a17:903:110f:b0:1d9:626b:ae3d with SMTP id n15-20020a170903110f00b001d9626bae3dmr5464512plh.18.1707297602816;
        Wed, 07 Feb 2024 01:20:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtS7wBx8OO8IKRF/W/EA2rTyYPqWheru2SrcltTOVxCEhL2w32DpfclimiiX7PzMEMj6D/bg==
X-Received: by 2002:a17:903:110f:b0:1d9:626b:ae3d with SMTP id n15-20020a170903110f00b001d9626bae3dmr5464499plh.18.1707297602488;
        Wed, 07 Feb 2024 01:20:02 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f6-20020a17090274c600b001d974ffa1fcsm949899plt.173.2024.02.07.01.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:20:02 -0800 (PST)
Date: Wed, 7 Feb 2024 17:19:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/2] generic/682: update and fix-up golden output
Message-ID: <20240207091959.w2hckaplrjqfr3j6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240206173625.18623-1-ailiop@suse.com>
 <20240206173625.18623-3-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206173625.18623-3-ailiop@suse.com>

On Tue, Feb 06, 2024 at 06:36:25PM +0100, Anthony Iliopoulos wrote:
> coreutils v9.4 introduced a change in the error output of mv under
> certain errno values via commit 3cb862ce5f10 ("mv: better diagnostic for
> 'mv dir x' failure"), which broke the golden output.
> 
> Update golden output to match the change, and further add an output
> filter to avoid having the test fail on environments that ran with an
> older coreutils release, taken from commit d9323ad7a05e ("generic/245:
> Filter mv error message").
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
> v2: consolidate g/245 and g/682 mv filter into common/filter

Thanks, this version looks good to me, I'll merge it. But if you're
not hurry, it won't be in the release of this week (will be in next
release), due to the release of this week is a republish of old
v2024.02.04 which was abandoned, I hope to do as few updates as
possible on it, for safe :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> 
>  common/filter         | 14 ++++++++++++++
>  tests/generic/245     | 14 +-------------
>  tests/generic/682     |  2 +-
>  tests/generic/682.out |  2 +-
>  4 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index 36d51bd957dd..e7473c9568e9 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -481,6 +481,20 @@ _filter_mv()
>  	sed -e "s/^renamed //"
>  }
>  
> +# According to the rename(2) manpage you can get either EEXIST or
> +# ENOTEMPTY as an error for trying to rename a non-empty directory, so
> +# just catch the error for ENOTMEMPTY and replace it with the EEXIST
> +# output so that either result passes.
> +#
> +# Also, coreutils v9.4 modified the error message when a nonempty
> +# destination directory fails to be overwritten, filter the output
> +# accordingly.
> +_filter_mv_output()
> +{
> +	sed -e "s,Directory not empty,File exists,g" \
> +	    -e "s,cannot move .* to \(.*\):\(.*\),cannot overwrite \1:\2,g"
> +}
> +
>  # New stat(1) uses statx(2)
>  _filter_stat()
>  {
> diff --git a/tests/generic/245 b/tests/generic/245
> index 81ce4d4e2450..8b8e3e219255 100755
> --- a/tests/generic/245
> +++ b/tests/generic/245
> @@ -26,18 +26,6 @@ _cleanup()
>  	rm -rf $dir
>  }
>  
> -# According to the rename(2) manpage you can get either EEXIST or ENOTEMPTY as an
> -# error for trying to rename a non-empty directory, so just catch the error for
> -# ENOTMEMPTY and replace it with the EEXIST output so that either result passes
> -# Also, mv v9.4+ modified error message when a nonempty destination directory fails
> -# to be overwriteen
> -_filter_directory_not_empty()
> -{
> -	sed -e "s,Directory not empty,File exists,g" \
> -	    -e "s,cannot move .* to \(.*\):\(.*\),cannot overwrite \1:\2,g"
> -}
> - 
> -
>  mkdir $dir
>  
>  mkdir $dir/aa
> @@ -46,7 +34,7 @@ touch $dir/aa/1
>  mkdir $dir/ab/aa
>  touch $dir/ab/aa/2
>  
> -mv $dir/ab/aa/ $dir 2>&1 | _filter_test_dir | _filter_directory_not_empty
> +mv $dir/ab/aa/ $dir 2>&1 | _filter_test_dir | _filter_mv_output
>  
>  status=0
>  exit $status
> diff --git a/tests/generic/682 b/tests/generic/682
> index a51d18338742..b70a4d02e429 100755
> --- a/tests/generic/682
> +++ b/tests/generic/682
> @@ -62,7 +62,7 @@ for ((i = 0; i < dirents; i++)); do
>  	name=$(printf "y%0254d" $i)
>  	ln $scratchfile $stagedir/$name
>  	su - "$qa_user" -c "mv $stagedir/$name $scratchdir/$name" 2>&1 | \
> -		_filter_scratch | sed -e 's/y[0-9]*/yXXX/g'
> +		_filter_scratch | _filter_mv_output | sed -e 's/y[0-9]*/yXXX/g'
>  	test "${PIPESTATUS[0]}" -ne 0 && break
>  done
>  repquota -upn $SCRATCH_MNT >> $seqres.full
> diff --git a/tests/generic/682.out b/tests/generic/682.out
> index b74708117237..db22d5f60487 100644
> --- a/tests/generic/682.out
> +++ b/tests/generic/682.out
> @@ -1,3 +1,3 @@
>  QA output created by 682
> -mv: cannot move 'SCRATCH_MNT/staging/yXXX' to 'SCRATCH_MNT/dir/yXXX': Disk quota exceeded
> +mv: cannot overwrite 'SCRATCH_MNT/dir/yXXX': Disk quota exceeded
>  Silence is golden
> -- 
> 2.41.0
> 
> 

