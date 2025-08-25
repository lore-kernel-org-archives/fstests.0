Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1782FF64F
	for <fstests@vger.kernel.org>; Mon, 25 Aug 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138095; cv=none; b=GpkFFaIRoyJjabE3CnjH2HCSW8yUBom16ci6mTl2eWKl+dawqMjiWR/UOs0j/53BJcVFDTmKgaqyDFs3XUSXmGiWya8/P2mkD2F6My9/eJZm2Aq0UiNBRry498AHZcNeflBZxaDwklxdSIUSQ5576LXV81eJprz8mSeFdqQwioU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138095; c=relaxed/simple;
	bh=lx8unmZZotH1lOPOwGBWaz+oEXYueOAZnio+N2QuHm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiQhHaXdjTUHSCnx9HlOFGY4dD7Ji/VE4keRdIpac38VZYpVwr3WpbusblBBQ6kKLpcRWOnJo8jDtCdmnKb78IbeIz+bqo6QzQu7z9yppqQH4o8Dp1JJyb8sAcUMKv4Yqvp8ozh/jdIkpp+fs/E2V7lfh+A4a/DfaRVY0Z6iNWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aAPKs58T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAPKs58T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756138092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S26mrjD5N2pdJld3xZ+GOHAoTX+ohujbOU33KruSQAI=;
	b=aAPKs58TzQhtc0je8KghmU6FG7wRafWB4AGY8weOP8zAbxYb0TF3sExski+kWOl8W+xlov
	fUvXQGTV7ozNqmD5bIYi8UsUNUmxDIa9WuMeZGp2N40+vIHlGywFpRPDgHxta1y0RitEX6
	q1CeGy98OEfonk5mMOO+QjlAprNL8ZU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-P3-RVSbvN0SBH9F3HZhZvA-1; Mon, 25 Aug 2025 12:08:10 -0400
X-MC-Unique: P3-RVSbvN0SBH9F3HZhZvA-1
X-Mimecast-MFC-AGG-ID: P3-RVSbvN0SBH9F3HZhZvA_1756138087
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b47253319b8so3444721a12.3
        for <fstests@vger.kernel.org>; Mon, 25 Aug 2025 09:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756138087; x=1756742887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S26mrjD5N2pdJld3xZ+GOHAoTX+ohujbOU33KruSQAI=;
        b=u/264Op7ac3lnh4JsaWziN7npUxodGTrOZElpRIBI+k6DhLEWB0PbtS5olaLI9eApO
         DWoHWshuZqK+aMvzgJBKXBZBCXt/H66OV7Cxk5eeoOGxJMu9Mj7SMrRDk/W0ADgE9NRw
         gU+7/g78PSA8mjuaj+U66D9/IeNcBNlz6aXVYSrwoM/WGI0Mop8G7EqpFKocP8QMYqMh
         E5JwSGMgkFkEIbNxZfPlsGNZBCkuoNFgmiLcuipADBPyvVIzjn9KnbUR8fP0w+V4cUbn
         McDsse8VrpTxgGc2CMjwicp2/gmA2LBFqLjhay4v4is5Frs0fyX2MiA/mvJ/Yc4o24So
         WSUg==
X-Gm-Message-State: AOJu0YxB2JD9T98M3VXkTQCczDzIwTPsCW0ogry2J+OAxvWRUWTgyWSa
	DV5ISThyEouJBXh5IXBX7dkaT9c+4t9iFa/pa77gl2qsKJHE3AzbOToSDwv64x/WGfW9GkshvHi
	ge2DMeMdLfs8bn+H6SuIYAEDlsLUJSG4BHPinaw2rSSeSFX1hv26U7xTEm5g=
