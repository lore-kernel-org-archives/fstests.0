Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC98A51C55
	for <fstests@vger.kernel.org>; Tue, 27 Feb 2024 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709010659; cv=none; b=RSV4NoL/fM9kiInQdbm6Oko0jWI6RB5sLYRzjJ4ZtOnxzKm0Cq6SdFCqYPBQfkH/sG5O0ZWeQaOWMTpYrBwbX5moNFZFZrldJXgvo3fBg0vegnl+otALeWH1rFnOLGdPBZpboqIylzkta9kM7FpfEqfiGhW8QsqSbT4Ht9baKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709010659; c=relaxed/simple;
	bh=FSVotyAvgV+xn5aVoLZ+CfYH1wGm1W6JDEBz3wjMgXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJ28Wwr1G/75c2NC5+z83v+ucSaWiEUGQwO15GQO+mikt87Fs1D6YRpRX6+8d2PEOevBY7gxV1BHTEQHd3yMbDcdeupZ0nV/cIu64TUZT/U4EiRPj48BVos7Tr7WW8s9CQcHv0mfjRgtP8kRbtm1s5tOXJRvWqy7XiElrI91baQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPOZwCXL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPOZwCXL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709010656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9UKbUVmfg7rYiZ6YYythOWw2tRNdaLWQiIUax/Sx3TM=;
	b=jPOZwCXLJgm9X+pX4sAoAwz7LCPDQQ7ylL/KzixMd/PrFvHJL7jcXYz+xS4lMhhDMTT7Hj
	FJ9aoOHOin36XOnrSiTipSmJoaVAnaJXq50NqWUrX3163hZZTQPVOojYNTu210smj3DDBj
	Zloa+EZ5Ps54Voabqm9hHGRxdP76KiM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-BKsjwP2IPlGVlMO59-TmRg-1; Tue, 27 Feb 2024 00:10:54 -0500
X-MC-Unique: BKsjwP2IPlGVlMO59-TmRg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-299462e83bfso2912649a91.0
        for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 21:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709010653; x=1709615453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UKbUVmfg7rYiZ6YYythOWw2tRNdaLWQiIUax/Sx3TM=;
        b=oMm15EKLp7m3SzFPbIOdJmBdbfFm67TNHMs249uTGI6S6MahRNGUYOs4RJ4jhEzwux
         QrdxSd3yV1IroA+KCMecRVNCSdYZl4qztIzrC730hot7zkpn2Tg7YbUDF6f80gKnF3KM
         vsUb0NG6SP2Uebrwbq7dV33tdFVBCJxlhQ3F3ie0pW0cMjbEeHgNrzVqHEC/l/VrtyUy
         1cgeEndizc/9qSrmIcaphCR2GNABivyQI8WOlhSR9U6NUXL3S39LTNixD4xjDQDodHC+
         eZJ4+sKmm1i9wpILg2cmZkqrw29Eeqhr5x35JyKzU4XTUPnajZZu9OPNf1EUWDRCZrXj
         qnmw==
X-Forwarded-Encrypted: i=1; AJvYcCXwWmhWBHxRBzwtEmRGLmzAXNg+G+N9587zaMASommGTi8k1XkVvs7DGZLp/GCCyKXJkazrzICuyy++iZGoh/v3TZTxRHaXmg==
X-Gm-Message-State: AOJu0YwH1sH2/bPOapqZd4EgryVO5QQuRx4In6xzGW7MnawL05laT+H2
	1w2wTBGJXbLBNRozeuLEbTcymwjtx9r06wMmzF8EBMJo/WriTbNrGcUx0HHiLq+JAMjwxzdkm4G
	dNh9lRO79lTmond6g9qBgOkbxWpYdjuS4qB6BRz2Ra+u6TrRFL+oRSYs0lua458MJ9g==
X-Received: by 2002:a17:90a:f48b:b0:29a:7100:2519 with SMTP id bx11-20020a17090af48b00b0029a71002519mr6716838pjb.35.1709010652967;
        Mon, 26 Feb 2024 21:10:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGUHpH4/EQNYyazBorgO9isXCFqIXFmrElMB2zvliiLSm2TB11Hzh/KMnjMNTnp9SoH1BP0A==
X-Received: by 2002:a17:90a:f48b:b0:29a:7100:2519 with SMTP id bx11-20020a17090af48b00b0029a71002519mr6716824pjb.35.1709010652624;
        Mon, 26 Feb 2024 21:10:52 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fv6-20020a17090b0e8600b0029acce2420asm2364602pjb.10.2024.02.26.21.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 21:10:52 -0800 (PST)
Date: Tue, 27 Feb 2024 13:10:49 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, guan@eryu.me, fstests@vger.kernel.org
Subject: Re: [PATCH 6/8] xfs/122: update test to pick up rtword/suminfo
 ondisk unions
Message-ID: <20240227051049.yzojj3n3qtwiag2t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <170899915207.896550.7285890351450610430.stgit@frogsfrogsfrogs>
 <170899915304.896550.17104868811908659798.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170899915304.896550.17104868811908659798.stgit@frogsfrogsfrogs>

On Mon, Feb 26, 2024 at 06:02:05PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Update this test to check that the ondisk unions for rt bitmap word and
> rt summary counts are always the correct size.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/122     |    2 +-
>  tests/xfs/122.out |    2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/tests/xfs/122 b/tests/xfs/122
> index ba927c77c4..4e5ba1dfee 100755
> --- a/tests/xfs/122
> +++ b/tests/xfs/122
> @@ -195,7 +195,7 @@ echo 'int main(int argc, char *argv[]) {' >>$cprog
>  #
>  cat /usr/include/xfs/xfs*.h | indent |\
>  _attribute_filter |\
> -grep -E '(} *xfs_.*_t|^struct xfs_[a-z0-9_]*$)' |\
> +grep -E '(} *xfs_.*_t|^(union|struct) xfs_[a-z0-9_]*$)' |\
>  grep -E -v -f $tmp.ignore |\
>  sed -e 's/^.*}[[:space:]]*//g' -e 's/;.*$//g' -e 's/_t, /_t\n/g' |\
>  sort | uniq |\
> diff --git a/tests/xfs/122.out b/tests/xfs/122.out
> index 067a0ec76b..a2b57cfb9b 100644
> --- a/tests/xfs/122.out
> +++ b/tests/xfs/122.out
> @@ -124,6 +124,8 @@ sizeof(struct xfs_swap_extent) = 64
>  sizeof(struct xfs_sxd_log_format) = 16
>  sizeof(struct xfs_sxi_log_format) = 80
>  sizeof(struct xfs_unmount_log_format) = 8
> +sizeof(union xfs_rtword_raw) = 4
> +sizeof(union xfs_suminfo_raw) = 4
>  sizeof(xfs_agf_t) = 224
>  sizeof(xfs_agfl_t) = 36
>  sizeof(xfs_agi_t) = 344
> 

