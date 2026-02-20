Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483122EC09B
	for <fstests@vger.kernel.org>; Fri, 20 Feb 2026 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771607068; cv=none; b=WYZbUacOrPz0bnsK3pow1dZK7rBzqbiOoSaJzJjuOHaOhZedeNU6INde2YV/ShaF10R9mB+cE0JmrtkwVhmyMxLyyI24zPo5m5o9BKZ8bNZ+sF+J3/KCZi6bsCBNyLiKO5lGiMkHhi6IvVglAPwk0UoyQTsAlrNA+FUrxLMPcDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771607068; c=relaxed/simple;
	bh=lWC7kIUn6Kd2qGxzhX0BjMlBKu/uQyUotx5PYF3zyLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cxa5QEV2pM+bxvXS3fc21rOgagxV/F1Ww/UWr2PPaBSZb7x9+VhSTbN3TyC3khkbegKl5vS62FCu8LGOdUNOat5+uebiLqNyr3DuwViVQGySJLTBKD+xnTjDCT4Brl4VaoDjluaqiCZieA++vTPmf9moQYMFJ8qmdKEGb/Rv/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5Wg7hrQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ukkg3w81; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5Wg7hrQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ukkg3w81"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771607066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rKfTudlhTYtyQKKmPYvZFA0VzYKo3BAqGcuaoLTxpEw=;
	b=Q5Wg7hrQbPTJXt/3xd5j+zssTnmSzAQcQ+Qpxo14OZz6iRXjtUNOpVuF8AV68a+oFGlNDH
	ZipXw5l6lrHy42RYy/EJUZ3PBlS+MaprD9nYnrNgrw0r+fAboNv2Kh/eB4rJ8MjdUojhBG
	IFd9zfduwEhlIaUChhmrEWsMHIAuErI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-TzL1E0w4O6eQkTt-WkMCJg-1; Fri, 20 Feb 2026 12:04:24 -0500
X-MC-Unique: TzL1E0w4O6eQkTt-WkMCJg-1
X-Mimecast-MFC-AGG-ID: TzL1E0w4O6eQkTt-WkMCJg_1771607063
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ab0b2e804cso27255525ad.3
        for <fstests@vger.kernel.org>; Fri, 20 Feb 2026 09:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771607063; x=1772211863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rKfTudlhTYtyQKKmPYvZFA0VzYKo3BAqGcuaoLTxpEw=;
        b=Ukkg3w81nZ7lKcvW/ps3K8xTLUqNMtAjCoGJBo80qF4cVtC/scUrrpVYAclKmw+MQS
         YizCKyJ+KfX+o515V93wntzoQAnbvOm9sZIIbNNN2ATklBEZZSgV5h4uxixD4PnB0shk
         Z6H9EREOSDfWj2ZYoLpz8Pbz+GXevGBiG2ItGhW2WmfmVFukqAcCAN2DDN2tk1c0MWFD
         jRpKHRuRONhkPejsnilyBH0Zic0m9TGdT/qvv8BIw/IbDiA1m9eCCe/BRz3ZQd+5ZOcz
         ih7+S3FEbqtCU9yXaKFOgAyh8FVcA1Np94Pq/dPNeWTwLCbCWDVmxrLuW4sX7ZvPm3kJ
         Rsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771607063; x=1772211863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKfTudlhTYtyQKKmPYvZFA0VzYKo3BAqGcuaoLTxpEw=;
        b=OOCFvxVqNPImRUQ1gR5g6wTBu42djIF8s3YEc8Q+jGw+MbPmknJlVFigH9BsV+JCmt
         cNos2Vr0er3RD+y+hCfFSYGGuvrosqh18gtW+En99DrBnI5TOCVSLEZR/eEyjPZ8PKTs
         s9f80Bx1TraNqqC2qVy+iUBWfmBeHBc7rlFdtF9VxB0/kyb3owl519N/1d1Baly/Gsyj
         Ygb5y//5JGPC34L02wqdOC6ftDWKZQ009TvdzGX30DjLilIJxldEcnoYtCmcvc5klCvx
         Gu3jEHJEFGgTCT6FmB6Xa4AW+11OBR5YDKB/XGX2I4TYLFCAvwxFgHCVCY2pTDo9hKXq
         sUfg==
