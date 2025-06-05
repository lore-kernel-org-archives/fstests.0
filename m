Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B10415853B
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144254; cv=none; b=V7qouExNDO9YFixy6V48jOJ/RP2buwoxLZLCsfTaSnJyeQJSBpLA3I1PtIOb+lfU/WGnGP0JzW2WP/BmxFgfCzvRYLY91pdsfJc7/teMFtiykry+kUlFR5SRJ0JjdAix2z8y/9uivngaliTh9IO8onOHTNkWwYhipYWgxJGp/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144254; c=relaxed/simple;
	bh=RyvXdEJbqyUl9kAT21DMLDdXQJ5KeRBFWaOc/9QQQBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAwiZ7kWIdk0jEROGrvaSE5H4p7H2nYCrO2IRwOZPtrbKPuNaK2xv19glNouRmfbIuiDgGlwThvcoI4yCdFAHDDwCNIevLpm7n9hZybFJSZQ1MHIYGCT3UNTVfYvvraPngmWw44lVgYthpODTDm7AaLtdJRxX8xp/bbYrjS+hqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0AOYoLi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0AOYoLi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749144250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NilGyannDkSG1qdzHF1/Z/9qZ2bbYcqHW2ABfSOqUNg=;
	b=O0AOYoLiSTAfpPVb+bPMvTSdEpIlZj/v7vjwHLCtL2Vtnnuhc6a9+xqhf2JqGAQRvoFqCO
	au+VPlIcD9x/UmvxWePHg4f6zNf34rWuhhVOxas+PTjXzk6oaKNICWFGuXKwq0Hu9Ljjv/
	SJouUF899I1DjFbqIZ2whYgsEjCyGI0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-E9-ZUua9MveS2YwBmAVE7A-1; Thu, 05 Jun 2025 13:24:08 -0400
X-MC-Unique: E9-ZUua9MveS2YwBmAVE7A-1
X-Mimecast-MFC-AGG-ID: E9-ZUua9MveS2YwBmAVE7A_1749144247
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-747af0bf0ebso1008687b3a.1
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 10:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749144247; x=1749749047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NilGyannDkSG1qdzHF1/Z/9qZ2bbYcqHW2ABfSOqUNg=;
        b=KkK5nDFBG+7i6wa47EuB7tq9CYlI0munOxOLnr2vf45UEoBat0O/qXGXNLPJXTCQ2M
         uj1gVKHHMLzuNoMc6yYAAWSYRN8deiYC1qs9GDCjQWrO42XlYweI8N5Go+KVV52T6NLw
         1qgpx6rEHYbk7UarExMmXqGsiJ+FWo5hwXh7TlWFLQTBAMr9Ps+0Es8Qy+ILj6GjY1lK
         Eq6CVvpmHypKRO+NwB8HUid2690VzioOycliDE3ZUG59rRhFFKduPNC/1DWUhP8XrThp
         JLi7aDuftoOLEAzxQGDEuu/vSEvYGDWqEktNoKs1m7vFoVkbKECW3bvPYdBAFPXrST7i
         /VSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnk8/9ypwCBb59E/1DLAS7l9s4xQWhRAakUhu64GkTJv54Ll5TbK/UBpzU2uq7mnNuW1Yg7h2w@vger.kernel.org
X-Gm-Message-State: AOJu0YytxGeo9oBoQr3lEI0M6JfxNGA3qErZwhhnXIzvONGrOEjAMrOM
	4w90HwMvUfitvhDhgCw92qOMgkWfeO0jMNQTLPzM19kFM/VwxmtUuxegjnCzUa6VVy3O8aes9Wd
	TP2OarlJCQKHm0FVkYEj1VNmooaW/CqJdeXr1wBMHCOYVn1deaTUr0XnRWSU=
X-Gm-Gg: ASbGnct/sMjm9MyOxwzDu72GbtyHgXEBjD6epU8HcTEjlcyuLyKpC1HK1zd06lPfcmg
	BLolswaoImbmvsxS7Ic5CoPcBdOKpil2mpymembz6lKFedQ0KjOmMhvL/of/hTztAPmMHNS/9dY
	Z+4f0WokfSP1UBjlhRB+ndSuCMRYVVTMEUt+3zNd5MgpeXO8euexQb0y5jm/XskLFJq7LntnesV
	r5fOZxaU0lSPI5MHMsEQTpfFKY+JcCOr1M5f5Nxg4Hm1YNGekqOUabxDlPy1nuem10dNvipEtcd
	HVdgugFM6vOSwoX9jqqFelLc8LEa+ZO9m2ocnP8SIXQo9QGPFnGs
