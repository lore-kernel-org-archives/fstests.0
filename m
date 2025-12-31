Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3863115B5
	for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767221391; cv=none; b=C+G8lE0WbMJRGicQl/FyHYOFPj4SOHLGLjie+/OoVJNNaR7v3jDTYtf2NjOwri4gfpF/EiILfQPAYclAgyrzlWBD/6dZbJqpqO7de+YpXKqzLlTbA6qopCoMIjhADiDR2A35LLHp9CdU40+lxUEoZyc9O4Mg16v2YM1JoXPk4TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767221391; c=relaxed/simple;
	bh=TPaLaE/VATs7DF+xFjPkCAcNnt/jKPcnLWXvoxdeEoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuT96cxXXnmCisD0ArBwA75yGnoDslJdre3ZCEjldJ+ifuYgiHDwvjl7Jcgv0UU2cZC0+NCQymYsjrE6ACt6KTLsDnU50X131kaM3uNImneCwtC786P2hQXL1vS/qBwVSTpNc/KZqw3Ohav9f/xHzYsDPFdmfZt31IhME3oBJGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+M/CYp5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mwPmqrcQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+M/CYp5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mwPmqrcQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767221387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6GKpgzl+uEYOc1cCsJPOvSPKEZjCVA9sg/IZVkE1Hw=;
	b=Y+M/CYp5KmEFsnz0ZGZlW9QIKdEHFlDOA0K4u9Mdw8UvlNl2YQlLhvUAcroD8zCZyyy88t
	K8kEMjVmM0RA0ixXosu3RGmb6I1jszmFHvFrh+VOMmNUnpGglN+F/mUiqjWtkQ5CvZMNGK
	yawbS/RUzAyfUXKpAraOdgdA0C/sTvI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-RemJaHaBM0SgBbdQffyXXw-1; Wed, 31 Dec 2025 17:49:45 -0500
X-MC-Unique: RemJaHaBM0SgBbdQffyXXw-1
X-Mimecast-MFC-AGG-ID: RemJaHaBM0SgBbdQffyXXw_1767221385
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c904a1168so24305155a91.1
        for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 14:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767221385; x=1767826185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6GKpgzl+uEYOc1cCsJPOvSPKEZjCVA9sg/IZVkE1Hw=;
        b=mwPmqrcQGj5CSCXlOm6y9pqr5qMTAdYedpI5F+A3IMDwSBlARHRXFZXwHWduzWODHJ
         71Hau0kt24bJmDllYk7+p9UzgVU4QoEIoGjYHOaofW4SrLhgyZAkhsYtbLF3jobk5+IE
         k8z2toqEBSFW8DS81JQz1GK1DGEKd94QLZB4XGPTLmbJpIphJkO/BBuBWfMAvm8fY0TL
         zK1ex/9QVz523yHLhHOTcMi3voLtEvWd+AphTfQyqfBhE3MU9Dip+Xapb7V4wruGGhhJ
         7e0EXHXWRBNwII+Z5noNdN5SOAS1XYiFcZZui8mTJJyImfgiZNDjm1R8bRNw8gQ9yOar
         OABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767221385; x=1767826185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6GKpgzl+uEYOc1cCsJPOvSPKEZjCVA9sg/IZVkE1Hw=;
        b=YQHPXa35XzUpuqXW8Q7tQhi4AsikB5dxVOWroI7aq0SiwkkaVLAOELtqEjxyUA1N9P
         Z2uriANbo4K6BEoiXkPj6wwOBoXCIWJyUv2NMSQ/9BB4xTqBYurJxKJEmDGsjaeItlk+
         3ce+yeXabKPxlgOQ7S96yilgja1D7yhmtFq/anqZdZSFZZqRz3GByYrn4RUTIXFHiDD0
         GH4d7Vukav46C++5jIOVs97GT2GsCdSFiY6yF0i/QhO1EU4HIPWIzt+1V4du72DsZ3Xv
         mRIO+MKY7TbLl+VXLW3Jfaqw6C5ecMYw2c5Gis9m7FkpKzPo9AqquoWooxMaxoPg2RUN
         +h0g==
