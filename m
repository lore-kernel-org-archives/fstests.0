Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E8171089
	for <fstests@vger.kernel.org>; Tue, 30 Apr 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481184; cv=none; b=SZcfj5tDXVJ9+fWwGegcmX9lfsYB7HsQ7UMsUliM9iknMafQrleea1wsAIgxSv6sxLt/llFOvRN3Lw6F8bq5TDhi4F1TUosLseVhPam5wi6HtHg6m6nOfjUuIVcEX+3KusF9QXScHFuWKSb8ty0q4niQcIwapP4B4z2ylYopvNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481184; c=relaxed/simple;
	bh=uEQe05sSb8XGdNTp8LDHqlunM6px035H4FVrXb575n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOu6KrYmikXQUnA/AbSJ1G+bnmPsoRD7wifBnizwiUNkXcxs7s49J9ub/n5LzzUcNQ00Ov+IJe4dvHVM+awCaWgO/TeoKA5JdpVGLRNg+QDDQvTDiXxN3FyIuO8QHor86JnHVat3iEh2WVPf83Hsgmh+oBGYHVMMyVjwkDkvq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ApXl9xcS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApXl9xcS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714481182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WYvETdnLejW3BqSGItxHmluLcu0UqtVku9or1/S68aU=;
	b=ApXl9xcSQwbKNwvrn6jM+ppSMYve1/CtfOrSwu9RCRNxS1kjCd4odSPZuSkGjZfhbM12tm
	tCPb/eVcfUBYgm2/CakxLoC46L5RCLwWYW0T8/ri2RsCVrlmI9Yww/LT6BsgG0hCPC+OW+
	4i1sZB26kQrM/xeB9qdAs7eUWo0mDWo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-XYLY17bOOSm1JzdlhuYRWg-1; Tue, 30 Apr 2024 08:46:20 -0400
X-MC-Unique: XYLY17bOOSm1JzdlhuYRWg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a55709e5254so273965966b.3
        for <fstests@vger.kernel.org>; Tue, 30 Apr 2024 05:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481180; x=1715085980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYvETdnLejW3BqSGItxHmluLcu0UqtVku9or1/S68aU=;
        b=CbxIq0PDYuRdJctmzqN5GZnd0/rxF+apXPvGCBKBj3cjO8W4WowKHbcRZUfKcHGrWN
         ZhxRL2v2ZYOSdOoBSkqX61dZJ/3LqAUAYrTCO/VkWtOhTVPfiBjCJlB4vv/gMtuLFX43
         KjORHdDuagTCubmzQiuMyd6Oc0kqtIqMwU0k89wws7O36zvvTSgF6vBLlF0JAtf6uXGR
         mlCBfQ1TBXI8r4Gj/MeVfVIwH8Nw52u0fBShWbhJIpJycuccHJf8StIg6rRwxFYIhQNr
         ezHqQ+J6nv80q30upffDWrYOFQEzxjHihN7cPN24POpm3K6fe3vm2Aj8eqVPPLUeRrEH
         SiDA==
X-Forwarded-Encrypted: i=1; AJvYcCWNMHuCNQUPYEZfcqSHh7plpAwWzdlEEx2bLHTm0ZXvGt1jsy3Bwfx/n8HIFh6sF8X1LuyFXAIt99HWrwI0NqkK0tyti/YEGw==
X-Gm-Message-State: AOJu0YzhswFeOW1QSkQMZifhq+H1viKJyTmUeFsbbbzJhlRILDN0sPv5
	AiVA1mUF66vKBrSWyG+Plnmla3eE3cfyetFV6ZMn/4DADuFYvh8GWL3VHYX2EHSvIrEF92707Mj
	znVdiPAoWHKSQpzr5gU9U3yfu1Vs5gW2J9FeOFZj44KMgLWrSex0sfg==
X-Received: by 2002:a17:906:3e53:b0:a58:a721:3a61 with SMTP id t19-20020a1709063e5300b00a58a7213a61mr1865459eji.3.1714481179581;
        Tue, 30 Apr 2024 05:46:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2Fs7bD5hUcrtDyzCJsRl0FSh2zrk1KirHmqO2e+yYD35p9fWVrF01XM3RRG1Z9PT5wVA6Ww==
X-Received: by 2002:a17:906:3e53:b0:a58:a721:3a61 with SMTP id t19-20020a1709063e5300b00a58a7213a61mr1865436eji.3.1714481179068;
        Tue, 30 Apr 2024 05:46:19 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a522f867697sm15006627ejz.132.2024.04.30.05.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:46:18 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:46:18 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, ebiggers@kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, guan@eryu.me, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/6] xfs/{021,122}: adapt to fsverity xattrs
Message-ID: <52muvsk2z6c4gg7pghusidtu4ntot4l3unplgdvgcugll24syz@i5d2usji2wce>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <171444688009.962488.1019465154475766682.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444688009.962488.1019465154475766682.stgit@frogsfrogsfrogs>

On 2024-04-29 20:41:19, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Adjust these tests to accomdate the use of xattrs to store fsverity
> metadata.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/021     |    3 +++
>  tests/xfs/122.out |    1 +
>  2 files changed, 4 insertions(+)
> 
> 
> diff --git a/tests/xfs/021 b/tests/xfs/021
> index ef307fc064..dcecf41958 100755
> --- a/tests/xfs/021
> +++ b/tests/xfs/021
> @@ -118,6 +118,7 @@ _scratch_xfs_db -r -c "inode $inum_1" -c "print a.sfattr"  | \
>  	perl -ne '
>  /\.secure/ && next;
>  /\.parent/ && next;
> +/\.verity/ && next;
>  	print unless /^\d+:\[.*/;'
>  
>  echo "*** dump attributes (2)"
> @@ -128,6 +129,7 @@ _scratch_xfs_db -r -c "inode $inum_2" -c "a a.bmx[0].startblock" -c print  \
>  	| perl -ne '
>  s/,secure//;
>  s/,parent//;
> +s/,verity//;
>  s/info.hdr/info/;
>  /hdr.info.crc/ && next;
>  /hdr.info.bno/ && next;
> @@ -135,6 +137,7 @@ s/info.hdr/info/;
>  /hdr.info.lsn/ && next;
>  /hdr.info.owner/ && next;
>  /\.parent/ && next;
> +/\.verity/ && next;
>  s/^(hdr.info.magic =) 0x3bee/\1 0xfbee/;
>  s/^(hdr.firstused =) (\d+)/\1 FIRSTUSED/;
>  s/^(hdr.freemap\[0-2] = \[base,size]).*/\1 [FREEMAP..]/;
> diff --git a/tests/xfs/122.out b/tests/xfs/122.out
> index abd82e7142..019fe7545f 100644
> --- a/tests/xfs/122.out
> +++ b/tests/xfs/122.out
> @@ -142,6 +142,7 @@ sizeof(struct xfs_scrub_vec) = 16
>  sizeof(struct xfs_scrub_vec_head) = 40
>  sizeof(struct xfs_swap_extent) = 64
>  sizeof(struct xfs_unmount_log_format) = 8
> +sizeof(struct xfs_verity_merkle_key) = 8
>  sizeof(struct xfs_xmd_log_format) = 16
>  sizeof(struct xfs_xmi_log_format) = 88
>  sizeof(union xfs_rtword_raw) = 4
> 

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

