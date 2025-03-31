Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628E20296C
	for <fstests@vger.kernel.org>; Mon, 31 Mar 2025 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429204; cv=none; b=or1IaOSPmJYwa6DQFrsi47ZlgY6+agFwITkzSCSlhnjFfroJwvn0GU9HhXHzsWBhZRD1umPzhkIykpJ0Q+Z1h8WFbyogs/Z7bmNH7PSHGYnLxENxHpD6CvRPQ9mTzNUF8NOhs0x85snElk+AVcDSxwpheI5G7C3hmrU3j+dyhF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429204; c=relaxed/simple;
	bh=Epbg3tX+e++/J3j0K5iwu29F/ZAM8FRe+mjxJntxnso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP1YNLtYBMHSg2ndDkx0WUHp+r/PoMWFda0aIwi9uQ84SgA5z151CUGMtwt0bwqVaUTCyQIT/paQyzXQPwtSBJ0pjIZ+/nHfrb6KHbOPvYmBn7MSpuaLc9KjHVLxlS6ffPGEfZLXm5J/o3o78amnlDIfAyf6s1ZbYpA8ryHAGi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NeVDLwzU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeVDLwzU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743429201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wJ5ci9d9i3QAlE9T7loPNwrkyVC7vDvJhOYZE9V+VB4=;
	b=NeVDLwzU5djMkh7Vm3T0aFHLFQWTPYBi/Bir5yJOh1qIPTzrsIVSOE8tBhtlRQRBUbL3+H
	pgB4iIBN4iVtsbMHdUliVuZ9Rc9kDu/F56mk0Q3CutdmHO9tZ9xBNARGqbWB0B179iSEO1
	S326x42EIuI/QW/3CCcq6CyM1cp6TTM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-MAPs1lFTPKOz4KyAg_k5Yg-1; Mon, 31 Mar 2025 09:53:20 -0400
X-MC-Unique: MAPs1lFTPKOz4KyAg_k5Yg-1
X-Mimecast-MFC-AGG-ID: MAPs1lFTPKOz4KyAg_k5Yg_1743429199
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-227ed471999so70188005ad.3
        for <fstests@vger.kernel.org>; Mon, 31 Mar 2025 06:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743429199; x=1744033999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJ5ci9d9i3QAlE9T7loPNwrkyVC7vDvJhOYZE9V+VB4=;
        b=a+Ib7WzPLwpCWtCOWbU3JZ9A+VIft8bgIZECNdHVQzDQkA6uWscDHBLFrPEzFF42Op
         aYOObwXKeLWhCSbAwYesV+ID9XRNO2Avz1rUHFxZQZDeTwLsMMu9ugoy+UkBJ15II9tT
         2A6i7vvwduxq51o+T9NJiyOHVPle600XlB37DkHa8opndT+7YmB5DODXdhbT/fLn9NWW
         ynOB54ixQty+NuwWdpO6LlmnpUqrCRU1xt9ZJGtA2AMxsMMbOXRF/gAYgA09I5HupE4S
         /FzJ1tJmjavMeoth0CYCMLMSEA0hKQjIEf2Q3G1SFjmRqnvserS418rrX6h6SkJvOsGy
         i2ng==
X-Gm-Message-State: AOJu0YxPPt34ySIn5fKnGoGTUpZX9ZWNwreKcZE4x94Kh9w3Z5KPTLi7
	VgVLyaxeDIrUSRZ3AfVvX05VWSM06To/fY4W5gs+1+rbpOmY47dvvTUNz2uEJepxuzxtI8ZXTWQ
	yYcHlflTYT2JYSIXsKFUH/UAARU+6NYuVYw3qSYHSGEIEQVXzMs/55/o=
X-Gm-Gg: ASbGnctP2xmRAcDod0VPWKlwN48btawaEUzZXinY/Zr7fjfGJGxqJlA6d6RCiANNrZu
	96zJGty5sruoAFEGWEJRgmAlRzg8AWg39X0JJZx+KmTnJkbviJhFN81rDHrzp7XWBfloRlS+s+9
	9uCSytH5B09NiMZ+5hAl8UX6HnKSD884etvG8zrJ84ftDxBI39w8lPZhEbULI3jfqjFIC1QhOdZ
	kyEkrZXtk6tILHG30YdnbOiS+mrBtW3HHtzAFiyT/BnWI/ix/PBiLZEmcfvEmH4qwG8G9z+eov8
	jSnQvw74BISYOEld8tOKZTOshZbdQg7WkZsHoSusWJjHaGuZ+rNUgYvo
X-Received: by 2002:a05:6a00:138e:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-73980324787mr14752164b3a.4.1743429198995;
        Mon, 31 Mar 2025 06:53:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfGE6aMaC2DvBG2/2NeEPugbdXkF+GdkMUuSthBmFuebO92LsscAWzBiMR3tYsuZjKgRrtuw==
X-Received: by 2002:a05:6a00:138e:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-73980324787mr14752128b3a.4.1743429198576;
        Mon, 31 Mar 2025 06:53:18 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e271absm7189063b3a.51.2025.03.31.06.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 06:53:17 -0700 (PDT)
Date: Mon, 31 Mar 2025 21:53:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	david@fromorbit.com, djwong@kernel.org
Subject: Re: [PATCH v4 2/5] fstests: filter: helper for sysfs error filtering
Message-ID: <20250331135313.znre7np5vss3hrl2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1740721626.git.anand.jain@oracle.com>
 <c8389fe873ff3cbf68d1f6b5a6df8d6fc0645f9f.1740721626.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8389fe873ff3cbf68d1f6b5a6df8d6fc0645f9f.1740721626.git.anand.jain@oracle.com>

On Fri, Feb 28, 2025 at 01:55:20PM +0800, Anand Jain wrote:
> Added filter helper to filter sysfs write errors, retain only the
> error part.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/filter | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/common/filter b/common/filter
> index 7e02ded377cc..44ba2b38c21d 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -671,5 +671,14 @@ _filter_flakey_EIO()
>  	sed -e "s#.*: Input\/output error#$message#"
>  }
>  
> +# Filters
> +#      +./common/rc: line 5085: echo: write error: Invalid argument
> +# to
> +# 	Invalid argument
> +_filter_sysfs_error()
> +{
> +	sed 's/.*: \(.*\)$/\1/'
> +}

Maybe output the "echo: write error: Invalid argument" or "write error:
Invalid argument" is better. But as there's not more requirement for
this helper, for later two cases, this helper is good. We can change
that when we have particular requirement.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
>  # make sure this script returns success
>  /bin/true
> -- 
> 2.47.0
> 
> 