X-Forwarded-Encrypted: i=1; AJvYcCVcJ18+VtDDI17p57HYAk0BKZvWhKYlNEQSP7VgvWzaUiqZDe10GY3YgYwm7EVSmAH/FiNbppaW@vger.kernel.org
X-Gm-Message-State: AOJu0YwaxZTMkaeWWp0nWjh8IlNrOjQccbwOrEFU7V+a/bXVthnC2Gsm
	pLeftb7Vc5etlgpXJnheMzBpdj6fxqA7PMxPaolkVII04sE6/UZQ2mAzFeBoJvKbzkbCjL3hOOo
	8abZA4so1TJZWxjw6NVGiq7tpYw8OChXGgsTFFS3g7NvJids8hJJqdcO09fE=
X-Gm-Gg: AY/fxX550s/yZABb2OPt6AYR2/HSJxKlTGHX9Qjh3U3HEdcmxCdxyMe37Rxkk3Kw9Km
	3wpl42v069xF0Ht3/Ap+4u59PAsMf/SjVvCoY2vt2Pv1UAxSzF6T32NPUKl5i1BCfBkieqfnPyC
	tfENTILdl85sawITaLQrqbce6eZatTSklW9SBt7lcr9/Q3vp1mKHWSfILO23Mv59X4+4XcLgA3k
	+NpiUztlFZ5wSKkjyIVY3Xcj3Y1FjO1jUIyokj6eKOG1wzbv9FoxjwtC83vEprJPXO1xS6V5e4v
	IByK0W+SApK8A8GafBjkN4qJzMDQKZEmpS0SycIdiDua2qC8I4MIirY1PJZTDLD3Mps5PcsP7e4
	05AHq9n5nQR8a/pXyLNJuuBJ4bck8dI9wONZmygyKA1gGKFJR7Q==
X-Received: by 2002:a17:90b:56cb:b0:341:abdc:8ea2 with SMTP id 98e67ed59e1d1-34e9220008fmr34597031a91.37.1767221384750;
        Wed, 31 Dec 2025 14:49:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIYaURwXAcaI0COgfWMrpbKyUkKD+aSVskVgccKJOH+tWiGzepanBLjAa7XKP4FJlWWfuZwg==
X-Received: by 2002:a17:90b:56cb:b0:341:abdc:8ea2 with SMTP id 98e67ed59e1d1-34e9220008fmr34597021a91.37.1767221384284;
        Wed, 31 Dec 2025 14:49:44 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9219f165sm33493132a91.3.2025.12.31.14.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 14:49:42 -0800 (PST)
Date: Thu, 1 Jan 2026 06:49:37 +0800
From: Zorro Lang <zlang@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com, fstests@vger.kernel.org, zlang@kernel.org,
	Slava.Dubeyko@ibm.com
Subject: Re: [PATCH] generic/020: limit xattr value by 3802 bytes
Message-ID: <20251231224937.uu67l76cytcd36ns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251224002957.1137211-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224002957.1137211-1-slava@dubeyko.com>

On Tue, Dec 23, 2025 at 04:29:58PM -0800, Viacheslav Dubeyko wrote:
> HFS+ implementation supports only inline extended attributes.
> The size of value for inline xattr is limited by 3802 bytes [1].
> 
> [1] https://elixir.bootlin.com/linux/v6.19-rc2/source/include/linux/hfs_common.h#L626
> 
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> ---
>  tests/generic/020 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/generic/020 b/tests/generic/020
> index 8b77d5ca..540f539b 100755
> --- a/tests/generic/020
> +++ b/tests/generic/020
> @@ -168,6 +168,11 @@ _attr_get_maxval_size()
>  		fi
>  		max_attrval_size=$((65536 - $size - $selinux_size - $max_attrval_namelen))
>  		;;
> +	hfsplus)
> +		# HFS+ implementation supports only inline extended attributes.
> +		# The size of value for inline xattr is limited by 3802 bytes.
> +		max_attrval_size=3802
> +		;;

Glad to get supportes from HFS list, this patch looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  	*)
>  		# Assume max ~1 block of attrs
>  		BLOCK_SIZE=`_get_block_size $TEST_DIR`
> -- 
> 2.43.0
> 

