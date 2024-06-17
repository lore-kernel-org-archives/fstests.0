Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C291862BB
	for <fstests@vger.kernel.org>; Mon, 17 Jun 2024 07:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608025; cv=none; b=nCvo92FRscHPuR79WTI1MKBL+bCQKvx1FyTWSovSyvjVEqIt4kc1L6Fl6IaMN5DxjS2N1R6WpwQ/4T2tJ+8NaLEFFidGXAfjEhVj2fMYb1IbEvaMjBXHmR/RTEeJjAdt318oKYRsbNl+s1gSxbN38bCampa61DXBZ6cQLiA6wTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608025; c=relaxed/simple;
	bh=xx+kta8hclpS5Ns6HXyixihvqVBNW1Kbxd1JvZoZBrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ9oRtQ9OGSfIu6SR2jn3bvSWDAlZMyegHWsDoqZwHTkcBzpVUXPoCdHd/Gq2RCtPdQF6387+zRC9Evxvzv2P4smB2lMJr6XuSJ5GqXwSdlhKBUjnMBIPtlCxGUoARVlBWqYi0R0GgtAyXQ2DcREp4qGW6yFYAL36vpMlBKtjzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOz7fdhG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOz7fdhG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718608022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l3dp454CRZZtUKcqIm608KNriV7wRFebgfxXjmWI9XQ=;
	b=UOz7fdhGmOzdtkq5rt+tXprYp6n6kYoNlGCpruOLVHfviXLjXTxQHSHE7Fxvi8pRa+Ia0j
	0MnPEOAB46JWFm5pyoZUJekpgsrlmXX0241Gc0uPsyFm+YK2URnt6sZuwubmpzBSchhJoQ
	b8fVospWnp1VYYQcPnd8YE0oefqUWxM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-1Tk40Ii4PByLBR5tI3oKrQ-1; Mon, 17 Jun 2024 03:07:00 -0400
X-MC-Unique: 1Tk40Ii4PByLBR5tI3oKrQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7060b6e7e78so385528b3a.1
        for <fstests@vger.kernel.org>; Mon, 17 Jun 2024 00:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718608019; x=1719212819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3dp454CRZZtUKcqIm608KNriV7wRFebgfxXjmWI9XQ=;
        b=vAIVyWEIWOed6R2n5gngXcwCnyawZ7Z5OY+IRP9M3V0Jkxhh+s5PxSxPwh5uhwh7dU
         hR2+S2DYdP9kHqlUfTITtz6KXZYGRP1WrUZe3GEgqasbhLJ4Dhc8JHNHfhWhmsFtN/h/
         FrmjlQK3HgR48blk0R+F0RJGhYv575ugciax3OYUGvjftFPaFIIe6oKRG8/ar6yPLhbN
         TkCYzbg8CnAO86/1dKaejdWU2yPl+bqqT7JxnRrPzRu/awDy9jZmxdxhRwA/NFTGWJLr
         6LrY5XFRK+Mus8qgbA1cRrGCdg8873aHaHOCZqwgTorHeQ21YthPvjdIeGXJfvJsnycY
         +ulg==
X-Gm-Message-State: AOJu0Yxe8Kgf35z/q8aRSLVYniEePqA1rp2bKGee7mU8jfD+gMfaa9AE
	yOODP+uNc0XsCuzCCaqRcx2ot2R3jDp6dXDPQ4ejiMhYMWy7Ztz4ZLPzkHe5pxRSVqDIS4gM/pc
	kWJVN2e1njVwpvn6CJ1cpfuRmi7shiCLxqfLd2MujjkC18QTWV1V80Z4=
X-Received: by 2002:aa7:8a41:0:b0:705:9669:af1f with SMTP id d2e1a72fcca58-705c93fa07amr16593826b3a.10.1718608019350;
        Mon, 17 Jun 2024 00:06:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiMlkhg8yOqh0BVXTvXeM5SRnUijYblQp6RivY4yt3z+GugY9dJZr5HXgpx6J0fwOQbGr+Pw==
X-Received: by 2002:aa7:8a41:0:b0:705:9669:af1f with SMTP id d2e1a72fcca58-705c93fa07amr16593799b3a.10.1718608018764;
        Mon, 17 Jun 2024 00:06:58 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96ad04sm6839987b3a.64.2024.06.17.00.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 00:06:58 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:06:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"hughd@google.com" <hughd@google.com>
Subject: Re: [PATCH 3/5] common/rc: add recreation support for tmpfs
Message-ID: <20240617070654.t3dvlvm4br354mpv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240614061722.1080-1-da.gomez@samsung.com>
 <CGME20240614061727eucas1p20922542ef700d0f41dc9cc9628392518@eucas1p2.samsung.com>
 <20240614061722.1080-4-da.gomez@samsung.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614061722.1080-4-da.gomez@samsung.com>

On Fri, Jun 14, 2024 at 06:17:25AM +0000, Daniel Gomez wrote:
> Add support for test device recreation (RECREATE_TEST_DEV=true) for
> tmpfs. This allows to inherit the tmpfs profile extra mount options
> (TMPFS_MOUNT_OPTIONS) for the test device.
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  common/rc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 163041fea..7f995b0fa 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -457,7 +457,7 @@ _test_mount()
>      fi
>  
>      _test_options mount
> -    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> +    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $TMPFS_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR

We shouldn't use a FSTYP specific parameter in a common mount line.
Better to set it in a "$FSTYP=tmpfs" branch. I notice that we set:

        tmpfs)
                # We need to specify the size at mount, use 1G by default
                echo "-o size=1G $TMPFS_MOUNT_OPTIONS"

in _common_mount_opts(). Then it will be set in MOUNT_OPTIONS and
TEST_FS_MOUNT_OPTS, won't that help?

Thanks,
Zorro


>      mount_ret=$?
>      [ $mount_ret -ne 0 ] && return $mount_ret
>      _idmapped_mount $TEST_DEV $TEST_DIR
> @@ -604,6 +604,9 @@ _test_mkfs()
>      pvfs2)
>  	# do nothing for pvfs2
>  	;;
> +	tmpfs)
> +	# do nothing for tmpfs
> +	;;
>      udf)
>          $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
>  	;;
> -- 
> 2.43.0
> 