X-Gm-Message-State: AOJu0YyL1iQisFKChtVsAmKOta1PyH39Pm4TZPaiSWEnVT6Jb5RXHN/x
	hU00NwZqu3WLGAZWFI+4S5GNErb36DYQGeOPJZcCZoYQHCMFNF318tYMvBIRzShhHLOT3pKuePv
	TOKj94GDswE5YbCdTEd8yQmLPiLf0zG5MxvYScbxdg6Kiuq4HV+nhYa4OPuA=
X-Gm-Gg: AZuq6aIguXdbCa8p1hhSShuwF7wldcXuI+EG39N88WxIaLLV1mg8v1RpGC1GEcYMWWH
	owZIUqt2UeRpkLQCWExFlY5bCL7IOfjjA/PnA4K775+IW2nd4XegrXMoZApK4S3tavRmfddVdLM
	UF30Dod7WyFz6v2lARgHyEECcsYzXz2mrVRb0vfuzdJhsbNFzksFPeexs6TQH3ttck3MGv4YKU0
	aU55Q7+rr9YoDg+P+D5AXLjDeehnVkZHCDgvNQByxXxfMnK9yq1LWs2vlaBoPaitWq544/gH+cI
	INSWFVH69UPyX+ztuiT8moxtIcXN4LLk9hlEp3gzZUCBOwuX3kkkFfYnzBZkyTSg0LWlGU0gBLK
	bP587CUD4fvukGSXe1qADStS5c1w+Z25idf3Eb0OOvrLuJCopBuVW5koXvtCxBw==
X-Received: by 2002:a17:902:ea07:b0:2a7:a5b3:bf51 with SMTP id d9443c01a7336-2ad74418aeamr2151445ad.5.1771607063278;
        Fri, 20 Feb 2026 09:04:23 -0800 (PST)
X-Received: by 2002:a17:902:ea07:b0:2a7:a5b3:bf51 with SMTP id d9443c01a7336-2ad74418aeamr2151075ad.5.1771607062680;
        Fri, 20 Feb 2026 09:04:22 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5c20sm212537305ad.46.2026.02.20.09.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:04:22 -0800 (PST)
Date: Sat, 21 Feb 2026 01:04:17 +0800
From: Zorro Lang <zlang@redhat.com>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, fsverity@lists.linux.dev, ebiggers@kernel.org
Subject: Re: [PATCH] generi/579: handle quoted cmp output
Message-ID: <20260220170417.sbykhwr53sah2s7g@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260219152524.1770469-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219152524.1770469-1-aalbersh@kernel.org>

On Thu, Feb 19, 2026 at 04:25:22PM +0100, Andrey Albershteyn wrote:
> diffutils updated cmp with more consistent quoting in commit:
> 
> 	69ae797392bd cmp,diff,diff3,sdiff: quote more consistently

Sigh... changing the default output of core commands again.

> 
> This causes generic/579 to fail from time to time due to grep not
> catching these errors. Remove quote to work with new and old version of
> cmp.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  tests/generic/579 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/579 b/tests/generic/579
> index d5fab4892e9a..19ffd4954db2 100755
> --- a/tests/generic/579
> +++ b/tests/generic/579
> @@ -71,6 +71,7 @@ for ((proc = 0; proc < nproc_reader; proc++)); do
>  			# match, regardless of whether verity has been enabled
>  			# or not yet (or is currently being enabled).
>  			cmp $orig_file $fsv_file |& _filter_scratch | \
> +				sed "s/'//g" | \

Thanks for finding this bug. So the output of cmp isn't consistent between the
old and new versions, which is going to break later cases (base on cmp) on old
or new diffutils version. We usually handle this by wrapping it in a _cmp function
to keep the behavior consistent, refer to how we handled common/attr:_getfattr().

If no more review points, I can merge this patch to fix this issue at first.

Reviewed-by: Zorro Lang <zlang@redhat.com>

I'm not sure if we need further updates on diff command, we can revisit this
if any bugs are reported.

Thanks,
Zorro

>  				grep -v "SCRATCH_MNT/fsv$i: No such file or directory" | \
>  				grep -v "EOF on SCRATCH_MNT/fsv$i"
>  
> -- 
> 2.51.2
> 

