Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD2231842
	for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760726324; cv=none; b=DiqB/zaUCOqJUtLQjZVgkTb97EPGXas1Batb/53rEUiNb5gWpGyxQ9VWW+ax4uUpwalZYmWeTmzf+Pc540HiAQUNM6Q1Qr2hUo2WAdRDgzCYMZBtwrxa2lJri6+D0jmSqe11A5DVWMqSPg1YaL0xLtFM4JOV1vmgpogzCID1a/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760726324; c=relaxed/simple;
	bh=SLpa/ja4YiwbWy8iOnOXxTO05IM1w0aQFwlbs8U7ERI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJCsFdzvDWBEusoJ+Jy62MauzLCUvMu0kHMKe0uzg8up8r9f/siEg+/9KBX2SHaCPKAqp+LlL3/2iByAT5rKkoO/biRdlcwWhUdw9zVFq/RC/1TzDdf9mwygDEzq/gnaT78HpGgSFJRn9lJcyg/rWaRSlEn0z0cRzZmcuBbvha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSxUYB3I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSxUYB3I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760726321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExpLnfaK5VsN9XkZ7Guo6bIcSOrzrOYWTg0vA9xfLp4=;
	b=iSxUYB3IBl4LsKrFVtJeQbsQxsRoSSLrxnJIi7uUVDfhOcwbaASt7N477zThCd5V0gmcUC
	AiUA4EYjqFO5g76Jk6ngV38roab8i5FlzJNwwFvAnxoR2ZdL6eW7u4Lywq/B0LYifdjCEH
	D4bM4VZ3Wb3+BlKfdrFtFE8maatvm7g=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643--RMMz3LoPkmXFENzaPHa_g-1; Fri, 17 Oct 2025 14:38:40 -0400
X-MC-Unique: -RMMz3LoPkmXFENzaPHa_g-1
X-Mimecast-MFC-AGG-ID: -RMMz3LoPkmXFENzaPHa_g_1760726319
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6325a95e44so2168824a12.0
        for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 11:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760726319; x=1761331119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExpLnfaK5VsN9XkZ7Guo6bIcSOrzrOYWTg0vA9xfLp4=;
        b=g4IiHUOrMQj9Mn971F9dE8Yfh4I241v8Ss3xhKCr9IVbc06kYC14SmmkHDCw8GVdlj
         rlgzxwHAr7sP9VjRNE15Sh+RA1jLNfcBUf0wzcquSjGcbUIXYV79yI8URlRvx5LVB4nB
         N352XIETJtJ5wEcYDNkiCtB5UPsGi/bNY+LUctlRgcv1WHQMvGkNNlfDRiBJlZOHM1p0
         wYO5R0QoC7232S1xNmFIRQkei4/qKM/3rKIhhP9V5Ry0vCI+v1eDl2zd+F3c9Vehq3n2
         9ra9nt+loJs8G3t5aR1zDn/PQJVgOhQs6wz6vzcUEIayg44dgQz7QiGsoBjIWz4wwdd6
         aE6A==
X-Forwarded-Encrypted: i=1; AJvYcCUVAk2MOiMDA6DBPO7Uo+xbmWWBT45HjNIwQJq7w3+SK/y94ymfEK42PhMIUE9muhFhu26zLg4S@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+cgK8NfoA/D5zn5vYUojqeynkZgMmY6N2TJLTvouWuXsS9Dxb
	ndiRa0ndTXmTDnT4zelInplQSI+Y7mttrk9ZKUfEEWAAAGDEyrnOXtZyVtIlY8naqnSn/xLBd13
	Vw+MTqfwoTHWcHWadorCCwEURmK2umfqLAgBor7nsOYIdYId+RY6ASqlC2N+tTlH8onk=
