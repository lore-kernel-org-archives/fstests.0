Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC941BC061
	for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553474; cv=none; b=eUZ5v9TSNY1bLBy41RaGs2rzLHlkGHGvyD2MgKKeb5+BKyxukbYWE4/HHGsk3wQ/ZoGRyOEduKwWVK0hOKbYNf+GFONm59y5AE7Ifn8mltIAWis14XmA+mSgUpZfWeB7a/Pp2A4fT0KCuZYwSiX1W5lKZ9VBHbkQLBVcSYb+WIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553474; c=relaxed/simple;
	bh=MIbTxmLN2YA91CKFgso8A8pLsRYaIBwvDZnVZ8voL90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+OiAlAZZ4+yBIUUf384hwTMZn4DRpQS9T5uhdCBleBaCjgehyyf6qHRjCDk66oOMlLVKTBgAbqCmfMoQL/BtzLI6wP/NjWb/bU7scptYGtcwCVIIVJigDL0Q34Dhq6JIW5OQGmwhLKTuqhbZfLWLdcEBvuVnebpCi+7FMufDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTorWEGT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTorWEGT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728553471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BW+5SeWRhGoOkRnHyWeA8h41r+6blkcrZng8j8hpsAo=;
	b=aTorWEGT1+wTRz/SIjP+z50+0inisVAwFnGO+3IBXvxigEVBgbZjdh82JoCX8E0952wp39
	8p9OqWOXaOXBdtkOP/WsMOb+onkIQznu8bbiSobpMzQOpwtlgDvSbnpH6gp9FHWZ8dRwqI
	DRfYakKjYcYY/ZgBIMC3Fre4pV8zZkk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-NluBfrUSOtyWikk5WiJ-Fg-1; Thu, 10 Oct 2024 05:44:29 -0400
X-MC-Unique: NluBfrUSOtyWikk5WiJ-Fg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71de5bff982so970020b3a.2
        for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 02:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728553468; x=1729158268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW+5SeWRhGoOkRnHyWeA8h41r+6blkcrZng8j8hpsAo=;
        b=jjg7qgEv5nJwg0mSFFjk/3l6ya6WnMYZXhrxahOu8ULB6HxTxlqxskSDDRRHI7TWk+
         W0Wwlp34du/4Dy/fR34StSs4k7o/1AzSKgMaChAAXzeQaIVN7nthb+5TFDotVpalObFU
         /zzZRBiJz3+3ZCQwf4GWixyBnVyJa1skymypJx2JyFaUs7Ku2oNYuKGxEWCccWsF0M1a
         xV/717NbZaNOxXj0KU1LZjKCdKkFxdrXzqQNQwLicDCil4jvLNOu00x/SHLHHD+TZ9vM
         ESXNsP0Qbb/4ckygO6idnJT+H7rxbKy4GfwG+nLjzKSPz1tCkBmJGyE4uN+ibQ3ZxXqg
         lF+Q==
X-Gm-Message-State: AOJu0Yyo8UNlW6tUgLVuKrbtpitQeH9woifLqwkdWVCKxlyieivq8CmO
	uAtVf/cjAxWxLUG3dt+Wal0ayatH1t4jGU0al7fClhOWEI6mxJlpBv1G6BACzmV0uYktp36dNaW
	kMkjP53ppRh4q6DZR4pksrI6bukciyJWAT8JKD/wTmTj/XuELiOrgLhfmt0JCArtI8Q==
X-Received: by 2002:a05:6a00:4fc1:b0:71e:ed6:1cb2 with SMTP id d2e1a72fcca58-71e1dbb54c6mr7892425b3a.20.1728553467890;
        Thu, 10 Oct 2024 02:44:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDSYKgMc+SFDC/K0AjBVEB6Dz+BszMLYad2zI13mLdF7FV252kf+3Sb0ptDfthJiTvYT39jg==
X-Received: by 2002:a05:6a00:4fc1:b0:71e:ed6:1cb2 with SMTP id d2e1a72fcca58-71e1dbb54c6mr7892404b3a.20.1728553467401;
        Thu, 10 Oct 2024 02:44:27 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba19esm711909b3a.178.2024.10.10.02.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 02:44:27 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:44:23 +0800
From: Zorro Lang <zlang@redhat.com>
To: An Long <lan@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic/746: install two necessary files
Message-ID: <20241010094423.mnyaf5bljmeylxri@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

There might be something (format) wrong when you generated or sent this
patch, I can't merge it directly, the `git am` shows:

  Applying: generic/746: install two necessary files
  error: corrupt patch at line 18
  Patch failed at 0001 generic/746: install two necessary files
  hint: Use 'git am --show-current-patch=diff' to see the failed patch
  hint: When you have resolved this problem, run "git am --continue".
  hint: If you prefer to skip this patch, run "git am --skip" instead.
  hint: To restore the original branch and stop patching, run "git am --abort".
  hint: Disable this message with "git config advice.mergeConflict false"

Anyway, this change is simple enough, so I've maken this change manually
(with author=$you), so don't need to send one more version, just remind it.

Thanks,
Zorro

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