X-Received: by 2002:a05:6a00:882:b0:740:b3d9:c889 with SMTP id d2e1a72fcca58-74827f309acmr683758b3a.22.1749144246794;
        Thu, 05 Jun 2025 10:24:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFSQoVwsczuKqqBTzijzTKvkEvwy43OL6IAzBrfLN/FFYyL4P4R/+ZLi56/LOch2dVUXhGGQ==
X-Received: by 2002:a05:6a00:882:b0:740:b3d9:c889 with SMTP id d2e1a72fcca58-74827f309acmr683725b3a.22.1749144246404;
        Thu, 05 Jun 2025 10:24:06 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff7407sm13428524b3a.178.2025.06.05.10.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:24:06 -0700 (PDT)
Date: Fri, 6 Jun 2025 01:24:01 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org,
	Yang Xu <xuyang2018.jy@fujitsu.com>,
	Anthony Iliopoulos <ailiop@suse.com>,
	David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH v2 5/6] generic: remove incorrect
 _require_idmapped_mounts checks
Message-ID: <20250605172401.v7lpervaq6bbxgn2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250603100745.2022891-1-amir73il@gmail.com>
 <20250603100745.2022891-6-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603100745.2022891-6-amir73il@gmail.com>

On Tue, Jun 03, 2025 at 12:07:44PM +0200, Amir Goldstein wrote:
> commit f5661920 ("generic: add missed _require_idmapped_mounts check")
> wrongly adds _require_idmapped_mounts to tests that do not require
> idmapped mounts support.
> 
> The added _require_idmapped_mounts in test generic/633 goes against
> commit d8dee122 ("idmapped-mounts: always run generic vfs tests")
> that intentionally removed this requirement from the generic tests.
> 
> The added _require_idmapped_mounts in tests generic/69{6,7} causes
> those tests not to run with overlayfs, which does not support idmapped
> mounts. However, those tests are regression tests to kernel commit
> 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers")
> which is documented as also solving a correction issue with overlayfs,
> so removing this test converage is very much undesired.
> 
> Remove the incorrectly added _require_idmapped_mounts checks.
> Also fix the log in _require_idmapped_mounts to say that
> "idmapped mounts not support by $FSTYP", which is what the helper
> checks instead of "vfstests not support by $FSTYP" which is incorrect.
> 
> Cc: Yang Xu <xuyang2018.jy@fujitsu.com>
> Cc: Anthony Iliopoulos <ailiop@suse.com>
> Cc: David Disseldorp <ddiss@suse.de>
> Fixes: commit f5661920 ("generic: add missed _require_idmapped_mounts check")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Is this one changed anything from this ?
https://lore.kernel.org/fstests/20250526175437.1528310-1-amir73il@gmail.com/

Due to above link has been reviewed by Christian Brauner, do you want to
add his RVB to this version?

Thanks,
Zorro

>  common/rc         | 2 +-
>  tests/generic/633 | 1 -
>  tests/generic/696 | 1 -
>  tests/generic/697 | 1 -
>  4 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index bffd576a..96d65d1c 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2639,7 +2639,7 @@ _require_idmapped_mounts()
>  		--fstype "$FSTYP"
>  
>  	if [ $? -ne 0 ]; then
> -		_notrun "vfstest not support by $FSTYP"
> +		_notrun "idmapped mounts not support by $FSTYP"
>  	fi
>  }
>  
> diff --git a/tests/generic/633 b/tests/generic/633
> index f58dbbf5..b683c427 100755
> --- a/tests/generic/633
> +++ b/tests/generic/633
> @@ -12,7 +12,6 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
>  # Import common functions.
>  . ./common/filter
>  
> -_require_idmapped_mounts
>  _require_test
>  
>  echo "Silence is golden"
> diff --git a/tests/generic/696 b/tests/generic/696
> index d2e86c96..48b3aea0 100755
> --- a/tests/generic/696
> +++ b/tests/generic/696
> @@ -17,7 +17,6 @@ _begin_fstest auto quick cap idmapped mount perms rw unlink
>  # Import common functions.
>  . ./common/filter
>  
> -_require_idmapped_mounts
>  _require_test
>  _require_scratch
>  _fixed_by_kernel_commit ac6800e279a2 \
> diff --git a/tests/generic/697 b/tests/generic/697
> index 1ce673f7..66444a95 100755
> --- a/tests/generic/697
> +++ b/tests/generic/697
> @@ -17,7 +17,6 @@ _begin_fstest auto quick cap acl idmapped mount perms rw unlink
>  . ./common/filter
>  . ./common/attr
>  
> -_require_idmapped_mounts
>  _require_test
>  _require_acls
>  _fixed_by_kernel_commit 1639a49ccdce \
> -- 
> 2.34.1
> 

