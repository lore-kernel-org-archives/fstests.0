Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0127345BE6
	for <fstests@vger.kernel.org>; Fri,  2 Feb 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880662; cv=none; b=Ey61LrfKqukr1B5bZ4cSUFu7BpOM8KAHyL98VeZPlSB7ypCdURd0snhE5w4gJ9MMrIUlSx5AdIpS54iZ8HvBmsZbJFMRe5Up8fYyqh5scWyGT09x07nAmn4FGnpsKB0x4udPF32U5BLt6tmoT35MKaTCEcEa7KvFFw5OaJFbZkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880662; c=relaxed/simple;
	bh=kEzCRv+ixXxMBBwkk8hk2kXrBl/lIlm1jz+UFvPtG8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7Ec9giSHQ5ZitygKvF0/mUkd4KMbapl5IGlO2yjwu9Tq1yNsuo6dyYj8T2h4/H9Uf97rTSPLhL0zFcL5KgH1seR1F+wffkSzzwgsooM9Id4x9/ypmEWVdTxTmuyyiZlpjtjHlOtFotsKp5G97jRBM1lHK28TLoe3adhDi8vjAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcuBd29R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcuBd29R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706880659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0N2smS5XbHQrIaMH4pzHfJKZl8Z9zBqbq9w2J5wULM=;
	b=fcuBd29Rm8Yp9QwuXgOCcfqkO8+qbm2R1HxI5aqYO91DvhmL+QEfJ0XQtyGSAEdUzk4Mpy
	CWEaDgwVIIVpR7pCJ5V3Mrv04hX9lfgHpc8kYifoFM0HSzo469XIfwkWb4+vPoKdO5TOVx
	EvyrMPInEGMLADH4q/am+GNt8NI2ng4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-TzL4qi-1Mo-oN-NUmQrTIA-1; Fri, 02 Feb 2024 08:30:58 -0500
X-MC-Unique: TzL4qi-1Mo-oN-NUmQrTIA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d955acc0b5so18731355ad.2
        for <fstests@vger.kernel.org>; Fri, 02 Feb 2024 05:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706880657; x=1707485457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0N2smS5XbHQrIaMH4pzHfJKZl8Z9zBqbq9w2J5wULM=;
        b=ZO2yapUj551DuIsDsdaCrofL+nsLOkAgAw6Diu1ACYuOJoLYRU+xbbV4irzazbJCwQ
         Uizlj9uc3ezVACdr5jTeoNSBcqqbo7GL9BdfK1kIbdzExS+Ewc7VvLxh3l32oaDWDo+v
         rnZWXgzyEbqBD7yT9bhWmoo/3Fcs6WL4CnuKZg0dP4gw6RPpL9srrdvDLBMhtggfpVkW
         LkTP1i6aLoJ0zC4stqUgE9HXlBrQJrC72gYGrtNlENOnEL3Eo9RsEDnr+gPGor87vw+Y
         m2MfKB1pBfdDU06R9XTeUccQTqRPNnK1m601YIsHLTknsa7FEHSlFFiKkzZIU7vr22Pu
         u/mw==
X-Gm-Message-State: AOJu0YzmHDcDnNuMcOJtbT6IfFCDX+CWh6BctQnTqsCaaFICZ1gL+PFx
	EK8zFfUSmZ+ohF5lNGUGYYZDxxeHfGLTZjVpan267IZqwTICKlGZE38n3EwDfp/nbruEFosoRvp
	ZtAtzcd+3YqM8LvfTw5+EzfqJS+yizgi91yI631ro3AEjDpDt6EYnmH7QckDYjQKhkw==
X-Received: by 2002:a17:902:e882:b0:1d9:7095:7e1f with SMTP id w2-20020a170902e88200b001d970957e1fmr2302531plg.67.1706880656871;
        Fri, 02 Feb 2024 05:30:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMQpWf4228PFb7lWLT8LUMy0LfA6Ud2QaEP2cWIDR0jX7MJhE7n4DYSJsyjIN1hRPR/Ch0YQ==
X-Received: by 2002:a17:902:e882:b0:1d9:7095:7e1f with SMTP id w2-20020a170902e88200b001d970957e1fmr2302496plg.67.1706880656556;
        Fri, 02 Feb 2024 05:30:56 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jh7-20020a170903328700b001d8f82c61cdsm1572653plb.231.2024.02.02.05.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:30:56 -0800 (PST)
Date: Fri, 2 Feb 2024 21:30:52 +0800
From: Zorro Lang <zlang@redhat.com>
To: Richard Weinberger <richard@nod.at>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/020: Compute correct max_attrs for UBIFS
Message-ID: <20240202133052.2psftidca6rcdlmk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240114135713.10555-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114135713.10555-1-richard@nod.at>

On Sun, Jan 14, 2024 at 02:57:13PM +0100, Richard Weinberger wrote:
> When testing on a MTD with a rather small erase block
> size, the default max_attr limit can be too much and the
> test will fail.
> Instead compute the actual limit.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---

Thanks for the updating for UBIFS testing, this patch looks good to me.
I'm not a good user of ubifs, but as your the maintainer of UBIFS, I
think I can give more trust to this patch ;) So I'll merge this patch
after a basic testing.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/config     | 1 +
>  common/ubifs      | 9 +++++++++
>  tests/generic/020 | 6 ++++++
>  3 files changed, 16 insertions(+)
>  create mode 100644 common/ubifs
> 
> diff --git a/common/config b/common/config
> index c9771ff9..05f2bb35 100644
> --- a/common/config
> +++ b/common/config
> @@ -545,6 +545,7 @@ _source_specific_fs()
>  		;;
>  	ubifs)
>  		[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
> +		. ./common/ubifs
>  		;;
>  	esac
>  }
> diff --git a/common/ubifs b/common/ubifs
> new file mode 100644
> index 00000000..08323260
> --- /dev/null
> +++ b/common/ubifs
> @@ -0,0 +1,9 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +_get_leb_size()
> +{
> +	local ubivol=$1
> +
> +	cat /sys/class/ubi/`basename $ubivol`/usable_eb_size
> +}
> diff --git a/tests/generic/020 b/tests/generic/020
> index da258aa5..4951b9e3 100755
> --- a/tests/generic/020
> +++ b/tests/generic/020
> @@ -101,6 +101,12 @@ _attr_get_max()
>  			let max_attrs=$((($BLOCK_SIZE - 32) / (16 + 12 + 16 )))
>  		fi
>  		;;
> +	ubifs)
> +		LEB_SIZE=`_get_leb_size $TEST_DEV`
> +		# On UBIFS, the number of xattrs has to be less than 50% LEB size
> +		# divided by 160 (inode size)
> +		let max_attrs=$((($LEB_SIZE / 2 / 160) - 1))
> +		;;
>  	*)
>  		# Assume max ~1 block of attrs
>  		BLOCK_SIZE=`_get_block_size $TEST_DIR`
> -- 
> 2.35.3
> 
> 