X-Gm-Gg: ASbGncvc+GB9JLkzH1TaEMc4sNaERTfmMYNlAhpns4UguBYmG2quhJVf6r+NukyhmJs
	rBzZy3alyvv4AcXLGEBBQh/TGromMHZx60lt0l2FFzLf+iirRbfG5bPSymFfRpCK/gt8sKxgmPe
	gdqth1+qMWY/XLfTimu1i3LzOnKHJ1Zfv21TG2Y7Mdm8WwY9KusbxQ/vE8RDNdzVg1NSbMo2zTg
	Q5ozwI4pkP/AlOoaUwYqZ91arY2PH9uRGsdtYw1jcYnnsmXMyoWpj8QFcihGYHh66inpZ8aLFuQ
	war1tb39UzLS8L4w0woK9z6Lh03s8A9M7Thfc1PzKvQU9wkMr5fduNuM7+7456UyjEyT9FtIRgH
	yrei9
X-Received: by 2002:a05:6a20:7fa7:b0:220:631c:e090 with SMTP id adf61e73a8af0-24340884ecfmr17792506637.0.1756138087332;
        Mon, 25 Aug 2025 09:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuGQjcHakFAYSJasLNIwmwH5AbB+ig9C8K1dte2zhi+ECS9Vuy2ZlNckCYG18AokysGYZ0Zw==
X-Received: by 2002:a05:6a20:7fa7:b0:220:631c:e090 with SMTP id adf61e73a8af0-24340884ecfmr17792475637.0.1756138086873;
        Mon, 25 Aug 2025 09:08:06 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7c09fsm6956388a12.26.2025.08.25.09.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 09:08:06 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:08:01 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <20250825160801.ffktqauw2o6l5ql3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>

On Fri, Aug 22, 2025 at 01:32:01PM +0530, Ojaswin Mujoo wrote:
> The main motivation of adding this function on top of _require_fio is
> that there has been a case in fio where atomic= option was added but
> later it was changed to noop since kernel didn't yet have support for
> atomic writes. It was then again utilized to do atomic writes in a later
> version, once kernel got the support. Due to this there is a point in
> fio where _require_fio w/ atomic=1 will succeed even though it would
> not be doing atomic writes.
> 
> Hence, add an explicit helper to ensure tests to require specific
> versions of fio to work past such issues.

Actually I'm wondering if fstests really needs to care about this. This's
just a temporary issue of fio, not kernel or any fs usespace program. Do
we need to add a seperated helper only for a temporary fio issue? If fio
doesn't break fstests running, let it run. Just the testers install proper
fio (maybe latest) they need. What do you and others think?

Thanks,
Zorro

> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  common/rc | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 35a1c835..f45b9a38 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5997,6 +5997,38 @@ _max() {
>  	echo $ret
>  }
>  
> +# Check the required fio version. Examples:
> +#   _require_fio_version 3.38 (matches 3.38 only)
> +#   _require_fio_version 3.38+ (matches 3.38 and above)
> +#   _require_fio_version 3.38- (matches 3.38 and below)
> +_require_fio_version() {
> +	local req_ver="$1"
> +	local fio_ver
> +
> +	_require_fio
> +	_require_math
> +
> +	fio_ver=$(fio -v | cut -d"-" -f2)
> +
> +	case "$req_ver" in
> +	*+)
> +		req_ver=${req_ver%+}
> +		test $(_math "$fio_ver >= $req_ver") -eq 1 || \
> +			_notrun "need fio >= $req_ver (found $fio_ver)"
> +		;;
> +	*-)
> +		req_ver=${req_ver%-}
> +		test $(_math "$fio_ver <= $req_ver") -eq 1 || \
> +			_notrun "need fio <= $req_ver (found $fio_ver)"
> +		;;
> +	*)
> +		req_ver=${req_ver%-}
> +		test $(_math "$fio_ver == $req_ver") -eq 1 || \
> +			_notrun "need fio = $req_ver (found $fio_ver)"
> +		;;
> +	esac
> +}
> +
>  ################################################################################
>  # make sure this script returns success
>  /bin/true
> -- 
> 2.49.0
> 