X-Gm-Gg: ASbGncsOmfS5bd1AisJeIdOWWam/1sMi3F9iWWJoV/02XcOHBtSsPeCJUjq28crXFAf
	uFl8TAo/736x+9Erf1Tc3E8G3Q1wEJ9FBSAyycrEtPRorviZCG0QdMJlSjwUNVU2BrXQ5hHzfVu
	6yZKpQmDLGlenaUNKxS8TKNjuprulHaZQjHmksqmyjf9x5NtkoymPtj38wFr8xUVLOrRVhtH3wW
	aj+AsTwQO/tjKQwbMjTg3Q4aSPOId0A5vk8ebpuRaqwGmwqDGPXtmdDnm3jnclN06yCKAQQrybE
	Q6ldfOXXqpZcXuJBTV3zBxj17OZZ4TYjKxSPUlBgHPgHJJi2iLGw43J4FKvHma6LqXbik1X94Sp
	+6X9G8rva6I9EAYv2G17dFaNEcF67WMjYma1ELBY=
X-Received: by 2002:a17:903:2f91:b0:265:62b6:c51a with SMTP id d9443c01a7336-29091b8e553mr86886755ad.23.1760726318483;
        Fri, 17 Oct 2025 11:38:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlSps9FM2fsaq1q0PxHLN6Yrh13diUDUi+9KW4jhFsK/IZsntt/GxiVsHdicvvaVrGZmRupg==
X-Received: by 2002:a17:903:2f91:b0:265:62b6:c51a with SMTP id d9443c01a7336-29091b8e553mr86886555ad.23.1760726317945;
        Fri, 17 Oct 2025 11:38:37 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5c00sm1973365ad.74.2025.10.17.11.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 11:38:37 -0700 (PDT)
Date: Sat, 18 Oct 2025 02:38:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v5 2/3] common/zoned: add helpers for creation and
 teardown of zloop devices
Message-ID: <20251017183831.pszgljhi7zwotslg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-3-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016152032.654284-3-johannes.thumshirn@wdc.com>

On Thu, Oct 16, 2025 at 05:20:31PM +0200, Johannes Thumshirn wrote:
> Add _create_zloop, _destroy_zloop and _find_next_zloop helper functions
> for creating destroying and finding the next free zloop device.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/zoned | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/common/zoned b/common/zoned
> index 41697b08..313e755e 100644
> --- a/common/zoned
> +++ b/common/zoned
> @@ -45,3 +45,55 @@ _require_zloop()
>  	    _notrun "This test requires zoned loopback device support"
>      fi
>  }
> +
> +_find_next_zloop()
> +{
> +    id=0
> +
> +    while true; do
> +        if [[ ! -b "/dev/zloop$id" ]]; then
> +            break
> +        fi
> +        id=$((id + 1))
> +    done
> +
> +    echo "$id"
> +}
> +
> +# Create a zloop device
> +# usage: _create_zloop <base_dir> <zone_size> <nr_conv_zones>
> +_create_zloop()
> +{
> +    local id="$(_find_next_zloop)"
> +
> +    if [ -n "$1" ]; then
> +        local zloop_base="$1"
> +    else
> +	local zloop_base="/var/local/zloop"
> +    fi
> +
> +    if [ -n "$2" ]; then
> +        local zone_size=",zone_size_mb=$2"
> +    fi
> +
> +    if [ -n "$3" ]; then
> +        local conv_zones=",conv_zones=$3"
> +    fi
> +
> +    mkdir -p "$zloop_base/$id"
> +
> +    local zloop_args="add id=$id,base_dir=$zloop_base$zone_size$conv_zones"

Are there more arguments for zloop creation, if so, how about add "$*" to the end?

> +
> +    echo "$zloop_args" > /dev/zloop-control

Can this step always succeed? If not, better to _fail if the device isn't created.

> +
> +    echo "/dev/zloop$id"
> +}
> +
> +_destroy_zloop() {
> +	local zloop="$1"
> +
> +	test -b "$zloop" || return
> +	local id=$(echo $zloop | grep -oE '[0-9]+$')
> +
> +	echo "remove id=$id" > /dev/zloop-control

Same question, can this step always succeed?

Thanks,
Zorro

> +}
> -- 
> 2.51.0
> 

