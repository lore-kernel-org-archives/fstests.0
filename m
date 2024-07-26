Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A6311C83
	for <fstests@vger.kernel.org>; Fri, 26 Jul 2024 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014247; cv=none; b=RMrwseov6cAFyqfPj9TqhTMiEAwajDr1XnDLCOTpV+apMomcaSw+hOt+IDSZTRKJp6Dgid6v+Szfj+gJdlT4Zbwd/fn/iMtk7EsjOf7ThBpIEHSz0qIYsAFdffAl+61Klm32NRap51iFDcK24WUX1tF+tDgfcTpH0yIA39Eq5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014247; c=relaxed/simple;
	bh=GEwKHBVtx1N26/ujHSceefTYpD0QGzCg6xKzapPXe84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou/kGTROpn6lisSpN1ZCrTyeuJfoOuK5XNOAXfD1ejb1Wk4WQktEIw5FzwjnNJ3uQvkS4Q/OsG5KXJk08wbcEdf6IgHSMD1+zqd5jSA/k00sDk8+NqB0V/PU6qmXOtFCllqVPe5UMtCL4WsnUnlDn5uT+zciVtrPf6om1pyZV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJnbOIMK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJnbOIMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722014244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pw3IWU7w6zZsJSaAnBwaTqswOfBwnb8wRbLaVBbbqJ4=;
	b=WJnbOIMKhg0YdKP7hLyCXFlN+bZEp6Ow5sI43Gf+nWS38MRl3/sl1FuROfewOnRvhEwZ0d
	D4fvZJd/8QEgp3eVeUQqJfGPg29CIuHzT+MQhQEcBZ5TUtk2jceGsNE1Q6KPPvYu6VVJsa
	3fHp5lc16Z8/NsacoHxD1SVM1FtYwew=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-0bbouu4kO_Ww_HQIdKNhkg-1; Fri, 26 Jul 2024 13:17:23 -0400
X-MC-Unique: 0bbouu4kO_Ww_HQIdKNhkg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1fc58790766so8350085ad.3
        for <fstests@vger.kernel.org>; Fri, 26 Jul 2024 10:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014242; x=1722619042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pw3IWU7w6zZsJSaAnBwaTqswOfBwnb8wRbLaVBbbqJ4=;
        b=Aw6PMaZChme53UeCueklINFn8KmFXNVlnOX/qhiqMsDuNI/wp3H3xoc8KXiUVNyaZV
         BPuIVL6I7aRJb9VVuh4YrRY/rsAPAgKhDdOtpeDGUd/fd8/tF3KL0INaVdqY1b7SzJ96
         JW6UIFZbrbQPwkpeDj8GBF4LvkEH/8Cx5EG4k3F0gGPqTEyC9B0StbBeLWLs0BOeT4Oh
         1lKGMp2+1bGYVfWWqxKQsr4LVsaz37Xa7ySLm7W8jqEoROPDIbfigKXYrNEU0pvikreL
         FiUqHwV8Yih37MMf54OKl0MKa+IUZIb67aiW++deI/noNjeZ7UFWQlwRySJb3RniiDTe
         Ctrg==
X-Forwarded-Encrypted: i=1; AJvYcCWvqhbkG9R2AmhvJB+QWeBWmueLCCkaKlMHyT4RJem+ZPvy1UrXNhW95f94FgcmnZi+kLJQSBbNQzd9b2RKaNVUTFhhqLOlVQ==
X-Gm-Message-State: AOJu0YyV55L5qA0Pvzkjqa0xxujZ/C17+3AeG+7JFuCujAXiyaSu/dYi
	RHewUgQ4oHxkKCL3KWd3Osfs6GqxdvLVIai5gbGsZ8x4W0DlUmgDc0VoHHmY+o1GLOV2UKGYRr7
	iEe2tG8mvmykmGTZp/MnkIFxJmEAQip6DKKdRKy97omrqSDMmQhg9TtA=
X-Received: by 2002:a17:902:fd08:b0:1fd:6d6d:68e7 with SMTP id d9443c01a7336-1ff048b07b9mr3275355ad.43.1722014242118;
        Fri, 26 Jul 2024 10:17:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV8kswWkxc0kwXS2BsEOM7JImFw8sfMaRuWDfDSbqVn5HjOy4+vI6im3jP6KzTizpAG6n23g==
X-Received: by 2002:a17:902:fd08:b0:1fd:6d6d:68e7 with SMTP id d9443c01a7336-1ff048b07b9mr3275145ad.43.1722014241786;
        Fri, 26 Jul 2024 10:17:21 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d22742sm35370225ad.107.2024.07.26.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 10:17:21 -0700 (PDT)
Date: Sat, 27 Jul 2024 01:17:18 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ma Xinjian <maxj.fnst@fujitsu.com>, fstests@vger.kernel.org,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] generic/754: fix _fixed_by tags
Message-ID: <20240726171718.46mida3edxf5dm55@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240726165107.GR103020@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726165107.GR103020@frogsfrogsfrogs>

On Fri, Jul 26, 2024 at 09:51:07AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test requires an xfs_repair patch, so note that in the test.  Also
> update the kernel git hash since we now have one.
> 
> Reported-by: maxj.fnst@fujitsu.com
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/generic/754 |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/754 b/tests/generic/754
> index f73d1ed611..7afda609f5 100755
> --- a/tests/generic/754
> +++ b/tests/generic/754
> @@ -13,9 +13,12 @@ _begin_fstest auto
>  
>  _require_scratch
>  
> -test $FSTYP = "xfs" && \
> -	_fixed_by_git_commit kernel XXXXXXXXXXXXX \
> +if [ $FSTYP = "xfs" ]; then
> +	_fixed_by_git_commit kernel 38de567906d95 \
>  			"xfs: allow symlinks with short remote targets"
> +	_fixed_by_git_commit xfsprogs XXXXXXXXXXXXX \
> +			"xfs_repair: small remote symlinks are ok"

Thanks for this update.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +fi
>  
>  _scratch_mkfs >> $seqres.full
>  _scratch_mount >> $seqres.full
> 

