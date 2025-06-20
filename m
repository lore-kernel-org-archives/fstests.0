Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6E1A76DE
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750436963; cv=none; b=nC9+7Wxz1pU6hzREqjIZKjwAJIVz0dN1ZTevmJNGYQ4i3fHeLhslVjcnu8Nf77lBAXpBeYYFCaNoWuzbKiB0xq27G04/50fBivjBx+xe7fUrLV0Js7e+/MAb7/KIqoogY4rYFhfTw30s9acWsLeSVDm6gEhSJbzgBvqJMozCn5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750436963; c=relaxed/simple;
	bh=KiCXPzu4GhlpVKvpEo3MIhniRqoJNPYSmGzvcam4eys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0bGtJHcq1IGnFjuxcE41/M40eTCUobCoixH/QFdEw2Ua5Klbk99dKN5jch6uB+kszU3MEFfH0pMtgEOl0y6H+hoRl/t5t0niNq8YE2T5C/3IHdb0LuODJCXExdsYG1bGquRduvLFcGghH7eiOPkVVU1E2gOv4PpoOPWW/IGQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2BZpxPB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2BZpxPB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750436957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/8JkqqZ1rKYnWPDBImOy+wPJHoAzqpV+7SQ26MLGno=;
	b=Q2BZpxPBtRWFvSiGH+GYq0UXcD5dnVzAD1/6moEdfTH1yjmgAMsif1eLH1FreRRwcnltHu
	EIYSHyClAI6zWo/DunQq6uh9CoFuf1kg8lo883kA/t+cNyQURZ+S5/RSMU6IXunLh1/5Dy
	8WLauuGdZp9OUSrnLHMTK2MHG+z1Fdg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-OoVZoXJFPsO-QLu49zRYUg-1; Fri, 20 Jun 2025 12:29:16 -0400
X-MC-Unique: OoVZoXJFPsO-QLu49zRYUg-1
X-Mimecast-MFC-AGG-ID: OoVZoXJFPsO-QLu49zRYUg_1750436955
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748e6457567so1472917b3a.1
        for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 09:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750436955; x=1751041755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/8JkqqZ1rKYnWPDBImOy+wPJHoAzqpV+7SQ26MLGno=;
        b=wtOmoaII1SSqWv+CtOg0mLZwsgYPZ/EM/4BnZIpaRhY0Jo9zcKkBMUFx+q8xfwHeTk
         CirYiYrIvFNrEnb6TcgLBz+b13bfdQf3P88WJM4q9TgvUe+uPyr0oH+WzDLDgxdC3GGh
         W9woZVm/pKuiPBG2QNvCXvQ+IOWcAnZiD2jXm9nC35JHzDXX11SHhvc9tKNJCPUTU/Bw
         r1QOFE/u3cLHDcjqhdsrW9LK5g8QYUzt+Afsm6y8IDpr8Ptuks6M1Jx6mxgh/2NmdWvw
         55S6QER8A54B5asUaBJK2NXIky44L8yzPMv1tik3quKm84zjJ3ScahdUeBvPY6Fue9pF
         XkaA==
X-Gm-Message-State: AOJu0Yw2PVGjMpYZLGIKu9Iy0SPw+zToRYaJHMaIvX9zFT8w1nbmRY3W
	t4nOvHTNHk35rLEpQi32cxxZxeoW+cXVbgdCLB30o+nZDiRe4IJgDl+Op5j95+wuR3/igIRhSYv
	3+/G0lyd7QKUkcR5eRj5ddzQxyQ7dfjsXfh0n68aHGNHYQnyeMWvbDQo7fKItpnyK6qg=
X-Gm-Gg: ASbGnctzw5ztiKnEZlZkllRMis5oOR1Ce9/A09R5CrCjwOfey3XENAIzk8acyavwsbv
	fCT9rUF2RdumEW9JRq/nQYSb8/EMiFeHfKhTBVKXbBe/0L2ZYheysrKHzzf6Fmyk8yYjJZnVGX2
	60c3z2snVREwiTNSM7HRHtRHloyM+kLjpz6m1ZD9Rqz7p+wXtga40ofsNNX4DC4X1mLoFXbWYoa
	N2cj9xTqAh7drF3L/5fdgH3byW/q4DVDqxDFq/7OfMwtBZOxDbbJC0wLcbDI6FgLAsRVebXLi9A
	S9L8Oor8uCEfI+I4Fo9kf7uwxzzkLwkKpGNEIXUul0vdNXh6x+QOq/gi4upwkes=
X-Received: by 2002:a05:6a20:d706:b0:21a:de8e:5c53 with SMTP id adf61e73a8af0-220292c228cmr4646326637.12.1750436954837;
        Fri, 20 Jun 2025 09:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX1Xi4XB8uo1pb9QRDXxV4PcneP8TEaF7i3hcM9jusxk0UM7HAxMKqWy20+tzwMQrO7SGOzw==
X-Received: by 2002:a05:6a20:d706:b0:21a:de8e:5c53 with SMTP id adf61e73a8af0-220292c228cmr4646303637.12.1750436954438;
        Fri, 20 Jun 2025 09:29:14 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6ca165sm2460284b3a.172.2025.06.20.09.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 09:29:14 -0700 (PDT)
Date: Sat, 21 Jun 2025 00:29:09 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/820: skip test when metadir is not supported
Message-ID: <20250620162909.un2fgfcyt5omx7ki@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250619133031.62511-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619133031.62511-1-ailiop@suse.com>

On Thu, Jun 19, 2025 at 03:30:31PM +0200, Anthony Iliopoulos wrote:
> The test specifically requires metadata directory functionality, so make
> it dependent on that as otherwise it fails on kernels older than v6.13
> that do not implement the feature.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  tests/xfs/820 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/820 b/tests/xfs/820
> index 1dfd0dd32e14..8d739c7f6f3d 100755
> --- a/tests/xfs/820
> +++ b/tests/xfs/820
> @@ -16,7 +16,7 @@ _begin_fstest auto quick quota
>  $MKFS_XFS_PROG 2>&1 | grep -q 'uquota' || \
>  	_notrun "mkfs does not support uquota option"
>  
> -_require_scratch
> +_require_xfs_scratch_metadir

OK, that makes sense due to this case trys to enable metadir by
"mkfs.xfs -m uquota".

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  _require_xfs_quota
>  
>  filter_quota_state() {
> -- 
> 2.49.0
> 
> 

