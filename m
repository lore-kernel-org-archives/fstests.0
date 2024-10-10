Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39D2AEFC
	for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728540799; cv=none; b=Y/A2tU7C3JWwOpPEymnAwqd6l9p2dClp58XLeU+Dtkdg+8zei+Zqddd98sUfWNDP2ESeykXdcQFFsqZLl7Oq/Pk7w0GSXzMRM2LUqyvaHDzw5Op71vgsM9DdPu4cbe5EVKfecMx8gipCjsCRH/qyft0o7fRn7qldUQFGOI+hTc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728540799; c=relaxed/simple;
	bh=kdN71VX1KmwiFusgSPdE9mvWQy+wzpae2/ob0JYb/+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA17frHwQLhi99K5Bzp2hvsvJEyfHf/AVjyuWPVaTLvXq5KkEgKV0yBzFD9ZIbpcOwoSQ1K4U3bLC8bnVu6ouN7lgI9pnw54y7jS9h8E4mEJ6uFOIJkZOm/L0pRAvZhKYgKC9hnHpCN5yFsynnk9CGkzWzyBHCDQNIjDhj0LSNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLsFbtba; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLsFbtba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728540796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BBQ/eukrCcX8vYI9lUS12CbKcIf5iCoKyIR4iaPneok=;
	b=VLsFbtba9cEXMDcIXQ38yDTcPrItV0u5iqpgNQUy3KV0UVSIMb0DRsrBo2PWIsB7RuBaZP
	FZ+YF4nyuJpDqNfZElSDovUdFTsv1/RM7ptKV2wedhFkT3jL6+tjxbz6FIZdqlzQE5UYR9
	F1PGT/ZFPqfKWukgyaY4K/XyVMomWxU=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-qDLDVBS_Ni-8kNr_ybuerA-1; Thu, 10 Oct 2024 02:13:14 -0400
X-MC-Unique: qDLDVBS_Ni-8kNr_ybuerA-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-717d286349bso13909a34.0
        for <fstests@vger.kernel.org>; Wed, 09 Oct 2024 23:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728540793; x=1729145593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBQ/eukrCcX8vYI9lUS12CbKcIf5iCoKyIR4iaPneok=;
        b=XxXwH3ENqNxpjz56sMwfnXS9i+OdnhwQg50kksIRYUwEo84klxFqH/Xm9eqCS7Fwew
         D1uGPF4dV6WgLSbwEa6DfnXMf8zLrJOji9u3WPFMMoUSNyWJ7E8AVttCUP81Jz+d5cWF
         XNC0pqizcsVkO6lcMs4fO06Y/pKGYr7AGR4yM4KGeRdC2Ktl8cxhN3kibikYDMR6q9W3
         clBeT0tlMgaUjdPekUi5Nc9sryTayOHw0wMkCSUTFahzj/TmjVAxuSXtQGVVGvAHbHm+
         quNbnt5/zdmVEubwEmBKiIeqsrpf348pIXEsEhsgO7NjOBf4A6Hp/L7RbtsDJW5p57zt
         uLKw==
X-Gm-Message-State: AOJu0YwyhyLoFHcEzNo0PeAyeUd595vM10mcUI1WIn8pEqJ0c071jc8G
	Cxiao80rENWYDE3HNHohzWSbBc88MgZYWI5upgBPeiUzCu4CSjzyXr0fTlcTalmqI310mXFmUKP
	o3glgEddpnU2YA/E19RWch2nctrKs6FNBNfo6dS4TuMc35EcrYxkGu2s=
X-Received: by 2002:a05:6830:3c8a:b0:710:fd8e:172c with SMTP id 46e09a7af769-716a41d7b24mr5464535a34.14.1728540793469;
        Wed, 09 Oct 2024 23:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjDrHkSgCeLsRe60sOoMeiN/ZUK2i1FNDVykHYGuFE0rRTMFjt9Qb0CWBO70ykJrx3QegJ0A==
X-Received: by 2002:a05:6830:3c8a:b0:710:fd8e:172c with SMTP id 46e09a7af769-716a41d7b24mr5464522a34.14.1728540793181;
        Wed, 09 Oct 2024 23:13:13 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa0c8b6sm388525b3a.92.2024.10.09.23.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 23:13:12 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:13:09 +0800
From: Zorro Lang <zlang@redhat.com>
To: An Long <lan@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic/746: install two necessary files
Message-ID: <20241010061309.7ezjkwdrfdgzthue@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <aaf23db45854222bbcfa470b25812e42a2ab9eda.camel@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf23db45854222bbcfa470b25812e42a2ab9eda.camel@suse.com>

On Thu, Oct 10, 2024 at 11:40:20AM +0800, An Long wrote:
> parse-dev-tree.awk and parse-extent-tree.awk are used by generic/746.
> We need to make sure them are installed, otherwise generic/746 will
> have problems if fstests is installed via "make install".
> 
> Signed-off-by: An Long <lan@suse.com>
> ---

Thanks for fixing it, most of people run fstests directly after building,
we need to take care the install list too.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/Makefile b/src/Makefile
> index 3097c29e..a0396332 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -38,7 +38,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> 
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>               btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> -             soak_duration.awk
> +             soak_duration.awk parse-dev-tree.awk parse-extent-tree.awk
> 
>  SUBDIRS = log-writes perf
> 
> -- 
> 2.43.0
> 
> 

